From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 16:48:46 +0100
Organization: NextSoft
Message-ID: <200803051648.46799.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803051600.06605.michal.rokos@nextsoft.cz> <47CEBAA3.5060109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvs3-0004q3-4v
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbYCEPsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 10:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbYCEPsx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:48:53 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:46060 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYCEPsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 10:48:52 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 292E7873; Wed,  5 Mar 2008 16:48:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 53952872;
	Wed,  5 Mar 2008 16:48:50 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30882-08; Wed, 5 Mar 2008 16:48:50 +0100 (CET)
Received: from 89-24-238-42.i4g.tmcz.cz (89-24-238-42.i4g.tmcz.cz [89.24.238.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 0DE2646B;
	Wed,  5 Mar 2008 16:48:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47CEBAA3.5060109@viscovery.net>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76232>

Hi,

On Wednesday 05 March 2008 16:22:11 Johannes Sixt wrote:
> Michal Rokos schrieb:
> > Thank you for your comments; is this better?
>
> Better, but still not there. See below. The configure test looks fine=
, but
> I can't test it.
>
> Finally, please make this a proper patch with Signed-off-by for Junio=
 to
> pick up.

Did that. Thank you for your review.

> What if maxsize =3D=3D 0? Insert here:
>
> 	if (maxsize < 250)
> 		maxsize =3D 250;

I've just used 128 which I hope is OK - it's multiplied 4 * anyway.

Michal

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
