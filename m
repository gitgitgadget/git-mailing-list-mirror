From: Matteo Cypriani <mcy@lm7.fr>
Subject: Preserve merge changes with rebase -p
Date: Tue, 21 Jun 2011 14:11:25 +0200
Message-ID: <201106211411.31739.mcy@lm7.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart18700933.DuIT3dh9xJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 14:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ05x-0003rn-Oi
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 14:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab1FUMaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 08:30:11 -0400
Received: from adagio.lm7.fr ([91.121.68.23]:45152 "EHLO adagio.lm7.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab1FUMaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 08:30:10 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jun 2011 08:30:10 EDT
Received: from silence.localnet (lifc08.pu-pm.univ-fcomte.fr [194.57.85.147])
	by adagio.lm7.fr (Postfix) with ESMTPSA id 2E8AA30317
	for <git@vger.kernel.org>; Tue, 21 Jun 2011 14:11:33 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-2-amd64; KDE/4.6.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176138>

--nextPart18700933.DuIT3dh9xJ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I needed to change the author of a commit that was before a merge in the=20
history. Here is a figure of my situation, E being the commit I want to edi=
t,=20
and M the problematic merge commit:

     o---o---o---o---o---o---o---o  master
              \       \=20
               o---E---M---o---o  topic


In a simple case, git rebase -i -p from topic does the trick here, I can am=
end=20
E and M is re-created correctly.

The thing is, my M was not a "simple merge commit", but contained some chan=
ges=20
needed for the code in master and topic to work together. In that case, git=
=20
rebase -i -p recreates a merge commit, but it does not keep the changes=20
introduced in M.

Is there any way to keep the M's changes in my case (except to manually pat=
ch=20
& amend the re-created merge commit) ?
If not, maybe it would be a nice functionnality to implement ?

Cheers,
  Matteo

P.S.: Please CC me if you answer to this e-mail, as I'm not subscribed to t=
he=20
list.

=2D-=20
Ma clef GPG est disponible sur keyserver.veridis.com
My GPG key is available on keyserver.veridis.com

--nextPart18700933.DuIT3dh9xJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCAAGBQJOAIptAAoJEE6QGOCjKRJrWt0P/Ar20ZRSXe1Hx72mUxn8dOp1
DSgQetindbAH80oipAJ+DHy9UHqsFwfPnl75r9QuAI2IS5Fk7NwXQCiUAgkNgGiJ
5OQAsJdSe6SsbeG5EE1uyj+0w+GLgJlFS5esZrNvGSvhtD0PFuFRCx7jJ67MerXA
nwXxXnB8WUpmDuIfopPlNtltQSTuWiBiAxU8EZ7o2rRQcYMPYB8T4NFgwmXMP4rs
aywfXf36vKMKfxyFrLU3RH+EZ2Y4yDJa5owzb+rJYBakpRdiZ6xLKT9z/Ks6xRwC
+3cDB+3L1mDlOdpEkZjwd1LJSdF1LmWtnhac2vTWBD4mJmvXOGA3mhwiPsU8ej2i
23ZV0ADC7s9VxH7SOP+jcCLCHvQkqzoOVZrmvdKG3UicoRyyQhFhTZkfQl8zyeS1
7ToJMpE+XJsDcUnDy3ysvDqUXS4Z3hqiA20UK/D6OkAcVnJP3ac265ilzEzJlapp
6vV8xjCwg0q2mfjZUApC8VJWzvTvgi1wflOkCz4ESS02/Ae7Lj0nvk0I5adHQssB
S7jDdD354paE5zKt+eMgyCDyrV7Ot2VIOZblMYgRDwMnV5oskKO9mtf6UYFBEMzt
fgPa0rhuddvByqvChFwiUgjCF3Ax3D+3BKXfz1La1Z/FJDHlKQBuyHJ9FB2hhHpk
OxKl/rlJjjawGr0phhxb
=u8Vx
-----END PGP SIGNATURE-----

--nextPart18700933.DuIT3dh9xJ--
