From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 09:43:44 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710190943.45201.wielemak@science.uva.nl>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <Pine.LNX.4.64.0710190054570.25221@racer.site> <4717F8CF.9060103@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Fri Oct 19 09:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iimgg-0003L2-PN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 09:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764599AbXJSHyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763316AbXJSHyP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 03:54:15 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:3960 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764599AbXJSHyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 03:54:13 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9J7nsZZ093487;
	Fri, 19 Oct 2007 09:49:58 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <4717F8CF.9060103@bluelane.com>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61665>

On Friday 19 October 2007 02:22, Pete/Piet Delaney wrote:
> We are definitely not fine with CVS, the branch merging isn't
> comfortable. I'm just wondering about maintaining the existing
> CVS browsers and the build scripts if it's not a big deal. I'll
> try the git-cvsserver path. If anyone has any war stories to share
> on the path this would be an ideal time to share them.

As for web browsing the history, our project was quickly convinced
gitweb is a lot better than cvsweb.  We are starting to get use to
basic git.  One developer works on CVS.  This is a bit handicapped,
but workable after a few patches to git-shell and git-cvsserver.

In another project I use git-cvsserver to do the Windows builds.
All development except for minor typos and compatibility things is
done on linux and cvs <-> git works just fine for that model.

	--- Jan
