Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635881F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHPVrK (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:47:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55839 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeHPVrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:07 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so7653020itj.5
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSA0mtsD5i5jsjxg8eZ4R/5fOKIGegZ1s/6wu6KfDso=;
        b=GebAXvp1YhwTx+cElpVNvEWHEjd8HHgICV5hPjmTm+DS+IedfiBO3Ig/oFJI2eQkJ8
         Smndk8hzFe6yjRZpE7oBqtNmPygIKo9a1oiUK7/0Nkr6IBPSQAx1oMidqSRzdWOHRumo
         N5ava0rVeqfT3iYAXFw1rtF3bJwbbKZuJupFVBpfDaBgk2hTm2JJ95HmvYACgYx764Da
         voJ0cDAeAJAYtA5+z7en/YU2NtpvkG3bVRJonLWF/zxGJMU6bSPCmWAzNSjO3GgdaseE
         afbQ0gEc+isq8Ts5kM/lnpdlkv+cx6k4GJPVPyI1NipQgVe4wxxOcROmBIBwrNYdpORr
         yC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSA0mtsD5i5jsjxg8eZ4R/5fOKIGegZ1s/6wu6KfDso=;
        b=rnYZZLXR2a8Q8lVrhN8Ht7OhWrO8b3FJ/u6D5MofVISfMbaPl/9lzZvnST5izfScfZ
         op69FwyuhyZSM3/MGslblrqX4MrbF70vd5ykaBgAoAstDVnTbnso8/WSI4VLXnSB/rqL
         Pm5DI3lkCrIF8aDLPC/L3YQD3Rm2aYebFrMyelSH8a8sfvT1DBJx0uELm9a7BCG6asEg
         koY7L+yztvy4HSIC84p6wwBpUEqABqGWllF4BzqlC9gfD+14VzRUd8fF0Xgqv1nqo7Ge
         kFsMFiBpt5n2xdTsflviq2gl0rpYfa4Z2IHYCaE4KfGcsOTouy/ybWxVaMQRXt+kx9l5
         5OPg==
X-Gm-Message-State: AOUpUlFZ3e/di2dQI8vggcoVX3Jx5gIHpnzdGSxNPNZGfpzFNGFN/JVv
        ZLjyrlfIuL4rbeMyYPvjCqtlZvGBuSlQrGQAHmL+Zw==
X-Google-Smtp-Source: AA+uWPxBXUmyjS49k518qFxFqSZchH7aXjeUu+o29ENn0gHLBrg1Kx+MvvnMWVpkx5z+4fUhGHu2hcTJKE3CoFE681M=
X-Received: by 2002:a02:7e45:: with SMTP id h66-v6mr28251440jac.97.1534445218116;
 Thu, 16 Aug 2018 11:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180816183117.13716-1-pclouds@gmail.com> <20180816183903.GA3737@sigill.intra.peff.net>
In-Reply-To: <20180816183903.GA3737@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 20:46:31 +0200
Message-ID: <CACsJy8A7hoOGFCnVxTMdySr=8yUP+4tt4hNO6j-VnhKHJDyE7g@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 8:39 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 16, 2018 at 08:31:17PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > I just realized how often I type "git ci --amend". Looking back at my
> > ~/.bash_history (only 10k lines) this is the second most often git
> > command I type which may justify a short option for it (assuming that
> > other people use this option often too, of course).
> >
> > The short option space for 'git commit' is really crowded with
> > acCeFhimnopqsStuvz already taken. So it could be '-M' or '-A' but I'd
> > prefer not to hold shift, so I chose '-j' even though it's not
> > strictly related to "amend" (or perhaps we can thinking of amending as
> > joining commits).
> >
> > Thoughts?
>
> I also used to type it a lot. So I did:
>
>   $ type a
>   a is aliased to `git commit --amend'
>
> I don't know if that argues for or against a short option.

It's a "for" for me because I won't have my aliases on other people's machi=
nes.
--=20
Duy
