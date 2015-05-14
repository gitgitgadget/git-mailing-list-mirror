From: Lars Kellogg-Stedman <lars@redhat.com>
Subject: Re: [PATCH v5] http: add support for specifying an SSL cipher list
Date: Thu, 14 May 2015 15:25:52 -0400
Message-ID: <20150514192552.GB6475@redhat.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
 <1431091335-16455-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 21:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysylb-0001xw-SC
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933449AbbENTZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:25:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933340AbbENTZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:25:54 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4EJPqNi010033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2015 15:25:52 -0400
Received: from lkellogg-pk115wp.redhat.com ([10.18.57.8])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4EJPqu0029673;
	Thu, 14 May 2015 15:25:52 -0400
Received: by lkellogg-pk115wp.redhat.com (Postfix, from userid 1000)
	id 71E4FA0339; Thu, 14 May 2015 15:25:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1431091335-16455-1-git-send-email-lars@redhat.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269074>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 09:22:15AM -0400, Lars Kellogg-Stedman wrote:
> Teach git about a new option, "http.sslCipherList", which permits one to
> specify a list of ciphers to use when negotiating SSL connections.  The
> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
> variable.

Junio, et al,

I just wanted to follow up and see if folks were happy with the latest
version of the patch.

Cheers,

--=20
Lars Kellogg-Stedman <lars@redhat.com> | larsks @ {freenode,twitter,github}
Cloud Engineering / OpenStack          | http://blog.oddbit.com/


--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVVPbAAAoJEOTYsrE/X54pWboP/0jDIh/QEpLw3IrC/KJmTZ1z
xvBl6e9IzwUeqr1OmJw3wrnoxf0UfzqJfQA3fODzkLzzsU8gmUSozMwRgMOwKEtX
IOra88KjJaCXDvZgoPeVB/DXdOCAc1uHyEKT9wercDUjdXHG0seYm3kLg5hGV8GY
BFHcjxnx0ZPdGWhQM0ccR6yfsywCvLsCcru3NPeF5a4uXMQWRJbnIkrCwjT/qFc/
a/zh9+OZpcukI3YHI9P5t5ELm24IC4Y/10dUAJu3FtIwnAbI5DmIYiZcF0Og/3oh
fO1cIJCsCNuH+dY/PAKl+QXbps6RVUUniLGLrMn1YZD0vdqn1M26aNB3m0jUKnx4
oknfc9DUL1avGpO7YXLv4jTs5qqDMRiHoxN/8jeZ3RLVDYEG0f/qhs8vkRPTn3zH
hHhWYi0jB3QcEL31j3HGmX8EslnV6vIPjgfn1550ObCB0VeZM1sKec1INRChLrvH
tfLebLuqiu93OHN+kt28P6WSfZYUtuWuuX6l/W7gGDT2kBB5KwSaoToeLIpBba6h
RcgFqmziJi/IApv/HBVuxlYj8U2heOoknXUsh5ekjLgTxag6kHbJnBzENXl8Ehkc
0n0XDGBLy+mzG19cg5ff2dNQL8oDgHj7OWYBm5QNa9dYCoK676gzxX51PQpUkf+h
zT0H2szl27ovyZGuHUk5
=QEU6
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
