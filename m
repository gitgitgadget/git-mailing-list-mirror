Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0331F404
	for <e@80x24.org>; Sat, 15 Sep 2018 00:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeIOGIU (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 02:08:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36511 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeIOGIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 02:08:20 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so7417201iop.3
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 17:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TN8d9M9SUUXh7YzeWPiFSyUAK/i8G7otKH3M6ZPp5D8=;
        b=W92Asy0QMotonu+bTCiUIyWR2dWjM2249a1n6BlQkIy2XNp2KHNNUGOZlgpmZRCLMK
         AHz+LAdrmJE0ZxreMKbKdBXOlyI9zIGSSWSAb2ewixqFbmkDpM4YEshpI4ztVPWBUybN
         ZvnrsYjpJ2ENk/Nuq2TWVipNkhtyNPXWag8qnxLb/H+3G40BIYUl0qp3qe/KOFTpioDt
         X/LuZYe+7jO4HRIHl2HWWdB1OIUGQvzdKrrda0raWCt8kmPMomC448Lf8VCGTW8CT3IL
         001q041ZNRmjAD9ls/YPdTx/czRyiZLe4fJj6UaDuuIccj3Iaga4JYteTzzexTAk0iz8
         nzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TN8d9M9SUUXh7YzeWPiFSyUAK/i8G7otKH3M6ZPp5D8=;
        b=Eew9atFZVE5NazekZzSvvt0d4ZbxB0z819lLJYmcCY/TzsXM2jzApHmxuGXS9lfBc4
         /nR4bamoDFmP/PFthZgK12sHlVWTCSx7Io6E6/fB6KaUPdcb3f1Q1JaoQw6m98UY8JfH
         JINrxM9/yvDIJ2En4DDZSZ9eR8PLYn+QXD1nqc9iboUQWyZhHTzyHr5xYSSyTy7bEHK5
         YJuLJOY+0y8seePaYtVcFDe/yvv9RbLsK6kiitKMDeqUYh/u594dOVQxLkFUZ+pHWnic
         GWkqDHC0TIO6lOJrVLFMtaR6Xw/iltOL1gGg0suwkZ/BvjOxvW2RYYNTtVWBp/x4To2v
         CFAg==
X-Gm-Message-State: APzg51CyFnKixHUqKIDfQULXPmkv13zFOhPscLw9BsIof7Yq7YYFQNne
        w/uFtLXk/5+5iSLdWtvub6q0LGdacZHM9Fr2KvnhpSRLsCg=
X-Google-Smtp-Source: ANB0VdarmU5h/x41WBID7Ibv3ZgQTF3oNscR0oXbo0kKDtwHWo9IQ6S0IF8O22+d6ePV7R+L9Ssp0wIfUbr0tshu5v4=
X-Received: by 2002:a6b:5505:: with SMTP id j5-v6mr12845171iob.106.1536972688904;
 Fri, 14 Sep 2018 17:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <87a7ojlp31.fsf@evledraar.gmail.com>
In-Reply-To: <87a7ojlp31.fsf@evledraar.gmail.com>
From:   Niko Dzhus <primenico@gmail.com>
Date:   Sat, 15 Sep 2018 03:51:17 +0300
Message-ID: <CAKd-JgRgrJXNVyxsD-cg-TJsXu0K35tv5cSDjbsYNXCiu1j0hg@mail.gmail.com>
Subject: Re: [Bug report] Git incorrectly selects language in macos
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tried what you suggested - it seems, it only ignores English. In you
example, with Swedish as primary and German as secondary, git uses
Swedish.

With more that one secondary language, the one with a higher priority
is being used, as expected. I also tried using non-generic English
(English-UK and English-US), but they also get ignored.

Terminal commands return the following:

=E2=9E=9C  ~ locale
LANG=3D
LC_COLLATE=3D"C"
LC_CTYPE=3D"UTF-8"
LC_MESSAGES=3D"C"
LC_MONETARY=3D"C"
LC_NUMERIC=3D"C"
LC_TIME=3D"C"
LC_ALL=3D
=E2=9E=9C  ~ env | grep -e LC -e LANG
LC_CTYPE=3DUTF-8
=E2=9E=9C  ~

It doesn't change with primary/secondary language switching. I don't
have any manual overrides in my .zshrc and .zprofile for those
neither.

On Sat, Sep 15, 2018 at 12:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Sep 14 2018, Niko Dzhus wrote:
>
> > It doesn't use English when other language is available as a secondary =
language.
> >
> > Reproducing:
> >
> > 1. Open "Language & Region" in macos settings
> > 2. In "Preferred languages" box, set English as a primary language.
> > 3. Add another language, that git is translated to, as a secondary
> > language, for example, French or German.
> > 4. Run any git command - git will use the secondary language, instead
> > of English.
> >
> > When the secondary language is removed, then git starts using English a=
gain.
> >
> > I have git 2.19.0, installed from brew, and my OS is macOS 10.13.6 .
>
> What's the output of these two commands for you:
>
>  1. locale
>  2. env | grep -e LC -e LANG
>
> We don't do any such magic ourselves, so whatever this is is down to how
> i18n in general works on your system, do you have any other translated
> command-line program that works differently?
>
> I suspect there's some DWYM logic here that always treats English as a
> secondary language.
>
> Do you also e.g. get the same results if you select say Swedish as a
> primary language and German as a secondary? I.e. a Git in German, as
> opposed to Swedish?
