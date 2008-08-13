From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH 00/12] Allow users to access Perforce repositories requiring authentication
Date: Wed, 13 Aug 2008 21:47:41 +0200
Message-ID: <200808132147.55119.simon@lst.de>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23901996.7dP7tj7ohj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMMG-0000Hj-1X
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 21:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYHMTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYHMTsz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 15:48:55 -0400
Received: from hoat.troll.no ([62.70.27.150]:43393 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbYHMTsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 15:48:54 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 31D5D20B5A;
	Wed, 13 Aug 2008 21:48:49 +0200 (CEST)
Received: from rani.localnet (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id B7E9120AA2;
	Wed, 13 Aug 2008 21:48:48 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.24-19-generic; KDE/4.1.0; i686; ; )
In-Reply-To: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92256>

--nextPart23901996.7dP7tj7ohj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sunday 10 August 2008 20:26:23 Anand Kumria wrote:
> Hi,
>
> This series of patches refactors a few function calls into git-p4
> so that they all go via the same function to build up the command
> line.
>
> It also then allows users to specify any particular user / password
> required to access their Perforce repository (plus a few other parameters=
).
>
> I have specifically tested this agains the public Zimbra repository and
> it works for me fine. Any feedback would be welcomed.

Junio, I saw that you queued up this series in pu as ak/p4. I looked throug=
h=20
the patches and I think they look great. I suggest to include them into mas=
ter=20
after 1.6.0.

Anand, great work :)


Simon

--nextPart23901996.7dP7tj7ohj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIozprWXvMThJCpvIRAm/2AJ92d/uM74S4Pz110uUtZ2KbAP8LPwCgzDFv
ReUEshjH1Ysz4Cs7NL+vRKM=
=pqxC
-----END PGP SIGNATURE-----

--nextPart23901996.7dP7tj7ohj--
