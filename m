From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Mon, 22 Feb 2016 18:50:23 +0000
Message-ID: <877fhwd1g0.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com> <87fuwnd4u7.fsf@freja.aidecoe.name> <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 03:46:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY2zb-000055-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 03:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbcBWCqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 21:46:20 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:49258 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701AbcBWCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 21:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=2JrWWtRKwo5zwJn+alrob7tJQBi1GPQeaalWhrW1rwY=;
	b=Z47wochEDDEnILgpRSI2+RQTbqXgWjAJxFNwbCnSa+8B7f1YTezp1BJ7RMiP7H2ANPwN8/x5icZIx8wIggZvmF3Y+X8ap5d3fNMLWrkS/n6p+++cMmTxMC3GM+Ia8XdaJ4L5xRFggqu3idSrzR96mBsnjcmIP/faXOYg+WlxwMJiZBBYoG/GyJVToz0nssCzYkaRGbu4NjfA0pr8GgE6pV26u3McYjx+YYqvL7GWTElo+5Bpi/fKKtnU+mWjkeGrR1iLHFTusZgtYTnzfId1DDW5l6A71QPgJdtS+cEJF5Nem3zQyrVG6rX80I8cFDo4zLrqXdVzz63G3hffE+7+RQ==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aXvYu-0000aw-N4; Mon, 22 Feb 2016 19:50:25 +0100
In-Reply-To: <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287008>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:
> I wonder if it makes sense to just silently allowing submit without
> rebasing, and without telling the user how to clean it up.

It is a good point. Maybe submit shouldn't be allowed by default at all
From=20bare repository. What do you think about following approach?  If
core.base is true, then if git-p4.submitFromBare is also true then
submit without performing proper rebase, but update master ref from
p4/master. If core.base is true, but git-p4.submitFromBare is false,
abort immediately. Submitting from bare repository would require aware
decision from a user.

Kind regards,

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJWy1hvXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcEyeoQAMz/0ZlYWydZHVxva9gGICLE
ze+l0zaUOxRUmD4VcdYPsePg9EOYIPZE76AnS4L9gVx22UR3Qp7YnLd7NsLva0Jt
qQUqc3wzVDMjLTYDmXyheqowaS6hTd2X15bnn5JizvlVndRHaPZEPHyzHjvCevDl
nJ+31nQuGTqyucBC1ZgTBQGzJXSPz/reVh5yS+j2b75m2ejTAlgbHvBCOVeqMOnI
EVinXmX0ZnUwbsAk3iUqUvgHnuNjZ2BRnsLLDFO7Yhah6YVgpxJITYFgT0cz46Ke
Qy8jDRsnrT2x48UkCfYUVLItLiaUhadd8YOADveOPKNcQbNfMEymQy5oij7dMUI4
Jr4h1xZwKkA50o7LYAvMg3pJlp4H2n9ZeA8W0sZqI1+u8j3cXBmPs1GOxJS4citZ
tJwGm7LRUOESAnFGTy5Os0VUD/ox7+ZzxQoHNiOMRTC9GsJxgSG+mqUGIdg4xGh9
q8bXn0KJ8Hz3twrAzeMBvh6fUFfB/bRcKt3IHEqacDH3Oucqnomrh+G2JUfTZoPX
g9WnGvU/11Tzw/lFD5QGzYG3FQlD7VuXhHZXIHhgDdzS//H2x3oZscG7gfEdtWo1
HwIPnOpb6xJDh4wuLoXK+SE57X9o6vZ1xD9GOpT0FYeg0kHq6MgP95irSOvH0g3O
iMEfUAqrnbppmU92EUM7
=b3d2
-----END PGP SIGNATURE-----
--=-=-=--
