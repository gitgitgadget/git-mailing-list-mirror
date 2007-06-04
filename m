From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] gitview: Use new-style classes
Date: Mon, 04 Jun 2007 15:54:55 +1000
Message-ID: <1180936495.14488.3.camel@concordia.ozlabs.ibm.com>
References: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
	 <7vsl9awva8.fsf@assigned-by-dhcp.cox.net>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vo3QOK77+AvTdZnSrh/O"
Cc: aneesh.kumar@gmail.com, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 07:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5Wz-0007wA-Kq
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 07:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXFDFy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 01:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXFDFy7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 01:54:59 -0400
Received: from ozlabs.org ([203.10.76.45]:53025 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbXFDFy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 01:54:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 1FA6FDE052;
	Mon,  4 Jun 2007 15:54:56 +1000 (EST)
In-Reply-To: <7vsl9awva8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49063>


--=-vo3QOK77+AvTdZnSrh/O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-06-02 at 02:38 -0700, Junio C Hamano wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Aneesh, this one is in your bailiwick.
>=20
> Michael, it would have been nicer to have a real log message,
> not just the Subject line, in your message.  The Subject line
> says what the patch does in what subarea of the git.git tree,
> which is very appropriate, but that can be seen from the diff
> even if you did not say so.  The log message (before your
> Signed-off-by line) is where you describe _why_ you would think
> it is a good change.  "What" and "how" are usually evident in
> well written code without much explanation, but "why" is often
> more useful when reviewing the patch, and reading and studying
> the history of the code.
>=20
> I would have written something like:
>=20
> 	This changes the Commit class to use new-style class,
> 	which has been available since Python 2.2 (Dec 2001).
> 	This is a necessary step in order to use __slots__
> 	declaration so that we can reduce the memory footprint
> 	with my next patch.
>=20
> I have no strong preference on this change myself.  "Classes
> that derive from type" are relatively recent invention but I
> would personally feel that Python 2.2 is ancient enough that
> using it would not pose any practical portability issues, but
> what would I know...

Hi Junio,

Why write my own changelog when you do such a good job! ;)

But seriously, sorry about that. It was a case of me hacking on my local
git tree, not thinking anything would come of it, and then when I saw
the memory reduction from using __slots__ I decided to send off what I'd
done. I should have reset and recommitted with a decent changelog.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vo3QOK77+AvTdZnSrh/O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGY6kvdSjSd0sB4dIRAsctAJ9B80tda+1NidZq1UFiLAlqUHCGKACfZZE+
544ni3yUN+97jwyqr4O161A=
=M35Q
-----END PGP SIGNATURE-----

--=-vo3QOK77+AvTdZnSrh/O--
