From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 18:13:03 +0100
Organization: Home - http://www.obry.net
Message-ID: <4908999F.4040208@obry.net>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de> <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com> <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:14:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEcm-0002Hv-8i
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 18:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbYJ2RNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYJ2RNO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 13:13:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:5615 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbYJ2RNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 13:13:14 -0400
Received: by nf-out-0910.google.com with SMTP id d3so56399nfc.21
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 10:13:12 -0700 (PDT)
Received: by 10.86.63.19 with SMTP id l19mr5926949fga.57.1225300392343;
        Wed, 29 Oct 2008 10:13:12 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-40-132.w82-124.abo.wanadoo.fr [82.124.144.132])
        by mx.google.com with ESMTPS id 4sm417096fgg.4.2008.10.29.10.13.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 10:13:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
In-Reply-To: <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99386>

Johannes Schindelin a =E9crit :
> I completely disagree.  If the existing set of commands causes confus=
ion,=20
> we need to deprecate those parts and add new commands.  Even if we ha=
ve a=20
> ton of commands already.
>=20
> It does not need to hurt, either.  Just think of init-db.  Ever heard=
 of=20
> it?  We still have it, yet it is not relevant.

In this specific case adding a new command as an alias for a
command+option seems wrong! I much prefer adding the alias --staged for
--cached - as proposed now - if it can make things easier for new comer=
s.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
