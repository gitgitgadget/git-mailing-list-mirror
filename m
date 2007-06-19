From: Simon Hausmann <simon@lst.de>
Subject: Re: merging git-p4 into git/fastimport.git (second try)
Date: Tue, 19 Jun 2007 08:42:09 +0200
Message-ID: <200706190842.13175.simon@lst.de>
References: <200706190036.01950.simon@lst.de> <20070618230018.GA6143@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1567835.78kc2fqzs3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 08:41:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0XPS-0003WV-Pj
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 08:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbXFSGlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 02:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXFSGlq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 02:41:46 -0400
Received: from verein.lst.de ([213.95.11.210]:37230 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbXFSGlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 02:41:45 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5J6fbo6021493
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 19 Jun 2007 08:41:38 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070618230018.GA6143@spearce.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50444>

--nextPart1567835.78kc2fqzs3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 19 June 2007 01:00:18 Shawn O. Pearce wrote:
> Simon Hausmann <simon@lst.de> wrote:
> > after reworking most of the really short commit logs and adding the
> > missing SOB lines I'd like to ask for consideration of merging git-p4 as
> > part of contrib/fastimport/ from
> >
> > 	git://repo.or.cz/fast-export.git git-p4
>
> Most of the commits look pretty good.  The effort you have put into
> cleaning them up shows.
>
> However, many of the oneline descriptions from Han-Wen Nienhuys
> are still really short and not very descriptive.  They won't look
> very good in Junio's "What's in git.git".  A few of yours are
> also pretty long winded for a typical oneline in git.git, but I'd
> rather have a descriptive-but-long oneline anytime over a short
> and undescriptive one.

Why not just leave out the entire lot of git-p4 logs in "What's in git.git"=
=20
this one time? I'm not sure of how much value it is at this point anyway. I=
'm=20
just interested in preserving the history to ease debugging.

> So I'm seriously considering merging this at this point.  I'm heading
> out to dinner and will look at it more again when I get back, but
> I think we should just bite the bullet and bring it into core Git.

There's also another option that might help to keep the logs clean for futu=
re=20
plain "git log" usage and that is to prepend a "git-p4:" prefix to most of=
=20
the logs. That makes "git-p4: Documentation cleanups" look better I think a=
nd=20
it's really easy to do.


Simon

--nextPart1567835.78kc2fqzs3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGd3rFWXvMThJCpvIRAsjnAKCpieHsPizxpOrFUPpEYN/+Wcdd6QCbBwj7
l287aGjhRQ4Kgei+Oc/76ec=
=QFgj
-----END PGP SIGNATURE-----

--nextPart1567835.78kc2fqzs3--
