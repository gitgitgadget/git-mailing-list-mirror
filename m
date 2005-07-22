From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 19:24:24 +0000
Message-ID: <20050722192424.GB8556@mars.ravnborg.org>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 19:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw1fs-0005Tz-4o
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 19:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVGVRut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGVRut
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 13:50:49 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:51857 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261374AbVGVRus
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 13:50:48 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 468805EE05B;
	Fri, 22 Jul 2005 19:50:25 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id AB3A76AC01D; Fri, 22 Jul 2005 19:24:24 +0000 (UTC)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnx1x5ryvn2.fsf@arm.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> I would use a neutral commit template, only that it should have a
> neutral prefix as well for the lines to be removed (neither STG nor CG
> but GIT maybe). The $GIT_DIR/commit-template is fine as a file name.

How about $GIT_DIR/commit-template-`basename $EDITOR`
Then we could have different templates for vim, emacs, kade etc.

	Sam
