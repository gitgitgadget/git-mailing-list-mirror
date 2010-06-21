From: Zhang Le <r0bertz@gentoo.org>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Tue, 22 Jun 2010 02:35:47 +0800
Message-ID: <20100621183546.GC3631@adriano>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
 <7vocf939vu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Philippe Bruhat <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@i
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:36:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQlqw-0003yN-Do
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab0FUSgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 14:36:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37619 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0FUSgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:36:08 -0400
Received: by pwj8 with SMTP id 8so436260pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=3zFtIqZtzV0K2RIhOB8PXtDftElw2TD7ezNZ/rfsVGM=;
        b=jsENn91Z1iTutbSYNCY6AsLGv+hjynbyPLB0XhUEasApfAjUjTgp7nEeuley1pj9NM
         V8dFcPhhtjkxmHeKFjZWFg8kICtRWqu5jGkxJRFHtDhmM7B0gSsVaeBWqbaSjD+9/EvZ
         hFSMCsbms3EC1woGn2bGk5JtMp8osfG8xoIpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jus261gI5udJgCTRJHbSUT/44/TM+QNjTH6GSESFj5PSZHzD4d09iC6R85CbzRnQAX
         vGNTrI7qT/2Sm+2axY/rdMx5uSvwNJsbOcTZAJKGoNf1y+b9k6GF2Jt505f2OBTfOjHp
         wZyJqN/ntYFfDDw6zLaZB6EU/NAI9nMiRwn2Y=
Received: by 10.114.186.29 with SMTP id j29mr4325198waf.99.1277145367779;
        Mon, 21 Jun 2010 11:36:07 -0700 (PDT)
Received: from localhost ([119.123.201.172])
        by mx.google.com with ESMTPS id n32sm17814570wae.10.2010.06.21.11.35.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 11:36:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocf939vu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149431>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:24 Thu 17 Jun     , Junio C Hamano wrote:
> > * zl/mailinfo-recode-patch (2010-06-14) 2 commits
>=20
> The interaction between "-n --recode" needs to be fixed; it probably is Ok
> to reuse "i18n.commitEncoding".  Opinions?

I am thinking about adding "i18n.patchEncoding".
If no objection, I will submit a patch soon.

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkwfsQIACgkQvFHICB5OKXNEowCfQBpdMu4xkmWJW5AmbE+D18pX
dK0An10WIya67NuRLGkC+PUx9s8XPWK0
=olJn
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
