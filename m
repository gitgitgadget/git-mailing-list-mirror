From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Configure mutt to be used in git and lkml mailing lists (was: Re:
	[PATCH] git-svn: remove --first-parent, add --upstream)
Date: Fri, 7 Sep 2007 14:08:12 +0200
Message-ID: <20070907120812.GA4405@ferdyx.org>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com> <20070907084352.GD4538@xp.machine.xx> <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com> <20070907115130.GA1547@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITcdN-0000zm-6j
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbXIGMIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 08:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbXIGMIT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:08:19 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:46515
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965200AbXIGMIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 08:08:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 940AE8D307;
	Fri,  7 Sep 2007 14:08:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ferdyx.org
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UA90UP-NVAYO; Fri,  7 Sep 2007 14:08:54 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id D53C08D306;
	Fri,  7 Sep 2007 14:08:53 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Fri,  7 Sep 2007 14:08:13 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070907115130.GA1547@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58032>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 01:51:30PM +0200, Peter Baumann wrote:
> > [btw: could you please stop messing with 'Mail-Followup-To:'? When
> > replying to your mail, I don't want everyone _except_ you in the 'To:'
> > header...]
> >=20
>=20
> Sorry, I wasn't aware of that.
>=20
> I had a 'subscribe git@vger.kernel.org' in my muttrc and just pressed 'g'
> for group reply. Reading the docs suggested to 'set followup_to=3Dno' (as
> I did before sending this message). Per default it is set to 'yes'.
>=20
> Could anyone more experienced with mutt correct me if this was the wrong
> fix for this problem (or even point me to the right documentation)?
>=20

[I'm sending this to the list too so it ends up in the archives. I cut
the rest of the people from the To: list because this is not directly
relevant to them.]

Just don't use 'subscribe list' and mutt won't mess up with
mail-followup-to. Instead of using 'l' to reply-to-list keep using 'g'
to reply to everyone involved in the subthread and everything should be
fine :>

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG4T8sCkhbDGC9KNQRAmLzAKCSx/1PAtCFkwmdmeG22seEbjnsiACfdwFK
SiBVa2I7SjkRQEqdqqJ1/5E=
=FtkV
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
