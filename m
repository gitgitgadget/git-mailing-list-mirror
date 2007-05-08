From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to set git commit timestamp
Date: Mon, 7 May 2007 21:38:33 -0400
Message-ID: <20070508013833.GB11311@spearce.org>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de> <200705062151.40261.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Tue May 08 03:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEf7-0003Wi-85
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934425AbXEHBik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 21:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934429AbXEHBik
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:38:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51062 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934425AbXEHBik convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 21:38:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlEem-0001XC-4J; Mon, 07 May 2007 21:38:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C579520FBAE; Mon,  7 May 2007 21:38:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200705062151.40261.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46505>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 06 maj 2007 skrev Guido Ostkamp:
> > I am writing a tool to convert from another SCM to git and need to =
replay=20
> > all checkins. I know how to set the log message and the author, but=
 there=20
> > appears to be no command option for the timestamp (Mercurial for ex=
ample,=20
> > has a 'hg commit -d date <file>' syntax for this).
>=20
> If you are writing a converter then you should really use the plumbin=
g=20
> commands rather than porcelains like git-commit and in particular you=
 should=20
> look at git-fast-import for a  really fast methord of importing (and =
packing)=20
> objects.

As the author of a few convert-to-git things, fast-import really
is the easiest way to import stuff into git, even if it doesn't
need to be "fast".  The input format is quite simple to create,
and is documented pretty heavily in the git-fast-import manual page.

There's also contrib/fast-import/import-tars.pl which handles
decompressing and importing one or more tar files into a Git
repository.  Works pretty well...

So I agree with Robin, give fast-import a try.

--=20
Shawn.
