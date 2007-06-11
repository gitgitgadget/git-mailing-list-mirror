From: Simon Hausmann <simon@lst.de>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 16:56:33 +0200
Message-ID: <200706111656.33696.simon@lst.de>
References: <20070608202236.GJ25093@menevado.ms.com> <20070611142525.GN25093@menevado.ms.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15760814.c1XoaKntI0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 16:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxlIx-0007uJ-Km
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 16:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbXFKOzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXFKOzh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 10:55:37 -0400
Received: from verein.lst.de ([213.95.11.210]:55990 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbXFKOzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 10:55:36 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5BEtXo6001953
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 16:55:34 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070611142525.GN25093@menevado.ms.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49856>

--nextPart15760814.c1XoaKntI0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 June 2007 16:25:25 Kevin Green wrote:
> Reading this again, the subject was probably misleading...  Sorry for tha=
t.
>
> In the meantime I've been scouring the archives looking for the proper way
> to import p4 history into a project.
>
> I'm attempting to use git-p4import.py as that's what came with my version
> of git.  I ran into the problems below.
>
> How can I properly migrate a project from perforce to git?

*plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git .=
 It=20
should be just a matter of calling

	git-p4 clone //depot/path

or

	git-p4 clone //depot/path@all

(the former if you just want perforce #head, the latter if you want to impo=
rt=20
all revisions).


Simon


--nextPart15760814.c1XoaKntI0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbWKhWXvMThJCpvIRAmrdAKCfTdcvSz+Q1p+EB/cJef4QIv4/dwCgoM8U
/N0NX552bMlb/8wCWWCwCO8=
=X74K
-----END PGP SIGNATURE-----

--nextPart15760814.c1XoaKntI0--
