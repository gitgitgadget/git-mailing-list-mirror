From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: Fri, 29 Jul 2005 20:11:58 -0400
Message-ID: <20050730001158.GF32263@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 02:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyf1L-0008WE-Fk
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 02:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVG3ANn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 20:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVG3ANl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 20:13:41 -0400
Received: from mail.autoweb.net ([198.172.237.26]:15314 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262823AbVG3AMH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 20:12:07 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DyexK-00017t-Va; Fri, 29 Jul 2005 20:11:59 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dyf6u-0002XH-00; Fri, 29 Jul 2005 20:21:52 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DyexK-0004Wq-9C; Fri, 29 Jul 2005 20:11:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2005 at 03:50:30PM -0700, Linus Torvalds wrote:
> 
> This corner-case was triggered by a kernel commit that was not in date
> order, due to a misconfigured time zone that made the commit appear three
> hours older than it was.

Maybe it'd make sense to have the commits refuse to add a commit when it
would be younger than one of it's parents?

I suppose that only really fixes one direction of the other problem,
though.

-- 

Ryan Anderson
  sometimes Pug Majere
