From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing
 ~/.gitconfig
Date: Fri, 11 May 2007 00:16:18 +0200
Message-ID: <200705110016.18319.johan@herland.net>
References: <200705102353.31821.johan@herland.net>
 <20070510220253.GZ13719@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart2023495.6psaocgKhz;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri May 11 00:17:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGwo-0006z5-QM
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762935AbXEJWQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761372AbXEJWQf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:16:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:62148 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762585AbXEJWQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:16:33 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHU00119J7KH500@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 00:16:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU00F8RJ766C30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 00:16:19 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU004KXJ76HT30@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 11 May 2007 00:16:18 +0200 (CEST)
In-reply-to: <20070510220253.GZ13719@fieldses.org>
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46912>

--nextPart2023495.6psaocgKhz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 May 2007, J. Bruce Fields wrote:
> On Thu, May 10, 2007 at 11:53:31PM +0200, Johan Herland wrote:
> > Use git-config for setting global user.name and user.email rather than
> > telling the user to edit ~/.gitconfig directly. This brings
> > user-manual.txt in line with tutorial.txt.
>
> The inconsistency is intentional.  We want users to know about
> git-config, because it's helpful when writing scripts, and because it
> has a useful manpage.  But we also want them to know about the
> config-file syntax, since most of us find reading and editing a file
> more intuitive than running git-config.  So we use a mixture of both.

I see your point, but when I look at the user manual, the only place I can=
=20
actually find git-config used is in [[remote-branch-configuration]].=20
Besides, we also present the config-file syntax for user.{name,email} in=20
[[telling-git-your-name]], so it's not like I'm remove every reference to=20
the layout of .gitconfig.

Maybe we can present both versions in [[making-changes]]?


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart2023495.6psaocgKhz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGQ5myBHj4kl4fT1wRAnbgAJ0YpusW6AQw42yPpm9hOLS2qxWZuACcD0M4
nOG4wUYwKI5EWICRTpg3BDs=
=0LLc
-----END PGP SIGNATURE-----

--nextPart2023495.6psaocgKhz--
