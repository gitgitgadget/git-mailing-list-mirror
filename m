From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 12:57:21 -0400
Message-ID: <20150507165721.GC16334@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
 <CALUzUxoC66QZ5gJdV_nE=zFOLUNfpz64Ena2rDmesaEqkEGDAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqP7C-0008Kj-CM
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbbEGQ5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:57:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbbEGQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:57:25 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t47GvMbj026883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2015 12:57:23 -0400
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47GvM7T012047;
	Thu, 7 May 2015 12:57:22 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id 1AA4CA0E2B; Thu,  7 May 2015 12:57:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CALUzUxoC66QZ5gJdV_nE=zFOLUNfpz64Ena2rDmesaEqkEGDAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268551>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 12:42:02AM +0800, Tay Ray Chuan wrote:
> You might want to mention the libcurl option that this conf
> corresponds to, so that a reader could go look it up in the libcurl
> documentation to get an idea of the ciphers available...

I actually removed references to the specific option before submitting
the patch, because none of the other settings that affect curl options
explicitly document the corresponding curl option name.  But I am
happy to add it back.

> to be used that would be accepted by us (but really by libcurl). But
> we also don't have to go as far as reproducing it here (eg. ciphers
> separated by colons) since this it tied to the libcurl version the
> user is linking against.

Right, I think that documenting the curl option is sufficient, and
then people can consult the libcurl documentation if they need
details.

--=20
Lars Kellogg-Stedman <lars@redhat.com> | larsks @ {freenode,twitter,github}
Cloud Engineering / OpenStack          | http://blog.oddbit.com/


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVS5lwAAoJEOTYsrE/X54pIpYP/RyyistBOnff0/nQFWrfpzP/
4MvOL4K/ZPc6c6MyMfJs8OvtaMGr0dF/7l3+FzJUzvF59aehXPLu8XECiIROf6+s
+scaX511xIHI5LrsCmpBmNwQPy7xyLEJv4mA1HbfvY7t9b9d9WWFE5/KAG6nMpeQ
KnUYCMzwffnHzkCiKuz70K018GtVUhD1uEBdTOoONCCXofDhY+EgwbQto82iA2UM
b+go7LYYz+Pmcmy6wIa2/ghQZBEl2Z0jWXjsAtZ92CTlwPR15siiewml4cnV7QWX
qnXm1kpPBf8vCH+qahh2PrrUfdADYi00DqDRqrpY8z3Za/1XYbiJo6GX+mtD3CQ5
7e9JmW7mxre/BPeoiycPStvRsSMVyczziGFjEAviuOS8NZtyLVjQ49lX7r0UckA5
Z1HH5W17rt86Bae3684/agCBzj7zQcvDSrAKcE2rMdky0SprTn5Xqviuxo7jAAsF
njMSW78lYggnqztN6UDQ6q0D0hk6owoiDLehDDzkzTHLt3yBLX7qd8u9exWg0fmb
qDSpn9XaYWdGwTS42IzP0rgC4pMaVSrqMp4XWi12OZcfJ/hSIeK0pjvMRfyrH+O9
PJYCr/gmGoCvcx5P81T31S+WFPM88h3akDMtSTyzLi5vS+pU4nsqGgpPitqrPuDJ
/2S8AcZQX2HnOE4FQgDs
=llxV
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
