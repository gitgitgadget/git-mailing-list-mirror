From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 07:21:34 +0200
Message-ID: <20061012052134.GB10922@admingilde.org>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com> <20061011181425.GA10922@admingilde.org> <fcaeb9bf0610111446i35251fc9i6517cc5b3b53fe84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 07:21:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXt12-0008Nc-8F
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 07:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWJLFVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 01:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWJLFVf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 01:21:35 -0400
Received: from agent.admingilde.org ([213.95.21.5]:32411 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S965278AbWJLFVf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 01:21:35 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GXt0g-0000Uh-8s; Thu, 12 Oct 2006 07:21:34 +0200
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0610111446i35251fc9i6517cc5b3b53fe84@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28772>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Oct 12, 2006 at 04:46:51AM +0700, Nguyen Thai Ngoc Duy wrote:
> I thought about symlinks. However find will follow symlinks and
> traverse .git directories again. My goal is to prevent looking into
> .git directories

only with -L.

By default, find will not recurse into a symlinked directory.

--=20
Martin Waitz

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFLdDej/Eaxd/oD7IRAg6aAJ4jgzfVYaN2Z6pHnnFWut+6mY5RUQCffd3i
J3WY330roUnHxnoGnZjLM0E=
=7X+9
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
