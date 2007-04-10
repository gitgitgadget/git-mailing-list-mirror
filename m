From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 14:10:41 -0700
Message-ID: <20070410211040.GC18541@curie-int.orbis-terrarum.net>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net> <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 04:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbNbx-0000zR-UH
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 23:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbXDJVKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbXDJVKm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 17:10:42 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40862 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753878AbXDJVKl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 17:10:41 -0400
Received: (qmail 16453 invoked from network); 10 Apr 2007 21:10:39 -0000
Received: from Unknown (HELO orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 21:10:39 +0000
Received: (qmail 15022 invoked by uid 10000); 10 Apr 2007 14:10:41 -0700
Content-Disposition: inline
In-Reply-To: <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44165>


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2007 at 01:28:17PM -0700, Junio C Hamano wrote:
> Well, we need to do something about this.  I haven't seen
> Robin's patch neither on the list nor in my mailbox (if they
> were CC'ed to me).
They definitely were CC'd to you Junio.

> One thing that people need to be careful about is which SMTP
> server they use.  I had an impression (I do not use send-email
> myself) that it defaulted to local MTA, so the mail trail would
> look like your local MTA receives from the MUA (which is
> send-email), which forwards it to whereever destination (or
> intermediaries).  On the other hand, I suspect many people use
> their ISP's SMTP server when using their usual MUA, so the mail
> trail would look different.  I do not know what filtering vger
> does, but if it is filtering based on the MTA address
> (dul.dnsbl.sorbs filtering comes to mind), that would make a
> difference.
No, it's not SMTP path differences.

I _know_ that my mail path is identical for git-send-email as well as my
MUA, because I had problems with GIT and whitespace in email addresses
initially ;-).

Since I have access to all the mail servers in my path (home -> AUTH
SMTP @ work -> wherever), I dug at the logs, and found that vger did
indeed accept my email to the list, but the messages never turned up on
the list.

The only weirdness I saw in that, is that the envelope sender did not
appear to be set correct from git-send-email. Give me a moment to
explore down that path.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGG/1QPpIsIjIzwiwRArVjAJ49w7LZhArDCTimEoE+hJaLZ08cugCg0ivU
IWCAIyt5NGaLHZNWx4s7m3s=
=hZ3g
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
