From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk" so
Date: Tue, 25 Mar 2008 00:48:32 -0400
Message-ID: <20080325044832.GB4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <200803241431.08633.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 05:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je167-0003HV-3l
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 05:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbYCYEsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 00:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYCYEsi
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 00:48:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60364 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYCYEsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 00:48:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Je15O-0002gt-Ek; Tue, 25 Mar 2008 00:48:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F101C20FBAE; Tue, 25 Mar 2008 00:48:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803241431.08633.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78145>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> M=C3=A5ndagen 24 March 2008 09.27.26 skrev Shawn O. Pearce:
> > OK, so I decided a few weeks back that the history page was not fas=
t
> > enough.  I think I've spent the past 3 weeks writing true revision
> > machinary for jgit, and now connecting it up to a UI visualizer.
> >
> >   git://repo.or.cz/egit/spearce.git plotter
> >
> > The history page has been completely replaced.  I saw Roger has
> > some patches against the current history page.  :-|
>=20
> Did you lose compare?
>=20
> Ok, found it, but it only shows one file in the compare editor, so I =
cannot=20
> walk through all changes in the commit with Ctrl-. and Ctrl-,

Yea.  The compare linkage in the prior history view was a little
unclear and I was trying to put something together.  So I went
with a really quick and dirty linkage that worked for the simple
single file case.  Ideally it should get fully ported over, but
the underlying concepts like GitFileRevision are probably going
to go by the wayside with RevWalk and TreeWalk being available.
So its probably trivial to port.

--=20
Shawn.
