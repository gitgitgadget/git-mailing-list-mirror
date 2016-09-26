Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2CB207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034765AbcIZRXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:23:32 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35604 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030192AbcIZRXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:23:31 -0400
Received: by mail-it0-f52.google.com with SMTP id r192so80735994ita.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A+WOhnazYsfzDuASZnwhsI2oNJNNtzpB9SdiRw46FP4=;
        b=hotTp88qvNAysnD7o3J2NHQVYpzQORcNkIMlTcFLqy3w6dJtSacU1iR5JVstvtf82k
         ZXMmaLv/xDATXDgybrj31SbLnErhI4ejEY7ASuto0Q/zq3Yx+azGIJsg/9VOnJVXLz77
         dxvPCEn6BnbOur8qjLY1YN/7mbmlgjVbFSXGLyq1iYjaHYJSZW9V4z7WwiwodONGB9FT
         w1OdTPvjNmOKFQCL3MfEphqFDfmFNiFL4YPX5j2zEWtfHLbi4jh+GuDoG8dycWb8zWJL
         1gqz4v1YumL1TUhKkuI9VjLLOutqy5KxxdZoHNVFF9+863IX6zuUIWrkTr7D23Z5d6Su
         Vs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A+WOhnazYsfzDuASZnwhsI2oNJNNtzpB9SdiRw46FP4=;
        b=i7Zh4LtcG8SAiV83zalmVpERVFVsDHnQdUf+IOjKeqlTRJLfriyGE+H5sb3nAw8hcj
         wP5JrS1CIvEo2rYRtUVc4iEfPiGLh/xto2S+/rNmlWVpu+92QYtW4SZ7gw26Ew717L7n
         9PWNvN338XUVaCsByezKkgCsexTntF9ygAd2GJi/IohENuJHfhh68vdgzVonl7Dol8SX
         y7dSr9xN1PS9VG3aHb2DVvnd861juecWFKnSUjZkLs9iDiTgjbDds6FNF2WJ25K3qJXR
         zc41xofx30d13tyHzibmYN+Qj8CU0WX24IAtfI/y38J4ZPL8yRBOQ2obTfMWCQN748vI
         BzTA==
X-Gm-Message-State: AA6/9RkO+IAerwxkJS84fFlG8L12ImIBvqEcADX0xviFc0HgHMrjfYQeHDNhFx+AUe6ZMZMtYSPTp8ENyRdl5BtN
X-Received: by 10.36.211.197 with SMTP id n188mr18142038itg.65.1474910610178;
 Mon, 26 Sep 2016 10:23:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 26 Sep 2016 10:23:29 -0700 (PDT)
In-Reply-To: <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de> <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
 <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Sep 2016 10:23:29 -0700
Message-ID: <CAGZ79kZZwum+97JGL8OFWTdODZeqrEyj4MVMC6o6ynFMOhiFLg@mail.gmail.com>
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 24.09.2016 um 13:30 schrieb Ren=C3=A9 Scharfe:
>>> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
>>> warns when it's called like 'git merge <message> HEAD <commit>' because
>>> that syntax is deprecated.  Use this feature in git-gui and get rid of
>>> that warning.
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>> Tested only _very_ lightly!
>>>
>>>  git-gui/lib/merge.tcl | 7 +------
>>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
>>> index 460d32f..5ab6f8f 100644
>>> --- a/git-gui/lib/merge.tcl
>>> +++ b/git-gui/lib/merge.tcl
>>> @@ -112,12 +112,7 @@ method _start {} {
>>>      close $fh
>>>      set _last_merged_branch $branch
>>>
>>> -    set cmd [list git]
>>> -    lappend cmd merge
>>> -    lappend cmd --strategy=3Drecursive
>>> -    lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
>>> -    lappend cmd HEAD
>>> -    lappend cmd $name
>>> +    set cmd [list git merge --strategy=3Drecursive FETCH_HEAD]
>>>
>>>      ui_status [mc "Merging %s and %s..." $current_branch $stitle]
>>>      set cons [console::new [mc "Merge"] "merge $stitle"]
>>>
>>
>> Much better than my version. I had left fmt-merge-msg and added
>> --no-log to treat merge.log config suitably. But this works too, and
>> is much more obvious.
>>
>> Tested-by: Johannes Sixt <j6t@kdbg.org>

Reviewed-by: Stefan Beller <sbeller@google.com>
