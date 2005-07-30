From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Sat, 30 Jul 2005 01:07:12 -0700
Message-ID: <7virys4szz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0507300118060.25709@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:08:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DymOX-0001tO-0A
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 10:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVG3IHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVG3IHQ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 04:07:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31692 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263007AbVG3IHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 04:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730080701.YCBY16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 04:07:01 -0400
To: barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.62.0507300118060.25709@iabervon.org> (barkalow@iabervon.org's message of "Sat, 30 Jul 2005 01:40:53 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

barkalow@iabervon.org writes:

> I still have the patch to make git-http-pull download packs, and I
> should be able to get it to read the objects/info/packs file without
> too much trouble.

Another thing that may help you gain more parallelism in the
initial set of requests is the rev-cache file.  You can find out
the ancestry information upfront by reading it, without waiting
for the commits you asked to arrive.
