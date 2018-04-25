Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D741F424
	for <e@80x24.org>; Wed, 25 Apr 2018 05:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDYFpH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 01:45:07 -0400
Received: from s019.cyon.net ([149.126.4.28]:44108 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeDYFpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 01:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nbz2+YyD/s/03Fp1alBP6roKcFZWc7Ntea0JWE0M7EM=; b=uvV6HgrS/HoAE0l8y5RO+Rs5ot
        lFHnPttOaqSUISvk2q0oYow+mIc5GxeLFr4O5UExFvMxHuqMhdxyi0C/tfy9EPQwYlaDXJF1iP7Lx
        ZWyq1ItIo8g2eKH7z+PbYkasm9RZ9qzY1WzwQDoU66ko7eGWozbWlyjpE5LzeKjfRWVUREDUMua9I
        HknDijiUmlTZf48awu6u/9LAqw6LABVWhkCxmE6GJgtSvNyG1oBoQmWtjzOd5sInubkr0gxO1Z9OK
        iF7+O1QnT7VNROEKal3cc3nZk0Y973Nfr9A2KdmD9mdYoE6dVokmmnm6p6gxkeWUUtG6DV2Gl1UWT
        /8qrR7Zg==;
Received: from [10.20.10.230] (port=24012 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89_1)
        (envelope-from <bb@drbeat.li>)
        id 1fBDEj-0003cP-1s
        for git@vger.kernel.org; Wed, 25 Apr 2018 07:45:04 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 83E512021B; Wed, 25 Apr 2018 07:45:00 +0200 (CEST)
Date:   Wed, 25 Apr 2018 07:45:00 +0200
From:   "Beat Bolli <bbolli@ewanet.ch>" <bb@zbox.drbeat.li>
To:     git@vger.kernel.org
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
Message-ID: <20180425054500.GA31531@zbox.drbeat.li>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 09:05:56AM +0900, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>=20
> > In modern setups, less, the pager, uses alternate screen to show
> > the content. When it is closed, it switches back to the original
> > screen, and all content is gone.
> >
> > It is not uncommon to request that the output remains visible in
> > the terminal. For this, the option --no-pager can be used. But
> > it is a bit cumbersome to type, even when command completion is
> > available. Provide a short option, -N, to make the option easier
> > accessible.
> >
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
>=20
> Heh, I used to append "|cat", which is four keystrokes that is a bit
> shorter than " --no-pager", but that is only acceptable when you do
> not care about colored output ;-)
>=20
> I am not absolutely certain about the choice of a single letter. I
> already checked we do not use "git -N cmd" for anything else right
> now, so I am certain about the availability, but I am not sure if
> capital 'N' is the best choice, when the other side is lowercase 'p'
> (and more importantly, the other side 'p' has mneomonic value for
> 'pagination', but 'N' merely stands for 'no' and could be negating
> anything, not related to pagination). But I agree that a short-hand
> would be welcome.
>=20

I'm quite fond of the notation "-p-", but that would set a precedent for
all other "--no-" options.

Maybe the option parser could be enhanced to allow for both?

Thanks,
Beat

> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index 4767860e72..17b50b0dc6 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -11,7 +11,7 @@ SYNOPSIS
> >  [verse]
> >  'git' [--version] [--help] [-C <path>] [-c <name>=3D<value>]
> >      [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
> > -    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
> > +    [-p|--paginate|-N|--no-pager] [--no-replace-objects] [--bare]
> >      [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
> >      [--super-prefix=3D<path>]
> >      <command> [<args>]
> > @@ -103,6 +103,7 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string=
 which `git config
> >  	configuration options (see the "Configuration Mechanism" section
> >  	below).
> > =20
> > +-N::
> >  --no-pager::
> >  	Do not pipe Git output into a pager.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRJ1XlK6nf5B3ZP2J4wS5PPUGqQOgUCWuAV2AAKCRAwS5PPUGqQ
Oi+DAKC+Zub6jWeMhBRueEYfWveFb3BougCfajLDr7oHP7n+x05ELSsJOjeeSrI=
=jrkC
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
