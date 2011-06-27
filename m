From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 23:18:08 +0200
Message-ID: <1309209488.2497.363.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>  <4E08C89E.5020109@web.de>
	 <1309200722.2497.294.camel@Naugrim.eriador.com>  <4E08D279.7060202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:16:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJAn-0006cQ-E5
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab1F0VQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 17:16:06 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:38333 "EHLO
	mailgw21.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754150Ab1F0VPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:15:38 -0400
Received: by mailgw21.surf-town.net (Postfix, from userid 65534)
	id A6C254093; Mon, 27 Jun 2011 23:15:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw21.surf-town.net (Postfix) with ESMTP id 8128F4006;
	Mon, 27 Jun 2011 23:15:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw21.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw21.surf-town.net ([127.0.0.1])
	by localhost (mailgw21.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4c4ZHd9+Pfjh; Mon, 27 Jun 2011 23:15:31 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw21.surf-town.net (Postfix) with ESMTPSA id BAF2F40A4;
	Mon, 27 Jun 2011 23:15:28 +0200 (CEST)
In-Reply-To: <4E08D279.7060202@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176370>

Le lundi 27 juin 2011 =C3=A0 20:56 +0200, Jens Lehmann a =C3=A9crit :
> Am 27.06.2011 20:52, schrieb henri GEIST:
> > Le lundi 27 juin 2011 =C3=A0 20:14 +0200, Jens Lehmann a =C3=A9crit=
 :
> >> Am 27.06.2011 18:51, schrieb Junio C Hamano:
> >>> One possible working tree organization may look like this:
> >>>
> >>> 	-+- lib1
> >>>          +- project1/Makefile -- refers to ../lib1
> >>>          +- project2/Makefile -- refers to ../lib1
> >>
> >> This is what we do at work and it works really well for us. The
> >> possible downside (that you can't tie project1 and project2 to a
> >> specific version of lib1 in their own repo) is not a real problem
> >> in our experience, as the superproject ties the correct combinatio=
n
> >> together.
> >>
> >=20
> > That is a good starting point.
> > I have used this method for some little projects and it work great.
> >=20
> > But I had never find a mean to handle the case of project1 dependin=
g on
> > both lib1 and lib2.
>=20
> Hmm, but isn't that covered by having lib1, lib2 & project1 right nex=
t
> to each other in your superproject?
>=20

Sorry I havent read well your schema. I have thought that you reversed
dependency and put project1 and project2 inside libs1.

	Henri GEIST
