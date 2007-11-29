From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] receive-pack: allow deletion of corrupt refs
Date: Thu, 29 Nov 2007 04:55:39 +0100
Message-ID: <20071129035539.GT1001@machine.or.cz>
References: <Pine.LNX.4.64.0711290101420.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxaVQ-0004wi-9x
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbXK2Dzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756090AbXK2Dzn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:55:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60359 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbXK2Dzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 22:55:42 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8603B5A5AB; Thu, 29 Nov 2007 04:55:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711290101420.27959@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66499>

  Hi,

On Thu, Nov 29, 2007 at 01:02:53AM +0000, Johannes Schindelin wrote:
> Occasionally, in some setups (*cough* forks on repo.or.cz *cough*) some
> refs go stale, e.g. when the forkee rebased and lost some objects needed
> by the fork.  The quick & dirty way to deal with those refs is to delete
> them and push them again.

  repo.or.cz now has this patch. I'm also repacking the kernel
repository which is in a pretty awful state, I'm hoping that will fix
some of the heavy performance problems repo.or.cz is hitting currently.

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
