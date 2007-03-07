From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mercurial to git
Date: Wed, 7 Mar 2007 18:14:21 -0500
Message-ID: <20070307231421.GF27922@spearce.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5LH-0002ck-V1
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992718AbXCGXO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992722AbXCGXO3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:14:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56655 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992719AbXCGXO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:14:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP5Kn-0006o3-WC; Wed, 07 Mar 2007 18:14:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E7B2E20FBAE; Wed,  7 Mar 2007 18:14:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41700>

Rocco Rutte <pdmef@gmx.net> wrote:
> Somewhat related: It would be really nice to teach git-fast-import to 
> init from a previously saved mark file. Right now I use hg revision 
> numbers as marks, let git-fast-import save them, and read them back next 
> time. These are needed to map hg revisions to git SHA1s in case I need 
> to reference something in an incremental import from an earlier run. It 
> would be nice if git-fast-import could do this on its own so that all 
> consumers can benefit and can have persistent marks accross sessions.

Done.  See the new --import-marks option.

The following changes since commit c390ae97beb9e8cdab159b593ea9659e8096c4db:
  Li Yang (1):
        gitweb: Change to use explicitly function call cgi->escapHTML()

are found in the git repository at:

  git://repo.or.cz:/git/fastimport.git

Shawn O. Pearce (3):
      Preallocate memory earlier in fast-import
      Use atomic updates to the fast-import mark file
      Allow fast-import frontends to reload the marks table

 Documentation/git-fast-import.txt |   13 +++++-
 fast-import.c                     |   85 +++++++++++++++++++++++++++++-------
 t/t9300-fast-import.sh            |    8 ++++
 3 files changed, 88 insertions(+), 18 deletions(-)

-- 
Shawn.
