From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 08:08:13 +0100
Message-ID: <20100114070812.GD1528@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <20100114154154.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVJoe-0000qn-Kb
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0ANHIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 02:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149Ab0ANHIQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:08:16 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:47477 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755058Ab0ANHIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:08:15 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 02:08:14 EST
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVJoT-0006zW-43; Thu, 14 Jan 2010 08:08:13 +0100
Content-Disposition: inline
In-Reply-To: <20100114154154.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136956>

On Thu, Jan 14, 2010 at 03:41:54PM +0900, Nanako Shiraishi wrote:
> Quoting Rudolf Polzer <divVerent@alientrap.org>
> 
> > I'd like a feature to automatically "transform" a non-tracking local
> > branch into a tracking branch on push. A patch to do that is attached.
> 
> How well does this take earlier discussions on the same topic into account? For example, did you study the design discussion in
>   http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=135390

I don't really think this has much to do with the other. git branch
--will-track still means one needs to know it at branch setup time, and git
pull --remember still means one needs to type way more stuff than with a simple
push --track.

But well, given the discussion here I see the feature is essentially rejected,
and already was rejected a previous time. Will probably forget about this and
make a shell script that does for ME what I want.

Best regards,

Rudolf
