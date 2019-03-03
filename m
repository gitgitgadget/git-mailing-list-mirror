Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB66220248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfCCBSz (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:18:55 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37810 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:18:55 -0500
Received: by mail-wr1-f45.google.com with SMTP id w6so1709298wrs.4
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=v9s93T+gXayNxN2+Q1pvMd9KLDaK41G4it2uTJY72nA=;
        b=EPtXV4P5d1e0XfKKykYgj7DwN0bCWb/tcdfFj+RsnMzUpAY4A8p592WIJ4N/d42GED
         ZZCmVhV32NX4MVyNxZlpD/pPik7HhCxetFn16hhoXBEiO58MLIZAAQvXfKiMMAuw4r9L
         EZPWcoRsdrtnrFduHc+Wq6joyWUVFW6wZ022124P4+bs+lCi0FqyzDgjInCr9X3lGEqz
         2EvqEx7ElSm7oICl2g3w9Tgr9f41445Vwvo5SNQOMEXApfPWkButF/BgRlkGdRB1qgVR
         YeRR5BDTUj36l4KTgAL6/Z76ZGHwvv1JPTjfj3w1/qWS9yVl4pYwvMLPH0BtSDVWwsB9
         anjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=v9s93T+gXayNxN2+Q1pvMd9KLDaK41G4it2uTJY72nA=;
        b=beY7Jt/aOapCw0hfeXxQpd9+MT2l8IQ668sjP8yyRdDIU5XrQsFIKBUGp34xdlPTWA
         enj5ZSEvXw+ACx1WIkvuWFP7HPFQLIrwygzySlTs2aHHHNRu8M2O+x3+H3pAUu69szgX
         grJQCnntXeAaj8cmQckXI/LE4+IuCZI7IIuXNz1uarV0aa7NEEI/8DcHFcljHWCmDLD8
         8MjwdL2c7VaABnQuzfeCVKZBe/1IxoV/fWeygfQVrLSNfhtbCk2m478zeBC8Wp8z6EQn
         18mVDiZWwtYT1SJvascE5WNtSHfJXadnauCoOl23HOW2BO+afK//Naruf3rbkeIDtu+W
         U0mg==
X-Gm-Message-State: APjAAAWTbW/lyXaFvF65JqNhV51MVN7/pGYqfzNC1/hbioI+VkF+iM+S
        C072a+SFezXBJ0NQkGh+1hoVQK4DUPw=
X-Google-Smtp-Source: APXvYqyioqIewsp4yp6r/Xa2nXTV3+4MqZCtM4l3dkMKQSajF8HHJLp3bXwvvXdpGvIIeUvrNlgBZA==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr128140wrb.147.1551575933414;
        Sat, 02 Mar 2019 17:18:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u8sm2533396wrp.55.2019.03.02.17.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:18:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Chorney <djsbx@djsbx.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)"git\@vger.kernel.org" <git@vger.kernel.org>
                                                                     ^-missing end of address
Subject: Re: git commit --verbose shows incorrect diff when pre-commit hook is used to modify files
References: <CANFDZM6PikancjUdm+HYgGknD0dPhzxU6yOYFLZpcnCmg8JKdA@mail.gmail.com>
        <CANFDZM7fsbwwqhyWTzfivm4L=GgtCMfCi+DekZurs+SFGqaOjw@mail.gmail.com>
        <CANFDZM5=ffu-=H=vrO3Kr0t2km-3Zg4=msYUWqqJQKGxGojnqA@mail.gmail.com>
        <31924311549922691@sas1-d856b3d759c7.qloud-c.yandex.net>
        <CANFDZM68A96YprMKhaHNfPRAtK18ad6Bo9=uesxHN=-tLONn=g@mail.gmail.com>
Date:   Sun, 03 Mar 2019 10:18:52 +0900
Message-ID: <xmqqmumc69hf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Chorney <djsbx@djsbx.com> writes:

> Hmm looks like I forgot to send my reply to this back to the mailing list.
>
> "Hmm, so I currently have it set to run vim as my commit editor, and
> enter the message in there most of the time. I can definitely see
> output from the hook into the shell before my vim editor loads up that
> shows me the diff and lets me add in the commit message. This leads me
> to believe that the pre-commit hook is being run before the editor
> (with the diff) pops up."
>
> Does anybody else have any insight to this issue?

I do not know if it counts as an insight, but the pre-* hooks, not
limited to pre-commit, were invented for the purpose of validating
the input to an operation so that the hooks can _reject_ if the
outcome anticipated does not satisfy project's conventions; the
purpose they were invented was not because the operations wanted to
allow the input to them.  So attempting to modify the tree in
pre-commit hook, for example, is outside the scope of its design and
I wouldn't be surprised if you get an unexpected result.
