Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76641F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfBVJ0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:26:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53239 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfBVJ0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:26:38 -0500
Received: by mail-it1-f194.google.com with SMTP id r11so2062857itc.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnJl8Vt8mS6t8Xxbtff3+Q5ln9q6SQJ9glR2H49mQM0=;
        b=PDz8Licqly+YiA3mm8+rH38smHCMkDnbIcifAAUQdZUw8uPSDB1fvYXICBSNza3phb
         Z35Bv5JVjUfuMsoo8grw63EE8SM3NHfCBr2ST7gENY9zhqxK88FnFtBQiXofnG7x1EPM
         3hItsASMFj9p8tcE9feCtX13jJAVkLH4jwuwdCP4Cj0vAZbmB+rouUubyfy1zsjBZncN
         /HNP+5fE1R8G7fbljZ1Qu4JR9ngnZfGv6VPF4kZGFY0u/iw1JB4NYRv80UMWvhOxoBy0
         7QnOiZDFxtTRvbJBt6jFMoCtjxcYF0U/C+3+HP2ut39YYfm04hSinm3cVSxTtwqcRHXt
         fC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnJl8Vt8mS6t8Xxbtff3+Q5ln9q6SQJ9glR2H49mQM0=;
        b=SLsTL6SSajYAsAp1jmfw2acJNrvVTtUtGrdls6x9tSB3c/yUTRSxoBMtWZjlnnVjyc
         y43aIlczc6qKorgZZ5LI5JYona1g/i3JaIEk1yT5d3C15e99KWjkFGjz+pYWI/qJW/S3
         KsoE0xmGLa8Z5exs0LuFyseCcXhjwXLIBXZs1BFvMNNGrxvbNVfJnHhTJNmYOFfm2kZT
         77O91NdxXV62NcpXVUgIR11AkiNnAb7mLZLdMxrzt7LT/oL7ONS6AcWK+uFtaM8eDRqP
         DIUCicCTsLf8//X7obK1ByqxiIQMgZ2/3K9BfYZI89bmqgdwlMWfGKW6i+QUFXD3tz7e
         aBrA==
X-Gm-Message-State: AHQUAuaC1hXgsz9GJ++u4x/omaIBHF7iE/in0Th+OtBGyWQ1hB8HZFv9
        hWrxbgiY7a+XgaxaeU10/qvvBPQXZRRqqbVpUB4=
X-Google-Smtp-Source: AHgI3IaVJEAcxD7OifpzAmBbpi8Pntcpv0JA7QpuEshXEzy5GolsURqG6duXiHxShQcTPj2hHzZt1XNd+uSAn7sz1+U=
X-Received: by 2002:a24:c056:: with SMTP id u83mr1484074itf.10.1550827597277;
 Fri, 22 Feb 2019 01:26:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com> <20190221145056.53b98b2a@kitsune.suse.cz>
In-Reply-To: <20190221145056.53b98b2a@kitsune.suse.cz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:26:10 +0700
Message-ID: <CACsJy8CGtYe-d_0gXg4HLqvE6eR62yXsX-abz8NZ-Ln_+VdUqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 8:50 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> On Thu, 21 Feb 2019 17:50:38 +0700
> Duy Nguyen <pclouds@gmail.com> wrote:
>
> > On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wr=
ote:
> > >
> > > When adding wotktrees git can die in get_common_dir_noenv while
> > > examining existing worktrees because the commondir file does not exis=
t.
> > > Rather than testing if the file exists before reading it handle ENOEN=
T.
> >
> > I don't think we could go around fixing every access to incomplete
> > worktrees like this. If this is because of racy 'worktree add', then
> > perhaps a better solution is make it absolutely clear it's not ready
> > for anybody to access.
> >
> > For example, we can suffix the worktree directory name with ".lock"
> > and make sure get_worktrees() ignores entries ending with ".lock".
> > That should protect other commands while 'worktree add' is still
> > running. Only when the worktree is complete that 'worktree add' should
> > rename the directory to lose ".lock" and run external commands like
> > git-checkout to populate the worktree.
>
> The problem is we don't forbid worktree names ending with ".lock".
> Which means that if we start to forbid them now existing worktrees
> might become inaccessible.

Worktrees ending with .lock will not work well now anyway. While [1]
reports the problem with worktree names having a whitespace, ".lock"
is in the same class (not a valid refname) and will result the same
error. So if you have "*.lock" worktrees now you're already in
trouble.

[1] https://public-inbox.org/git/1550673274.30738.0@yandex.ru/T/#m9d86e0a38=
8fd4961bc102c2c69e8bc3b2db07a42
--=20
Duy
