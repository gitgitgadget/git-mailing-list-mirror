From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 21:31:45 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070208203145.GA26420@informatik.uni-freiburg.de>
References: <20070208075851.GB3950@spearce.org> <20070208082850.GA4334@informatik.uni-freiburg.de> <7vveidyqw5.fsf@assigned-by-dhcp.cox.net> <20070208183243.GA30673@spearce.org> <Pine.LNX.4.63.0702081937260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFvu-0004ka-Fo
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423305AbXBHUbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423317AbXBHUbu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:31:50 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55494 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423305AbXBHUbt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 15:31:49 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HFFvo-00064K-CU; Thu, 08 Feb 2007 21:31:48 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l18KVjGJ026510;
	Thu, 8 Feb 2007 21:31:45 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l18KVjlf026509;
	Thu, 8 Feb 2007 21:31:45 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702081937260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39086>

Johannes Schindelin wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> > > Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
> > >=20
> > > > Shawn O. Pearce wrote:
> > > >> Minor documentation improvements, as suggested on the Git mail=
ing
> > > >> list by Horst H. von Brand and Karl Hasselstr~A(P)m.
> > > > you have an encoding problem here     ---------^
> > > >
> > > > That "o umlaut" seems to be UTF-8 encoded, but the headers of y=
ou mail
> > > > claim iso-8859-1.
> > >=20
> > > I noticed it, too.  This seems to be purely between the
> > > format-patch output and the mailing list.  In Shawn's tree, the
> > > corresponding commit f842fdb0 does not have the encoding
> > > problem.
> >=20
> > Yes, correct.  I took great care to copy Uwe's name from a prior
> > commit of his in git.git, to make sure I got it spelled correctly
> > in the commit message.  :)
>=20
> Sometimes I think Uwe just took on another name for the sake of being=
 an=20
> Umlaut-PITA ;-)
I just want to point out, that it's Karl Hasselstr=F6m whose name got
misencoded here.  But I admit I'm kind of sensible for that.
>=20
> Ciao,
> J=F6h=E4nn=EBs "Dsch=F6" Schind=EBlin
So what about:
----- 8< ----
Subject: [PATCH] add Johannes proper name to .mailmap.

Up to now he kept secret how to spell his name properly, but now he rev=
ealed
himself :-)
---
 .mailmap |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.mailmap b/.mailmap
index c7a3a75..d6fcecb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -15,6 +15,7 @@ H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
 H. Peter Anvin <hpa@trantor.hos.anvin.org>
 Horst H. von Brand <vonbrand@inf.utfsm.cl>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
+J=F6h=E4nn=EBs "Dsch=F6" Schind=EBlin <Johannes.Schindelin@gmx.de>
 Jon Loeliger <jdl@freescale.com>
 Jon Seymour <jon@blackcubes.dyndns.org>
 Karl Hasselstr=F6m <kha@treskal.com>
--=20
1.5.0.rc2.gd1af2d

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc << EOF
[d1-d1<a]sa99d1<a1[rdn555760928P*pz1<a]salax
EOF
