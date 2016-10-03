Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D4A20986
	for <e@80x24.org>; Mon,  3 Oct 2016 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcJCIiv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 3 Oct 2016 04:38:51 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:59813
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbcJCIiu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 04:38:50 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2016 04:38:50 EDT
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id qwWT1t00p4fw4HN01wWTBE; Mon, 03 Oct 2016 09:30:28 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10
 a=ZZnuYtJkoWoA:10 a=CH0kA5CcgfcA:10 a=1XWaLZrsAAAA:8 a=ybZZDoGAAAAA:8
 a=A9qS8gIqAAAA:8 a=FP58Ms26AAAA:8 a=t4is9X1GrKjoCqsdY4MA:9 a=wPNLvfGTeEIA:10
 a=nJcEw6yWrPvoIXZ49MH8:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=H28RkzuXznr5akrmL4QT:22
 a=6LVbBl2NLSWPyIBDCKCu:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id 7F097196F175;
        Mon,  3 Oct 2016 09:30:27 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
        <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
        <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZZwum+97JGL8OFWTdODZeqrEyj4MVMC6o6ynFMOhiFLg@mail.gmail.com>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Mon, 03 Oct 2016 09:30:27 +0100
In-Reply-To: <CAGZ79kZZwum+97JGL8OFWTdODZeqrEyj4MVMC6o6ynFMOhiFLg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Sep 2016 10:23:29 -0700")
Message-ID: <87mvilx2ak.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>On Sun, Sep 25, 2016 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Am 24.09.2016 um 13:30 schrieb René Scharfe:
>>>> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
>>>> warns when it's called like 'git merge <message> HEAD <commit>' because
>>>> that syntax is deprecated.  Use this feature in git-gui and get rid of
>>>> that warning.
>>>>
>>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>>> ---
>>>> Tested only _very_ lightly!
>>>>
>>>>  git-gui/lib/merge.tcl | 7 +------
>>>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>>>
>>>> diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
>>>> index 460d32f..5ab6f8f 100644
>>>> --- a/git-gui/lib/merge.tcl
>>>> +++ b/git-gui/lib/merge.tcl
>>>> @@ -112,12 +112,7 @@ method _start {} {
>>>>      close $fh
>>>>      set _last_merged_branch $branch
>>>>
>>>> -    set cmd [list git]
>>>> -    lappend cmd merge
>>>> -    lappend cmd --strategy=recursive
>>>> -    lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
>>>> -    lappend cmd HEAD
>>>> -    lappend cmd $name
>>>> +    set cmd [list git merge --strategy=recursive FETCH_HEAD]
>>>>
>>>>      ui_status [mc "Merging %s and %s..." $current_branch $stitle]
>>>>      set cons [console::new [mc "Merge"] "merge $stitle"]
>>>>
>>>
>>> Much better than my version. I had left fmt-merge-msg and added
>>> --no-log to treat merge.log config suitably. But this works too, and
>>> is much more obvious.
>>>
>>> Tested-by: Johannes Sixt <j6t@kdbg.org>
>
>Reviewed-by: Stefan Beller <sbeller@google.com>
>

The only problem I see here is that generally git-gui tries to continue
to work with older versions of git as well. So adding a guard using the
git-version procedure should maintain that backwards compatibility.

I suggest:

From c2716458f05893ca88c05ce211a295a330e74590 Mon Sep 17 00:00:00 2001
From:  René Scharfe <l.s.r@web.de>
Date: Sat, 24 Sep 2016 13:30:22 +0200
Subject: [PATCH] git-gui: stop using deprecated merge syntax

Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
warns when it's called like 'git merge <message> HEAD <commit>' because
that syntax is deprecated.  Use this feature in git-gui and get rid of
that warning.

Tested-by: Johannes Sixt <j6t@kdbg.org>
Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 lib/merge.tcl | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index 460d32f..2361b78 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -112,13 +112,16 @@ method _start {} {
 	close $fh
 	set _last_merged_branch $branch
 
-	set cmd [list git]
-	lappend cmd merge
-	lappend cmd --strategy=recursive
-	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
-	lappend cmd HEAD
-	lappend cmd $name
-
+	if {[git-version >= "2.5.0"]} {
+		set cmd [list git merge --strategy=recursive FETCH_HEAD]
+	} else {
+		set cmd [list git]
+		lappend cmd merge
+		lappend cmd --strategy=recursive
+		lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
+		lappend cmd HEAD
+		lappend cmd $name
+	}
 	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
 	set cons [console::new [mc "Merge"] "merge $stitle"]
 	console::exec $cons $cmd [cb _finish $cons]
-- 
2.10.0.windows.1
