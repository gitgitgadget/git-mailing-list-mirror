From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 31 May 2007 16:46:56 -0700
Message-ID: <7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site>
	<20070531002030.GA15714@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 01:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtuMC-0001qH-Jo
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 01:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbXEaXq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXEaXq7
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 19:46:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41698 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbXEaXq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 19:46:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070531234657.JLMZ1540.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 31 May 2007 19:46:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5zmw1X0091kojtg0000000; Thu, 31 May 2007 19:46:57 -0400
In-Reply-To: <20070531002030.GA15714@spearce.org> (Shawn O. Pearce's message
	of "Wed, 30 May 2007 20:20:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48831>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> As a porcelain author I'm finding it difficult to keep track of
> what features I can use in git-gui.  Newer versions of Git have
> newer capabilities but they don't always immediately get newer
> version numbers that I can easily test for.
>
> This is a simple plumbing option that lets a porcelain ask the
> plumbing for its capabilities, at which point the porcelain can
> work around anything missing, or recommend to the user that they
> upgrade their plumbing layer.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
> 	Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 	>
> 	> On Wed, 30 May 2007, Alex Riesen wrote:
> 	>
> 	> > git-version --features?
> 	>
> 	> Melikes.
>
> 	Good?

Hmmm.  I am not sure if you want list-features in the features
list -- how are you going to test for it?

Also I still do not understand why you want redirect-stderr.
Are you writing for a shell-less environment?
