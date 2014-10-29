From: Thomas Schwinge <thomas@codesourcery.com>
Subject: Safe to interrupt =?utf-8?Q?=C2=BBgit?= gc =?utf-8?Q?--auto=C2=AB?=
 =?utf-8?Q?=3F?=
Date: Wed, 29 Oct 2014 16:06:36 +0100
Message-ID: <87fve6gbk3.fsf@kepler.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:07:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjUq0-0006i3-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 16:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663AbaJ2PG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 11:06:59 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:63608 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933592AbaJ2PG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 11:06:58 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1XjUpt-0005pG-4e from Thomas_Schwinge@mentor.com 
	for git@vger.kernel.org; Wed, 29 Oct 2014 08:06:57 -0700
Received: from feldtkeller.schwinge.homeip.net (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.3.181.6; Wed, 29 Oct 2014 15:06:56 +0000
User-Agent: Notmuch/0.9-101-g81dad07 (http://notmuchmail.org) Emacs/24.3.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I couldn't find this answered in the documentation: if, instead of
exiting right away, a =C2=BBgit gc --auto=C2=AB actually commences its hous=
ekeeping
tasks, is it safe to interrupt (C-c, SIGINT) the original git invocation
at this point, or might this cause any inconsistencies, data loss, or
failure to perform the task Git has originally been invoked for?  I
generally do find the auto-housekeeping useful, just sometimes it happens
at the "wrong" moment, and so I'd like to delay it until next time.


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUUQJ8AAoJEK3/DN1sMFFt7A0IAKZxwYsNXA9nSatXHzNUSm/b
qbKSxSN1yoK88EHH+TIeO6N5TeLm/WsBEYz7CAMqQaWbMQR7c24t1FXa/6sX1xEZ
i9iX6buu6aok1y9vDcrDny8WlyrPyK93PRQEpww3Cw/slrOUJw9NlR03dVQRK4O6
so6txsZtdvh0ceHYUEFWu+xM/JEBQlkuBY2WJKrpaSXCoSQzzYpxQxzjPxKAUwoQ
jQsHe4zDJqJie7RwRd0GW0onoIYhexLW6synFGBPdMm72j4kHLrK9HvLmENkWcRw
gSuxqzuZdd38B4EMI/jP5xQdWrbjT95M1+5qE1T90w/o7ug22uGfK8gQi1froVE=
=SRZ5
-----END PGP SIGNATURE-----
--=-=-=--
