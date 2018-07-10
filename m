Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C561F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGJMSf (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:18:35 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37737 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJMSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:18:33 -0400
Received: by mail-qk0-f178.google.com with SMTP id t79-v6so11366249qke.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k5jpaYjpbSak+IDcImEBjXnXs0pm864W+jjgobxMmEU=;
        b=qc1Ml6JthSlZCNRQwhuUIrmm1WsRT+HtL5YAZy0ZM+iZ8gbe2bNHfzVfeMELlmKOsS
         ece/X+Hzn3ZLCchJJ1uH7Q2D1lGS6bj8/o9K2beJrYXjO0ohCWxpMJRIxIiFgZwZA4ZV
         2E66Xsv7umSOF+iHPLV4EulM0NH060854mYtc4t+FyQ0bMd92TJoekJcuQjqLdpSbTyE
         tFn8syMXbXqE/h/gcj7Tf2aUZe3W7nvvSlQlZ+k9uwvwpVzoVd032Sg1lvugN8F1IH0x
         y4bQKvOrchL9DuS++B+TUcwkyeTmB52w3d5kzCLo4R9TlNheHOlyehj3K2MGks0DtqBb
         8JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k5jpaYjpbSak+IDcImEBjXnXs0pm864W+jjgobxMmEU=;
        b=U4nhETu5yjS1Ac/7spa36tvgA1xmGUOVzEKijvlF/8FpgnuTpT6AzcqTAh1trymiaj
         Oj19fV1hyEkxjsC5SsiV1OKl4qpBWFADpO6awH68SwYIel2j7ZVx8r4lWLRnvW7yQUTM
         ILu0a/74rcmteuYJV5lQWJjvHsa57eZ1qKoHidx3RxY5OP/fVQUXXOASVn3jZjsmfIRv
         kw6jVD2CqcOffeWQPPYRvZOpbiN3McKAimTgtgVOPCne03IolX0ijnjswEKV7hb0VNA2
         wBpd1DUv1mUY39eXjQYUHaYq/3p35ZSBRyHxEIdGa+USuwrjxu4Gfca5xQj7mvYVCQvX
         fFRw==
X-Gm-Message-State: APt69E2jJNwEcxwc0qqtAdXVnNT3Cw3GK7P26Ez8/py1zHDJGhYubQyD
        1hjmWo+S7rfkoOHUXh3eQ5NNCPvYDMiueFsRvDc=
X-Google-Smtp-Source: AAOMgpe+3twCc/WN9ollU0o6rdF0r7z5pXSHXIrE6WFlgGyh+zj1uRzfTGYybG7j/IVu+fuWFqJTC97fcOFaCo29eRU=
X-Received: by 2002:a37:c204:: with SMTP id i4-v6mr14254580qkm.438.1531225112852;
 Tue, 10 Jul 2018 05:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:53c2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 05:18:12
 -0700 (PDT)
In-Reply-To: <F261A512-F38D-45F2-8F4F-A932B9BEA6A1@126.com>
References: <F261A512-F38D-45F2-8F4F-A932B9BEA6A1@126.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 10 Jul 2018 14:18:12 +0200
Message-ID: <CACBZZX7_iiVu6scdpc4z-rG3wwjC-cwwOOO88vjwKGYqe2FTWQ@mail.gmail.com>
Subject: Re: Git log command doesn't run as expected.
To:     =?UTF-8?B?5ZGo5bqU5aSp?= <zhoudao200@126.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 1:16 PM, =E5=91=A8=E5=BA=94=E5=A4=A9 <zhoudao200@12=
6.com> wrote:
> Hi,
>         I=E2=80=99m using following command to do some search work:
>         git log --all -G 'some regexp' -p =E2=80=94 path/to/my/file.
> But the output could miss some commit. (For example, I grep a little piec=
e of code from a commit diff message(properly handled for regexp), but when=
 I use the command above to search that code, I could not get that commit.)
>         I wonder that it is because I use it in a wrong way? Then what sh=
ould I do to correct it.

Have you tried with --full-history? Does that find what you're looking for?
