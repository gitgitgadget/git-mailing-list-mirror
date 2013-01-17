From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: Re: t9902 fails (Was:  [PATCH] attr: fix off-by-one directory component length calculation)
Date: Thu, 17 Jan 2013 23:47:49 +0100
Message-ID: <201301172347.50157.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <20130115232400.GA16147@sigill.intra.peff.net> <50F64597.2070100@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvyFz-0000wR-AP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab3AQWsC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2013 17:48:02 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:41325 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab3AQWsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2013 17:48:00 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B9AE44B009F;
	Thu, 17 Jan 2013 23:47:52 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc3jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <50F64597.2070100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213887>

Le mercredi 16 janvier 2013 07:15:51, Torsten B=C3=B6gershausen a =C3=A9=
crit :
> On 01/16/2013 12:24 AM, Jeff King wrote:
> > On Tue, Jan 15, 2013 at 12:49:05PM -0800, Junio C Hamano wrote:
> >> "Jean-No=C3=ABl AVILA"<avila.jn@gmail.com>  writes:
> >>> Btw, the test 10 to t9902 is failing on my Debian testing. Is it =
a
> >>> known issue?
> >>=20
> >> Which branch?
> >=20
> > t9902.10 is overly sensitive to extra git commands in your PATH, as=
 well
> > as cruft in your build dir (especially if you have been building 'p=
u',
> > which has git-check-ignore). Try "make clean&&  make test".
> >=20
> > -Peff
>=20
> This may help, or it may not.
>=20
> If there are other binaries like
> "git-check-email" or "git-check-ignore" in the PATH
> .....
>=20
> When you switch to a branch generating a file like
> git-check-ignore then "make clean" will know about it
> and will remove it.
> If you switch to master, then "make clean" will not remove it.
>=20
> What does "git status" say?
>=20
> We had a discussion about this some weeks ago, but never concluded.
>=20
> How about this:
> http://comments.gmane.org/gmane.comp.version-control.git/211907

OK. I have installed practically everything related to git from the pac=
kage=20
manager and there is a git-checkout-branches utility available.

That result defeats the purpose of the test. This needs a tighter envir=
onment=20
to work whatever the configuration of the user may be.
