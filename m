From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 12:04:13 -0400
Message-ID: <20150507160413.GB16334@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
 <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:04:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOHc-0001pu-W7
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbbEGQEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbbEGQEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:04:15 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 4BE478EA4C;
	Thu,  7 May 2015 16:04:15 +0000 (UTC)
Received: from lkellogg-pk115wp.redhat.com (ovpn-112-66.phx2.redhat.com [10.3.112.66])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t47G4EcV014813;
	Thu, 7 May 2015 12:04:14 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id EF132A0E2B; Thu,  7 May 2015 12:04:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268537>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Apologies for the dupe; this should have been cc'd to the list]

> It is not clear to me what definition of "override" this sentence
> uses.

I was using it in what I thought was the common sense of "git will use
the value in the environment variable if it exists rather than any
value in the git configuration".  I apologize if this wasn't clear;
can you suggest how I might rephrase that?

> If you set something to this configuration variable, and if
> you want to revert the list back to whatever cURL uses by default,
> what exact value should I set GIT_SSL_CIPHER_LIST to?

So, with the current version of the patch there isn't an easy way to
say, "use the defaults instead of what is in my git configuration".
Setting GIT_SSL_CIPHER_LIST to an empty string would simply disable
SSL.

I'll submit a new version of the patch that treats an emtpy cipher
list as meaning, "do not explicitly set CURLOPT_SSL_CIPHER_LIST".

> I also wonder if this feature is something we would want a test or
> two to protect against future changes accidentally breaking it, but
> I do not offhand know how hard it would be to come up with a
> reasonable test.

Yeah, I looked briefly through the tests but I didn't see any existing
SSL tests and wasn't sure where to start.  I'm open to suggestions on
this front.

--=20
Lars Kellogg-Stedman <lars@redhat.com> | larsks @ {freenode,twitter,github}
Cloud Engineering / OpenStack          | http://blog.oddbit.com/


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVS4z9AAoJEOTYsrE/X54pLQoQAJQTNp+lFi3xta9RpBG+N/g9
xIQaSdEM/LGmk5wneajmIwynBUp+x/6KXddDyBs82KgDZN4/JLlyR2ce1qtcv8Te
ulcpK28U8HUcw9V80tck8jv/BUPeVQdnN6LjJVdR++dpXr83iV8Y5iuUaqdCfKEZ
LoKfdLueYKeLXTU80T5/sQZXEFR+iFtvzFWwQiW3AQgUC2O8yetXCCSxmVyDxY4k
0lPqnacP6GaSXYdN836gjt+yPvJaaR28G4buVXzsDPJ6S9T/MbPIpUyfLCCEeh87
Uc4u1vI3LT8mb6bHTzENeHG64r8f1Ah8RQFPrLU0N+kUVmnlhyyP+GTvP0iLw/pj
EMz6op+VBgnL/1GptxYkHb6+CYrqnb7I9zW/VB+QZW+QUqGr4ZmrahYg7cJDKGpd
DoUMJPn4q/1XecKCAuDpKJlVfBwtxTnTqm4qAxME2cdhBQEsTF46Wus7DVla4uw8
zEKlrVrBHMXoNYjvSuF/JjiaJDlLC9uJZXOVmsBDeWWCFfsU7p4rCuE8i27ELhX+
bUwZXr13xBT29IDJQrUCSnbvQ2/DaSPj+L0jXk1Vu7tjvn8JU8E6CB6qmPd+sAM5
qDAlVGPdIWAq//ilP+XNOkuKYpj/+bEzLatdoJjdymIvN/3fhwfmL/ThU+QEBmD+
EByElQIsPFRUOGGOm0RD
=k6NR
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
