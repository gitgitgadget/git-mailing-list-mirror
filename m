From: "R. Tyler Croy" <tyler@monkeypox.org>
Subject: Re: ACLs for GIT
Date: Sun, 15 May 2011 13:16:08 -0700
Message-ID: <20110515201608.GX6349@kiwi.flexilis.local>
References: <4DD02876.1040404@bbn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="anW2uJ7hcMI/vMa8"
Cc: git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhq8-0006hg-R3
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab1EOUW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:22:56 -0400
Received: from mail.geekisp.com ([216.168.135.169]:37526 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751378Ab1EOUWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:22:55 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 May 2011 16:22:55 EDT
Received: (qmail 22496 invoked by uid 1003); 15 May 2011 20:16:13 -0000
Received: from unknown (HELO kiwi.flexilis.local) (tyler@monkeypox.org@209.204.163.3)
  by mail.geekisp.com with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 May 2011 20:16:12 -0000
Mail-Followup-To: Martin L Resnick <mresnick@bbn.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4DD02876.1040404@bbn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173659>


--anW2uJ7hcMI/vMa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, 15 May 2011, Martin L Resnick wrote:

> Is anyone working on adding access control to GIT ?
>=20
> I'm looking for the Subversion equivalent of mod_authz_svn.
> I need to restrict read access of ITAR documents that are
> scattered throughout the source tree.
> This restriction would need to deny fetch of the ITAR
> documents yet allow fetch of any other files.
>=20
> Looking through the source code it would seem that
> putting a hook call in the fetch-pack code would do it.

It sounds like 'gitolite' might be what you're looking for:
<https://github.com/sitaramc/gitolite>

- R. Tyler Croy
--------------------------------------
    Code: http://github.com/rtyler
 Chatter: http://identi.ca/agentdero
          http://twitter.com/agentdero

--anW2uJ7hcMI/vMa8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk3QNIgACgkQFCbH3D9R4W+D/gCcCydalR+63UY4cxmY5GTLmntt
RWkAn12ZmhTGzP/+AmSExp9w8s45RuVv
=+FiU
-----END PGP SIGNATURE-----

--anW2uJ7hcMI/vMa8--
