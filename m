Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BEF1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeIKVBl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:01:41 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38136 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:01:41 -0400
Received: by mail-it0-f53.google.com with SMTP id p129-v6so2182845ite.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X0hf6FhXIL5L59OsJVvsbeb9JcWrrJXSmWiFnxTWAwo=;
        b=hsgQLLZv0F57pBvqxcCtFJPnB5owqchbOUyqJOfgBRgteIS1m4niXHrmi6QRpb/Gbi
         VFnfa0G8aiudveoKuDBvmj198HiFL3LrhHSjaTt8NMsLc+cEn/xewe8YaB1pwGn0APKA
         zYyjfmMdXetoXGqn3LvMtbKtDQr/ket90XBNtMlvhBfK35sXreVXj+/11LSkXNg63pKw
         WVuC6soWTSiVAOSy8L7qY0wIReaPGAClITrZF8ZBR6+ZUqUAp9sbNNS2Y+aEZcq2E3LF
         /fw7ASPh7QB/uRpSIkJ+aPpxzBws7FgIXn3rVWgjgQKD06txQCJdToB19lKwkije668+
         CJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0hf6FhXIL5L59OsJVvsbeb9JcWrrJXSmWiFnxTWAwo=;
        b=qT3PSG3jJ5vdPA9Z7M6LNnLenOYmpQO0zDgbsqPNEGUaEeb0FreeRIK1L0FvTOYu0L
         ru1Ts0zc18cxbNlo7tm1BpF4Ut6qcQiC9IGuqNJlPWbBQS34tgz5t+xiOkPQbbcZu4c0
         h5eLhux/EpIyCqo04OZAUzeo22aoYNANmNaZFR+RobmrWQ4MG4ANdpBWlELu65/Dggkr
         UGxM10JCQ6WCH9SGkEHTJtyhs0HBmrHwL3HIXlvbN2LV0FzV9p7QV6EFPkGDr8xpQL8x
         /Kuf/UcJpJjC0uUH7GRFquIl73GwIorIazPTM3fTejugy8MRV5WSpc7mOPGs774TLJJi
         F9Pw==
X-Gm-Message-State: APzg51BVrfE30rYEDEtOTDTzOA7eet4YDhvIOFuJoBict81yodLpnvFm
        aNulVSh7mj3jHN/CqilmbH0dse5b6Y6yaysx2gPkLxtQ
X-Google-Smtp-Source: ANB0VdaeOwpD8yXF6PWaCZ1sCPf9cbTi8UZvhMgIo3e3YNVjDcOeC5nLTRn3rXqLyMnmFz13n33nzrD2wUgwSXmNTDo=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr2047459itk.62.1536681704444;
 Tue, 11 Sep 2018 09:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <3d9c42ea-70ba-a27c-1ece-797829caa1b0@free.fr>
In-Reply-To: <3d9c42ea-70ba-a27c-1ece-797829caa1b0@free.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Sep 2018 18:01:17 +0200
Message-ID: <CACsJy8DBoZyOSivk-ZZZze0nViPqw-GvseDJADvNyy7c1jHV-Q@mail.gmail.com>
Subject: Re: Help on autocompletion not localized?
To:     jn.avila@free.fr
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 2:55 PM Jean-No=C3=ABl Avila <jn.avila@free.fr> wro=
te:
>
> Hi,
>
>
> When invoking the autocompletion help with <TAB><TAB> after a double
> hyphen under zsh, the help list is not localized. I guess the help list
> comes from some usage output of the on-going git command, but I wasn't
> able to find where and how this happens (completion scripts are quite
> hairy).

I don't use zsh, but I guess that's because the help strings are hard
coded in there (in English of course). You can start at
__git_zsh_cmd_common() function.

These strings are available (or at least possible to make them
available) from 'git' binary, which should be translated. It's just a
a matter of hooking up to zsh script.
--=20
Duy
