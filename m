Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD98207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbcJCXPp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 3 Oct 2016 19:15:45 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:40495
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbcJCXPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 19:15:44 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id rBFh1t00n4fw4HN01BFhQF; Tue, 04 Oct 2016 00:15:42 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10
 a=ZZnuYtJkoWoA:10 a=CH0kA5CcgfcA:10 a=A9qS8gIqAAAA:8 a=1XWaLZrsAAAA:8
 a=FP58Ms26AAAA:8 a=Rf460ibiAAAA:8 a=hOve97WsGiNgDeeztX0A:9 a=wPNLvfGTeEIA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=H28RkzuXznr5akrmL4QT:22
 a=nJcEw6yWrPvoIXZ49MH8:22 a=6LVbBl2NLSWPyIBDCKCu:22 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id AC98A1960AB7;
        Tue,  4 Oct 2016 00:15:41 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
        <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
        <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZZwum+97JGL8OFWTdODZeqrEyj4MVMC6o6ynFMOhiFLg@mail.gmail.com>
        <87mvilx2ak.fsf@red.patthoyts.tk>
        <5283506a-9399-6ddc-d714-1dd9d2b49704@web.de>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Tue, 04 Oct 2016 00:15:41 +0100
In-Reply-To: <5283506a-9399-6ddc-d714-1dd9d2b49704@web.de>
 (=?iso-8859-1?Q?=22Ren=E9?= Scharfe"'s
        message of "Mon, 3 Oct 2016 11:45:46 +0200")
Message-ID: <87int9t46a.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>Am 03.10.2016 um 10:30 schrieb Pat Thoyts:
>> The only problem I see here is that generally git-gui tries to continue
>> to work with older versions of git as well. So adding a guard using the
>> git-version procedure should maintain that backwards compatibility.
>
>Makes sense for a stand-alone tool.
>
>> I suggest:
>>
>> From c2716458f05893ca88c05ce211a295a330e74590 Mon Sep 17 00:00:00 2001
>> From:  René Scharfe <l.s.r@web.de>
>> Date: Sat, 24 Sep 2016 13:30:22 +0200
>> Subject: [PATCH] git-gui: stop using deprecated merge syntax
>>
>> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
>> warns when it's called like 'git merge <message> HEAD <commit>' because
>> that syntax is deprecated.  Use this feature in git-gui and get rid of
>> that warning.
>>
>> Tested-by: Johannes Sixt <j6t@kdbg.org>
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>
>OK, but perhaps move me from From: to Original-patch-by: as the
>version check is a big enough change in itself.  Or add a separate
>commit for it.  Or at least mention that you added the check in the
>commit message.
>
>Thanks,
>René

As this is one of the ones already staged to git's 'next' I'll make this
as a separate commit on top.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
