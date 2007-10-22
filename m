From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Mon, 22 Oct 2007 12:04:28 -0600
Message-ID: <20071022180424.GA17429@ginosko.local>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xex50aa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 20:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik1dv-0001kA-OA
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 20:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXJVSEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXJVSEd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 14:04:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43882 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681AbXJVSEc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 14:04:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BC17034C6E;
	Mon, 22 Oct 2007 14:04:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 22 Oct 2007 14:04:31 -0400
X-Sasl-enc: ekqjAGz0Rv2q1eJLOvtnqDtWRUJk7vIbg4aN3w803Hdp 1193076271
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 1BF31707C;
	Mon, 22 Oct 2007 14:04:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v8xex50aa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62033>

On Fri, Feb 16, 2007 at 12:13:01PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 14 Feb 2007, Junio C Hamano wrote:
> >
> >> People often start out with "clone -l -s" (or --reference) and
> >> later wish to dissociate the repository from its alternates.
> >
> > Why not make a really dumb script which just _copies_ (or maybe 
> > optionally hard link) the objects from the alternate repo, and then kills 
> > the alternatives file? That should be easier. You always can repack after 
> > that.
> 
> I think that is much safer.

Was such a script ever incorporated into Git?

-- 
Michael
