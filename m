From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] wt-status: show author info if status.showauthor is set
Date: Tue, 03 Apr 2007 23:52:17 -0700
Message-ID: <7vtzvw7hsu.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<20070404062447.GA4136@coredump.intra.peff.net>
	<20070404064917.GE31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYzLy-0002sF-LG
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966318AbXDDGwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966320AbXDDGwT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:52:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34334 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966318AbXDDGwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:52:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404065219.EULZ25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 02:52:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iusH1W00L1kojtg0000000; Wed, 04 Apr 2007 02:52:18 -0400
In-Reply-To: <20070404064917.GE31984@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 4 Apr 2007 09:49:17 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43718>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Personally I think it's just clutter, but hey, it's off by default. Of
>> course what is the chance that you've turned on status.showauthor in
>> your ~/.gitconfig, but you don't have your identity set up properly? :)
>
> The point is that *someone else* can have showauthor set up in .gitconfig,
> and then he'll be able to use git commit --amend to fix up
> the identity without using --author explicitly.

For that you would need to update git-commit, I think.
