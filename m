From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: questions about git-mktree
Date: Sun, 10 May 2009 17:12:00 +0200
Message-ID: <20090510151200.GA10189@pengutronix.de>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 17:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3AhN-0004Gw-Kh
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 17:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbZEJPMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbZEJPMH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 11:12:07 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48553 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbZEJPMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 11:12:06 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3Ah9-0000xE-KT; Sun, 10 May 2009 17:12:03 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3Ah6-0002NB-BJ; Sun, 10 May 2009 17:12:00 +0200
Content-Disposition: inline
In-Reply-To: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118720>

Hello Jon,

On Sun, May 10, 2009 at 11:41:17PM +1000, Jon Seymour wrote:
> Thanks for your explanation.
>=20
> Does git-mktree normalize the sort order of the input or take it as i=
t
> is? I can see  a case for having it do normalization, if it doesn't
> already and probably for this to be the default behaviour.
As git-mktree doesn't exists I cannot answer that question ...

Anyhow, another possibility to construct a tree is using the (or an)
index.

git-update-index --add --cacheinfo <mode> <object> <file> becomes handy
for constructing trees.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
