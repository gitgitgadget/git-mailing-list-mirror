From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/16] Convert parts of refs.c to struct object_id
Date: Fri, 20 Mar 2015 19:55:55 +0000
Message-ID: <20150320195555.GL612775@vauxhall.crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq8uere9aj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ31b-0001KZ-AQ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbCTT4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:56:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50708 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994AbbCTT4C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:56:02 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3CC322808F;
	Fri, 20 Mar 2015 19:56:00 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqq8uere9aj.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265959>


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 12:52:20PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This is part 1 of n in converting code to use struct object_id.
>=20
> OK --- 'n' up there looked funny ;-)

It is, unfortunately, a large task.  I wish I could quantify it better
than N, but I expect it will be a progressive task stretching out over
several versions.

> I'd like to see the series reviewed by those who recently worked
> heavily on the subsystem involved (namely, refs API); please do not
> forget to include area experts to Cc the next time around when you
> update the other areas with the same theme.  On the other hand, once
> the "struct object_id" design is settled and everybody agrees that
> it is good enough, those who were involved in the review of that
> framework do not necessarily have to be on the Cc list (of course
> they are welcome to participate).  But reviews by area experts are
> more important to avoid breaking the users in the individual areas
> that are now going to use the new object-id infrastructure.

Okay, I'll do that next time around.  I expect to do at least one
reroll, so I'll CC them with the next iteration if they don't pipe up at
first.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVDHtLAAoJEL9TXYEfUvaL6AMP/R9AUHzaNVCsFIx7MxiKJVZa
iJv3lA7wTWMSQVs1SUlRMuAfOgH/owGeA9bvc6QVkHfPkBTHx1b9r4BsyDCzOuK2
fn/30n9SHUB1BFjUOWJ0qK2MqI6WpFSJ0XX/FokEEUvJl6H9ZaSdEFMQZWNRDX1K
ypGxV95xWKSwQDeft92EGCS0vC2U6ELjHOJG8xbyAWmwDD1tEM8pWgoGi+b3iyvv
CzJEp5frP6dBCmuf8J0lmLu67cTEfytqvypgiZBGxYE84cl3I/vgvZ63OM2OA5cG
5iZsG3OIUwYnNLGNJKdtcpUgap2+nIeUY3z//Zlgrx3davdRrbzeKdKwd+pLAHuc
294JHR2SFudV7JMfMIDV6FKOwy48cviu7trCa0oLNDU2gaILnQ/bRnHEr03fm4Bh
u5RDLdt/4N+VcHSeLifNsE+3NQziDflGfxoE/sOL5sm7UhCx6j2q8BD8EBcCVdny
xA56DstjaWTXr5dHYEvSnB7jIFtxNlKoUoG7FKe2wpGXZDUiKetpZyDWTbVanSrX
035MF7gnQrcEPDe+Ptwl9fukHcb9EIzvrMJVubm29LP2pQZSYfhzj4Sipv6pYttd
Gd26tvSlH4LAf4wGb+wlu1oInXPxQ7W0xmtEuBbTtr3BEqxWrIWVOB1h3xE3bdjf
S3jjvLICtEA5h+hDCunl
=ach0
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
