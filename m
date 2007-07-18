From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Wed, 18 Jul 2007 11:10:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181102100.19849@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
 <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070718015138.GR32566@spearce.org>
 <46a038f90707171932m67c51388jb2304f0b1873e3a6@mail.gmail.com>
 <20070718025442.GX32566@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 12:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB6UC-00010W-P3
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 12:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763062AbXGRKKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763041AbXGRKKS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 06:10:18 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:38242 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756701AbXGRKKP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 06:10:15 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 19121B9A2D
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 11:10:14 +0100 (BST)
Received: (qmail 4203 invoked by uid 103); 18 Jul 2007 11:10:13 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.032927 secs); 18 Jul 2007 10:10:13 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Jul 2007 11:10:13 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070718025442.GX32566@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52847>

On Tue, 17 Jul 2007, Shawn O. Pearce wrote:

> The first fixes the -dirty build problem.  The second drops off
> the extra information that git-describe throws into the mix when
> it generates output for a non-tagged commit.  The third kills the
> rc* component if this is a release candidate.  Note that the rc*
> killer must come after the git-describe killer, as the rc* part is
> actually in the real tag.  The last one fixes the weird case where
> the user has somehow bungled his git software distribution so it
> cannot generate a git version via git-describe *and* they have no
> `version` file in the source code directory.  Such people really
> should fix their git.  But anyway we do support it now.

Well, I would say that my git is not broken, but simply temporary.  I 
have a machine that is not connected to the internet where I want to run 
git.  Normally I use release tarballs, but at the moment I need the recent 
changes to fast-import, so I am running whatever was master at the time I 
made the tarball.

As soon as 1.5.3 comes out I will be back to using the official releases. 
I just wanted to run git-gui blame (a rather nice tool) to look at what 
the result of my latest test import looked like.  Since I wasn't using git 
for anything other than playing with fast-import, creating a properly 
versioned git seemed like more effort than it was worth.

-- 
Julian

  ---
The major difference between bonds and bond traders is that the bonds will
eventually mature.
