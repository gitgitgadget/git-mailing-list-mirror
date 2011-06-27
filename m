From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 20:52:02 +0200
Message-ID: <1309200722.2497.294.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>  <4E08C89E.5020109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 27 20:51:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbGuW-0003rO-EW
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab1F0SvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 14:51:01 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:45119 "EHLO
	mailgw2.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753604Ab1F0Std (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:49:33 -0400
Received: by mailgw2.surf-town.net (Postfix, from userid 65534)
	id 04FF237C32; Mon, 27 Jun 2011 20:49:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw2.surf-town.net (Postfix) with ESMTP id C268137C6C;
	Mon, 27 Jun 2011 20:49:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw2.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw2.surf-town.net ([127.0.0.1])
	by localhost (mailgw2.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IjNLAcEbsBgV; Mon, 27 Jun 2011 20:49:25 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-35-11.w92-141.abo.wanadoo.fr [92.141.170.11])
	by mailgw2.surf-town.net (Postfix) with ESMTPSA id 6B9C437C32;
	Mon, 27 Jun 2011 20:49:23 +0200 (CEST)
In-Reply-To: <4E08C89E.5020109@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176362>

Le lundi 27 juin 2011 =C3=A0 20:14 +0200, Jens Lehmann a =C3=A9crit :
> Am 27.06.2011 18:51, schrieb Junio C Hamano:
> > One possible working tree organization may look like this:
> >=20
> > 	-+- lib1
> >          +- project1/Makefile -- refers to ../lib1
> >          +- project2/Makefile -- refers to ../lib1
>=20
> This is what we do at work and it works really well for us. The
> possible downside (that you can't tie project1 and project2 to a
> specific version of lib1 in their own repo) is not a real problem
> in our experience, as the superproject ties the correct combination
> together.
>=20

That is a good starting point.
I have used this method for some little projects and it work great.

But I had never find a mean to handle the case of project1 depending on
both lib1 and lib2.

	Henri GEIST
