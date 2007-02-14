From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui shows untracked files as "changed but not updated"
Date: Wed, 14 Feb 2007 14:33:26 -0500
Message-ID: <20070214193326.GB28290@spearce.org>
References: <45D339CD.4040603@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPtf-0006dt-LP
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbXBNTde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbXBNTde
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:33:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39760 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbXBNTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:33:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHPsZ-0000ZM-Ma; Wed, 14 Feb 2007 14:33:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B8CFC20FBAE; Wed, 14 Feb 2007 14:33:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45D339CD.4040603@arces.unibo.it>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39729>

Sergio Callegari <scallegari@arces.unibo.it> wrote:
> A short mail just to check if this is the intended behaviour...

Yes.  But it may not make sense.  As you may have thought, and why
this email started...

Basically it was laziness.  Originally git-gui used the current
layout (2 file lists) but the meaning of the lists was "existing
files" and "untracked files".  This turned out to really be hard to
use, especially when you are trying to work through merge conflicts.
Even _I_ had a tough time making use of that UI, and I knew what
I was doing.  ;-)

Refactoring the UI to its current design made a lot of sense, and
made git-gui very useful during merges.  But it left the untracked
files out in the wind with no place to show them.  Adding a new
file list was too much screen space (in my mind) and putting them
in the left ("Changes To Be Committed") is way wrong (as they won't
be committed by default), so the right list it was.

-- 
Shawn.
