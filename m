From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Wed, 20 Aug 2008 06:36:46 +0200
Message-ID: <20080820043646.GH11842@schiele.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org> <20080819072650.GE11842@schiele.dyndns.org> <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net> <20080819091830.GG11842@schiele.dyndns.org> <7vbpzoy53d.fsf@gitster.siamese.dyndns.org> <7vzln8trzj.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+xDcZ1j08+V/OfU"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 06:39:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVfTb-0005Q4-Mz
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 06:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYHTEgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 00:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYHTEgu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 00:36:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1517 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYHTEgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 00:36:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so195557fgg.17
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=gBVTzjCuLT56tux9DHMNp0mD1mkA3ScgnT+tr8DgcxU=;
        b=dYObMSnZ5WmhvzeaW7ZZXlfDS5Je4uMGTPlpM9ds7affZD17MhzB6DYf8CnKMMJGDq
         pNjP4kP0lHC3d6opkIoIKLR/Gs0raC7HgM0CAxQPKiBJ7YWJiYk31N+XiVM12TRE6QHw
         3U2bLMNzYAmeru/+pmRNM9NMlVShMPGVcMSh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=qNFomr9hzDxxJJQRXgeqZ4lxkrt8jzAZIEkfhU3yj3ezeVyrCkGstfOQLLeOgHOHJi
         rb/Ek9cWEypNlnDvOCRpiAN1TkW5zB6++M/DtR0wy8hzNwl7VT9rMQ8q6WQsre+G6CNC
         tQgzlz3iPDz7rxaGrdvpvs8k74YJRN19wgtek=
Received: by 10.86.63.19 with SMTP id l19mr6170330fga.77.1219207008051;
        Tue, 19 Aug 2008 21:36:48 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.86.104])
        by mx.google.com with ESMTPS id 4sm1229907fgg.4.2008.08.19.21.36.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 21:36:47 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 52C8E1604F; Wed, 20 Aug 2008 06:36:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzln8trzj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92962>


--J+xDcZ1j08+V/OfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 06:06:24PM -0700, Junio C Hamano wrote:
> The result would look like this two-patch series.
>=20
>  [1/2] shell: do not play duplicated definition games to shrink the execu=
table
>  [2/2] Build-in "git-shell"

Thanks, this makes the Sun compilers happy again without the need of weired
hacks.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--J+xDcZ1j08+V/OfU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIq59excDFxyGNGNcRAhPsAKCTd7AmWlrJWnsMHrP3B25o+yCeQwCePr43
c9BqESUAxqWk7Vyi+ajJdq8=
=OdW1
-----END PGP SIGNATURE-----

--J+xDcZ1j08+V/OfU--
