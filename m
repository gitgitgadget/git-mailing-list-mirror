From: Jamey Sharp <jamey@minilop.net>
Subject: Re: Re* [PATCH 4/4] Add documentation for ref namespaces
Date: Thu, 15 Sep 2011 22:40:51 -0500
Message-ID: <20110916034051.GH3144@oh.minilop.net>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
 <1307470885-4018-5-git-send-email-jamey@minilop.net>
 <CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
 <7vaaa5pc8q.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 05:46:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4PNr-0001o7-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 05:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab1IPDk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 23:40:56 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:48341 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab1IPDkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 23:40:55 -0400
Received: by gwb17 with SMTP id 17so4013116gwb.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 20:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minilop.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KLoh4cUKEaHFtvKuOKFbhm+zFxsVRYKLxbFqBr0Q+5g=;
        b=BVKgTShs8TovQQPQSG4BHA19/wjEh0azojcVyqhRrYtF8yC0iv7srlFT3NXCCfM9Xv
         7jKpgkvtPcD6GInKWycdNBUbWaD+ubtJlDcbUDtHd/xnqQeeOl4/ING/eoJ0ArxDOrdE
         jFu7LmhSlDZbE/MYfOOaBw/sJkMUY27LvlEVQ=
Received: by 10.150.170.4 with SMTP id s4mr341201ybe.379.1316144454784;
        Thu, 15 Sep 2011 20:40:54 -0700 (PDT)
Received: from oh.minilop.net (adsl-76-239-16-239.dsl.emhril.sbcglobal.net [76.239.16.239])
        by mx.google.com with ESMTPS id k12sm20209208anc.19.2011.09.15.20.40.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 20:40:54 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1R4PIJ-0005ec-Ok; Thu, 15 Sep 2011 22:40:51 -0500
Content-Disposition: inline
In-Reply-To: <7vaaa5pc8q.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181525>


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2011 at 05:22:29PM -0700, Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:
> >
> >> Document the namespace mechanism in a new gitnamespaces(7) page.
> >> Reference it from receive-pack and upload-pack.
> >
> > This breaks the build on older asciidoc versions, the fix is to do
> > what I did in f5008f56d5aba06598e1c6272f4f55b4ee4bb016.
>=20
> Earlier I sent out a tongue-in-cheek "like this" that had a completely
> bogus SYNOPSIS section that is unusable in a released version of Git,
> hoping that somebody who _care_ more about the feature that the page
> describes would give us a better wording, but unfortunately it never
> happened.

I'm afraid your wit was too subtle for me, as I believed your proposal
was serious and would be applied as-is. I assumed AsciiDoc was going to
magically omit the bogus synopsis, somehow. Perhaps it should detect
when people are making fun of it, and ignore them then?

Your rationale for giving a more specific synopsis is sound, although:
1) git http-backend also supports the environment variable because it's
inherited by the underlying upload-pack and receive-pack; and 2) the
environment variable is an alternative to a general git command-line
option. How much detail do you want in a synopsis?

Assuming that you're happy with this level of detail, and that the
AsciiDoc syntax is correct (I'm not familiar enough with it), I'm happy
with the patch you propose---

Reviewed-by: Jamey Sharp <jamey@minilop.net>

> So here is a more realistic replacement, so that we won't have to suffer
> by complaints from people with older AsciiDoc saying "the release does not
> build". If we were to include this in 1.7.7 final, we now need to make
> sure we won't to have to hear from people with newer AsciiDoc saying "why
> do we have nonsense in SYNOPSIS section", so your help is needed here.
>=20
> I explicitly avoided saying:
>=20
> 	[verse]
> 	export GIT_NAMESPACE=3D<namespace>
>=20
> as nothing other than the selected transports seems to pay attention to
> this environment variable.
>=20
> -- >8 --
> Subject: [PATCH] Documentation/gitnamespaces.txt: cater to older asciidoc
>=20
> Older asciidoc (e.g. 8.2.5 on Centos 5.5) is unhappy if a manpage does not
> have a SYNOPSIS section. Show a sample (and a possibly bogus) command line
> of running two commands that pay attention to this environment variable
> with a customized value.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitnamespaces.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespace=
s.txt
> index ed8924e..c6713cf 100644
> --- a/Documentation/gitnamespaces.txt
> +++ b/Documentation/gitnamespaces.txt
> @@ -5,6 +5,13 @@ NAME
>  ----
>  gitnamespaces - Git namespaces
> =20
> +SYNOPSIS
> +--------
> +[verse]
> +GIT_NAMESPACE=3D<namespace> 'git upload-pack'
> +GIT_NAMESPACE=3D<namespace> 'git receive-pack'
> +
> +
>  DESCRIPTION
>  -----------
> =20
> --=20
> 1.7.7.rc1.3.g559357
>=20

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5yxUEACgkQp1aplQ4I9mXBpwCcC4ALf3nKqj4V1YUn3LZC3VQc
HaoAoIIJ00uL8MCMjKoSec88IXHTbrVD
=wzIf
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
