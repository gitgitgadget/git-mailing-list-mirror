From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] wt-status: show author info if status.showauthor is set
Date: Wed, 4 Apr 2007 09:49:17 +0300
Message-ID: <20070404064917.GE31984@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<20070404062447.GA4136@coredump.intra.peff.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:49:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYzJ5-0001B8-0Y
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbXDDGtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbXDDGtT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:49:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:21206 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbXDDGtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:49:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so556848uga
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 23:49:17 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr1216681ugh.1175669357266;
        Tue, 03 Apr 2007 23:49:17 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id 50sm1633587ugb.2007.04.03.23.49.16;
        Tue, 03 Apr 2007 23:49:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070404062447.GA4136@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43717>

> Quoting Jeff King <peff@peff.net>:
> Subject: [PATCH] wt-status: show author info if status.showauthor is set
> 
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Wed, Apr 04, 2007 at 09:02:13AM +0300, Michael S. Tsirkin wrote:
> 
> > - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
> >   commit message, and let the user edit them?
> 
> Personally I think it's just clutter, but hey, it's off by default. Of
> course what is the chance that you've turned on status.showauthor in
> your ~/.gitconfig, but you don't have your identity set up properly? :)

The point is that *someone else* can have showauthor set up in .gitconfig,
and then he'll be able to use git commit --amend to fix up
the identity without using --author explicitly.

-- 
MST
