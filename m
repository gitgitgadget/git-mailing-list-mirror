From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-clone: Sync documentation to usage note.
Date: Thu, 15 Feb 2007 17:38:02 -0500
Message-ID: <20070215223802.GA27992@spearce.org>
References: <117157763494-git-send-email-schlotter@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Schlotter <schlotter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHpFA-00028w-Kv
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161528AbXBOWiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbXBOWiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:38:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34482 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161528AbXBOWiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:38:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHpEh-0001s2-WF; Thu, 15 Feb 2007 17:37:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2EEDD20FBAE; Thu, 15 Feb 2007 17:38:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <117157763494-git-send-email-schlotter@users.sourceforge.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39861>

Christian Schlotter <schlotter@users.sourceforge.net> wrote:
> Please note that I was not able to test the new shallow clone feature, as
> both
>     git clone --depth=5 git://git2.kernel.org/pub/scm/git/git.git
> and
>     git clone --depth 5 git://git2.kernel.org/pub/scm/git/git.git
> do not seem to work.  The former correctly produces the usage note, while
> the latter prints
> 
>     Initialized empty Git repository in /home/cs/tmp2/git/.git/
>     fatal: read error (Connection reset by peer)
>     fetch-pack from 'git://git2.kernel.org/pub/scm/git/git.git' failed.
> 
> Is this a problem on my end?

Sort of.  ;-)

The server side must also support shallow clone.  I don't think
the server on kernel.org has been upgraded yet to a version which
supports that feature, so you cannot shallow clone from there.

-- 
Shawn.
