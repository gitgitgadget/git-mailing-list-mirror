Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4221620248
	for <e@80x24.org>; Mon, 25 Mar 2019 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfCYOhw (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 10:37:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50307 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfCYOhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 10:37:51 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so14280609ita.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UaPGteKgB8YEsZ6riyERYGHH8hSX0G9pDZQv/m5hKDY=;
        b=ICJ9uZTD3wvwcgePyQ6ii5jqXYQQFc/5dlOKOiEZ0eERABLuAbtsEUm9wnCzSBd0XE
         HuTw1vinKlIhLCzxkH8IL5qFW+gMkwsfGrW5wWoNhkLJSWrbCt/b0DsjCwBXGpOuY1Z+
         BfLTrR0TKdI8WNHD5EmaTQNa32ELLZZIaSn+EKMoR5xwbJvXkOufcs7x8ZTxSS/tM/qM
         CBRqkXqE3mYTPGINjjyuTlLIXc61zQ+sdkqRLlIihjXFoKscHFAxzAWL2HEcos0sGeCb
         FmNUbMR2efAugnDOOk+JL1pl/y3DkcU58TC/LBXwqHwU+Q0INMp1EoxBJUbAkLEdlEiz
         lixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UaPGteKgB8YEsZ6riyERYGHH8hSX0G9pDZQv/m5hKDY=;
        b=HIjPaMcLdVZ2lUHmZDw3A5UUvFvvkruhDpLY787SKalwNDRBF3iDTe3kXVhE3vDkOW
         DNqVBthYmPBd7/NOUbgFy53cf/qzcQ2GrXkPLvMzxZU3MSYp2/YUk/lEuynwS8xwxJUX
         Q19nEeHW2gf6+mXL9sqV7TmepuYq3mF9yYs/by3Iy4+OI6NAzaWaNJ8ao9yKWlMHVq6M
         Sx7PJSQs/yC9veLyVrG8zuIRg0ZNSpjUYg27OtaItQeu18qL2GwUhq34s+OlbqtTnxRz
         KP7AnjML4G96RaFVbU7W+cS3Krj0RmzK7BigzIhIdl0+ygqsN1P7Sd6DzlOXJJRhuxcI
         5omw==
X-Gm-Message-State: APjAAAUKEJZoj5Pw6UyTDIRo8ix9YOwO2ZanhSojKZHiiKYZvoTQwMs/
        t+lzVAeEbdy9LCoXv2XjYzh6BQUvmDz/hWWOKR4gqCTd
X-Google-Smtp-Source: APXvYqwqlFW6nrP5tqiZ0QZ/pC0Jpf/cBeo/PH1JAEhEUtM046Tg06mvB5MTv+fqbce7ZsWtEeAFbGImbKhZwylemMk=
X-Received: by 2002:a02:6d12:: with SMTP id m18mr18617440jac.54.1553524670826;
 Mon, 25 Mar 2019 07:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8mDWpf0b3zykyvHRLLbYdmLB7hAk9LcsciB=dYhs4C=VA@mail.gmail.com>
 <27b99f79-7a6a-1205-b528-84fd81433e0e@kdbg.org>
In-Reply-To: <27b99f79-7a6a-1205-b528-84fd81433e0e@kdbg.org>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 25 Mar 2019 10:37:24 -0400
Message-ID: <CAH8yC8nheOmz0G_Pv3oCv03Se16-+Ynwse9xFRDqKf-x2b9Qkw@mail.gmail.com>
Subject: Re: How to disable docs when building Git from sources
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 3:14 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 25.03.19 um 07:40 schrieb Jeffrey Walton:
> > I'm working on a low-resource dev-board. It is missing a lot of
> > utilities to save space. I'm building Git 2.20 from sources. Make is
> > failing due to '/bin/sh: 1: msgfmt: not found'. I don't cross-compile
> > because that's a bigger pain in the ass than waiting for the native
> > build to finish.
> >
> > I ran './configure --help' but I don't see a way to disable the docs.
> > In the past I tired --disable-docs but it had no effect.
> >
> > How do I disable the docs?
>
> These are message translations, not documentation. To disable them, set
>
> NO_GETTEXT=Yes
>
> in your config.mak.

Thanks Hannes.

I used 'make -j 4 NO_GETTEXT=Yes' and I think that fixed the command
line components. Or at least I did not see the error where I was
previously seeing it.

I am seeing a similar issue now for the GUI components (assuming
po2msg.sh is doing similar):

make -C git-gui  gitexecdir='/usr/local/libexec/git-core' all
make[1]: Entering directory '/home/jwalton/Build-Scripts/git-2.21.0/git-gui'
GITGUI_VERSION = 0.21.GITGUI
    * new locations or Tcl/Tk interpreter
tclsh po/po2msg.sh --statistics --tcl -l hu -d po/ po/hu.po
tclsh po/po2msg.sh --statistics --tcl -l pt_pt -d po/ po/pt_pt.po
make[1]: tclsh: Command not found
make[1]: tclsh: Command not found
tclsh po/po2msg.sh --statistics --tcl -l ja -d po/ po/ja.po
Makefile:252: recipe for target 'po/hu.msg' failed
make[1]: tclsh: Command not found
make[1]: *** [po/hu.msg] Error 127
make[1]: *** Waiting for unfinished jobs....
Makefile:252: recipe for target 'po/pt_pt.msg' failed
make[1]: *** [po/pt_pt.msg] Error 127
Makefile:252: recipe for target 'po/ja.msg' failed
make[1]: *** [po/ja.msg] Error 127
make[1]: Leaving directory '/home/jwalton/Build-Scripts/git-2.21.0/git-gui'
Makefile:2037: recipe for target 'all' failed
make: *** [all] Error 2

Jeff
