From: Junio C Hamano <junkio@cox.net>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 13:55:31 -0700
Message-ID: <7v3b3t3uws.fsf@assigned-by-dhcp.cox.net>
References: <1174825838.12540.5.camel@localhost>
	<vpqvegpe4e1.fsf@olympe.imag.fr> <20070325203901.GB12376@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Eric Lesh <eclesh@ucla.edu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZkW-0005Rs-0h
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXCYUzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXCYUzd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:55:33 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58032 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXCYUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:55:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325205532.VFZY1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 25 Mar 2007 16:55:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id f8vX1W00Z1kojtg0000000; Sun, 25 Mar 2007 16:55:32 -0400
In-Reply-To: <20070325203901.GB12376@spearce.org> (Shawn O. Pearce's message
	of "Sun, 25 Mar 2007 16:39:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43074>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Actually, I'd almost say put it into .git/config, e.g.:
>
> 	mkdir .git
> 	cat >.git/config <<EOF
> 	[core]
> 		repositoryversion = 0
> 		filemode = true
> 		link = /path/to/source
> 	EOF
>
> as then the index and HEAD file can both be stored in .git, just
> like with the non-gitlink case.

This is not usable at least for me as it does not allow sharing
the .git/config file across checkouts.
