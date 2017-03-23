Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C94720958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935628AbdCWVIS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:08:18 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37387 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdCWVIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:08:18 -0400
Received: by mail-it0-f51.google.com with SMTP id 190so5276317itm.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vpa4vSzpiDgtH7X8DtwrgX5zwYoVUkFsgDvNhA0IfPI=;
        b=mIE16fqrNWh6v9iXGwIr6zHfcYF3w3OG87qcocahTF1Jv0/YlT3HRj9alYoR64EYqB
         8ynqCkmDbb1YSmFg1hFYP0/x5pba8KBZiZNswMycN1yA3lSxscl9mNACIVF+GL/N8KeN
         Ft24NtM+2mZg9SvhDA8EFj0onPC0ZdwfXZySBA2eShaVkJknUZXnUi/GwliRo1p50bKS
         +dXT+SH+rmTH0C3rE6SnuWiUzGBGILCwogssURVkdwaqJLzL/PBst4IZXB9FXWR44N01
         Fb45bqiVhJyhXZOv8w+KKTF3NtMIaMm2oJExFpPFoX+JSSr90du6ii0CSjXwWZestyCy
         TRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vpa4vSzpiDgtH7X8DtwrgX5zwYoVUkFsgDvNhA0IfPI=;
        b=tGl8DZRZyKouujsuPsxvs0gpUGcUtqOSp3kzCA+gDxCi8R69iRVV087UzYnaZsGu3j
         fFv4pA9ZaDeHaQM2mOjRpLLu9PlhesVgxk1pCntNZCgTUf47PAYAeG3FfEEa5YwGECgo
         sZQXRKfRrYu3pYiMhqL2TGwm4wvTp6ymV/lD6PyyjpalhmbrwS647TIEFd3VOgfdDB2O
         FG5jsMDlX6WCdn+MNdM05o3IquQ+jQl0lzGPfE6wVOdBBg4tTaKuWCEdIrxjlIchDJHc
         RN86ECEDjjWC5uqRN0BijzBaGynZU4FW+uF1GV7S1+pBbirrjmiAG81rA0s0hjEMLJh5
         9gaQ==
X-Gm-Message-State: AFeK/H0DAMMq6ENn3QagQM0YnkO7hslBtPQmLCRNtW6MO4zuBucQT427Yi0uAOtx3oyxKjhEmbf4BsLGXlcr5w==
X-Received: by 10.36.224.195 with SMTP id c186mr15839901ith.24.1490303296628;
 Thu, 23 Mar 2017 14:08:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 23 Mar 2017 14:07:55 -0700 (PDT)
In-Reply-To: <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
References: <20170323120326.19051-1-avarab@gmail.com> <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 22:07:55 +0100
Message-ID: <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use `<branchname>`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change an example for `git branch <pattern>` to say `git branch
>> <branchname>` to be consistent with the synopsis. This changes
>> documentation added in d8d33736b5 ("branch: allow pattern arguments",
>> 2011-08-28).
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-branch.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 092f1bcf9f..e65e5c0dee 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -142,7 +142,7 @@ This option is only applicable in non-verbose mode.
>>       List both remote-tracking branches and local branches.
>>
>>  --list::
>> -     Activate the list mode. `git branch <pattern>` would try to create=
 a branch,
>> +     Activate the list mode. `git branch <branchname>` would try to cre=
ate a branch,
>>       use `git branch --list <pattern>` to list matching branches.
>
> This makes the description more correct.
>
> I am not sure if it makes that much sense to have that sentence here
> in the first place (after all, it is describing a behaviour of a
> mode that is *not* the list mode), but I guess that it may be a
> common mistake to forget to specify "-l" while asking for branches
> that match the pattern?  If we were writing this today from scratch,
> I would perhaps write something entirely different, e.g.

I'm just doing s/pattern/branchname/ on the existing documentation. If
you'd like to entirely reword this to make that unnecessary that
sounds good, but makes sense that you then submit that patch & just
drop this one, rather than me copy/pasting your proposal, sending that
as my own patch etc...

>         --list::
>                 List branches.  With optional <pattern>... at the
>                 end of the command line, list only the branches that
>                 match any of the given patterns.  Do not forget '-l'
>                 and say "git branch <pattern>", as it will instead
>                 try to create a new branch whose name is <pattern>,
>                 which is a common mistake.

I like the old one better. It has 3 actual command examples you can
readily see. This turns that into more prose that requires the reader
to mentally parse most of it and mentally insert the mentioned command
line switches into the equivalent of those 3 examples we just provided
before.

> though.
>
> Thanks.
