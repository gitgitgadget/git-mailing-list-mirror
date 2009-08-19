From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [msysGit] Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Wed, 19 Aug 2009 15:26:13 +0200
Message-ID: <4A8BFD75.8000706@storm-olsen.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de> <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302> <4A8BA9EC.9000006@storm-olsen.com> <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302> <4A8BDAF6.5060805@gmail.com> <alpine.DEB.1.00.0908191455140.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03D060B7CEA384B5DAAF1331"
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 15:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdlBK-0004AZ-JT
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 15:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZHSN0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZHSN0R
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 09:26:17 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65459 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZHSN0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 09:26:16 -0400
Received: by bwz19 with SMTP id 19so4759734bwz.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 06:26:17 -0700 (PDT)
Received: by 10.204.162.143 with SMTP id v15mr4963475bkx.50.1250688376886;
        Wed, 19 Aug 2009 06:26:16 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 31sm197693fkt.13.2009.08.19.06.26.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 06:26:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0908191455140.5594@intel-tinevez-2-302>
X-Enigmail-Version: 0.96.0
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126546>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03D060B7CEA384B5DAAF1331
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 19.08.2009 14:56:
> On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:
>> Ok, but you would still have to rely on GNU Make in this setup,
>> and it would have to generate the common_cmds.h before you can
>> even compile with the MSVC IDE.
>=20
> But then I could bundle it up and give it to a Visual Studio user
> and they do not need msysGit.
>=20
> But maybe we should require them to have msysGit?  After all, if
> the package is too small, no Windows developer will take it
> seriously, right? ;-)

They would still require the rest of the msysgit environment to be=20
able to use the result. Not until we have zero scripts left as git=20
commands can we ditch the msysgit environment. So yes, even for=20
msvc-built git is msysgit required. Its just not build with MinGW.

--
=2Emarius


--------------enig03D060B7CEA384B5DAAF1331
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFKi/11KzzXl/njVP8RAv8IAKDF1SDdkXJKP8oP4lEdGQ6JnRzfOACg1/dd
WWArobW+GnBnFwxvtCxKPaY=
=zmfx
-----END PGP SIGNATURE-----

--------------enig03D060B7CEA384B5DAAF1331--
