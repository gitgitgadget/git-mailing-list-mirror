Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422982098B
	for <e@80x24.org>; Sun, 16 Oct 2016 21:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbcJPVFs (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 17:05:48 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35990 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756493AbcJPVFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 17:05:46 -0400
Received: by mail-io0-f173.google.com with SMTP id j37so170285451ioo.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZlzBIo9WCrRu3b/VcxBoWMKZo4MKP1GoHk8jJdj1ks=;
        b=ONE4FWpU+MosQnEjPYH9lp+hA72VYn9ajzoVoT8V1iseBGmmFRvVWi5GfGLDHiJXjS
         eZa4b/ORLh5SDT/mGTXsgl0ivK9Q4JsIy4bi5tXrp48k4RZojwGa0DS5GN2BOPj5SDeL
         9f0cyTyW7lktZBhd+Mr+wa43wRRIOrU1koYdUkRyA6TFEc2nF0tY+jNGDwGOePADJYPX
         6OWBVx4etRX9UdOofWubgFAh0NEPmZeISmJTQm6N72MEvyUcOzzxoIc2hy2wYzaWa2C6
         6KbLAVZQI7Fd1x308WfYvocehZW4tEHjDIJU0SPUJukGXgXytKd+jfmPLSuzefWSq98y
         HpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZlzBIo9WCrRu3b/VcxBoWMKZo4MKP1GoHk8jJdj1ks=;
        b=gS+yiLqlqzfIjPInVj54yEOwTjGuImoxZ3CWdANhmjTe0Xka46rCJ/u0lHh793XVr3
         MykhHLrB3k3URIKbcpKr03avb003kiu7vWFVgU9TC2wlgBr4m5tyF/Se7YpcTvDQee7D
         g7WV3i0gDfadsihbgEDQeOo/0hzjA7d/66g2Ow24X8EbXkZv84k7ynGJt2VO9yBEoveB
         zmgetWXjBW+kOy8c3W8hWidDqvD5pEWF3UJaAKWfVFbMYwn2767jVAgm8QfdAgReSNfl
         7OBDifklQL3gvXtOJLwi/Ay2C9+nX7Ju2WQ0RzWDmAAMsMQ9axiT2EE9ES/W59vmyRqS
         dbXQ==
X-Gm-Message-State: AA6/9Rkjlk/mdo7XOuGJFQxZ9RsOFpoRCugBulO74Io6OINUshXfi2DnrgkZSorPxb/K6Hi3E2vMexwm1ThFXw==
X-Received: by 10.107.20.138 with SMTP id 132mr19716958iou.47.1476651891510;
 Sun, 16 Oct 2016 14:04:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Sun, 16 Oct 2016 14:04:51 -0700 (PDT)
In-Reply-To: <db083f89-b502-fe61-ce62-e7c4701f8764@BridgeportContractor.com>
References: <db083f89-b502-fe61-ce62-e7c4701f8764@BridgeportContractor.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 17 Oct 2016 02:34:51 +0530
Message-ID: <CAFZEwPMDb7FsP+dzKR=RAGGSPGg_-RcRRN6tqu3pOVbapgWLBg@mail.gmail.com>
Subject: Re: link broken on git man page
To:     Howard Johnson <hwj@bridgeportcontractor.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Howard,

On Mon, Oct 17, 2016 at 2:12 AM, Howard Johnson
<hwj@bridgeportcontractor.com> wrote:
> This link below is broken in the man page.  (I'm on Debian Jessie).
>
>
> GIT(1)                            Git Manual
> GIT(1)
>
> NAME
>        git - the stupid content tracker
>
> SYNOPSIS
>        git [--version] [--help] [-C <path>] [-c <name>=3D<value>]
>            [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-pa=
th]
>            [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
>            [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<na=
me>]
>            <command> [<args>]
>
> DESCRIPTION
>        Git is a fast, scalable, distributed revision control system with =
an
>        unusually rich command set that provides both high-level operation=
s
> and
>        full access to internals.
>
>        See gittutorial(7) to get started, then see Everyday Git[1] for a
>        useful minimum set of commands. The Git User=E2=80=99s Manual[2] h=
as a more
>        in-depth introduction.
>
>        After you mastered the basic concepts, you can come back to this p=
age
>        to learn what commands Git offers. You can learn more about
> individual
>        Git commands with "git help command". gitcli(7) manual page gives =
you
>        an overview of the command-line command syntax.
>
>        Formatted and hyperlinked version of the latest Git documentation =
can
>        be viewed at http://git-htmldocs.googlecode.com/git/git.html.
>
>
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>

It is fixed in the recent version 2.10.0 . The new link is
https://git.github.io/htmldocs/git.html .

Regards,
Pranit Bauva
