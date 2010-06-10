From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Thu, 10 Jun 2010 09:30:00 -0700
Message-ID: <87k4q6hmuv.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org> <87eiggiy8g.fsf@yoom.home.cworth.org> <7vaar3nds1.fsf@alter.siamese.dyndns.org> <87pqzyhpl2.fsf@yoom.home.cworth.org> <87mxv2hola.fsf@yoom.home.cworth.org> <7vhblan9xw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 18:30:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMke6-0000WQ-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336Ab0FJQaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 12:30:14 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:47318 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab0FJQaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 12:30:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 41A704196F2;
	Thu, 10 Jun 2010 09:30:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykbdL2h-hlRO; Thu, 10 Jun 2010 09:30:01 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 8284F431FC1;
	Thu, 10 Jun 2010 09:30:01 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 2354F568E9B; Thu, 10 Jun 2010 09:30:01 -0700 (PDT)
In-Reply-To: <7vhblan9xw.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.3.1-61-ge870437 (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148888>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jun 2010 09:12:27 -0700, Junio C Hamano <gitster@pobox.com> wrot=
e:
> It sounds like that one good way to transition is to phase in --mbox as an
> optional feature and at a revision bump later make that the default (which
> would mean that we might need a --not-a-mbox option).  I haven't thought
> things through though...

OK. I'll put together a new, complete patch series implementing my best
attempt at all of this.

I'll make each commit address an actual bug in git as much as
possible.

For example, I suspect that "git am" is still passing a bare email to
mailsplit which can cause broken splitting for a message with a "From
... timestamp" line it. My current series doesn't test that, (nor try to
fix it), but that's all in the same family of bugs here.

Thanks for all the feedback,

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMERMJ6JDdNq8qSWgRApbsAJ4qMSjTbMYjuIKb9GZuu+cnhIRjpACeMeiv
Xc/ubyiFOsrk5vXMn0WoPEc=
=wJYo
-----END PGP SIGNATURE-----
--=-=-=--
