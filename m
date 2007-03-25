From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use diff* with --exit-code in git-am, git-rebase and git-merge-ours
Date: Sun, 25 Mar 2007 11:33:45 +0200
Message-ID: <20070325093345.GA2563@steel.home>
References: <20070325005613.GE11507@steel.home> <7vwt15c150.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVP75-00088z-EJ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306AbXCYJdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbXCYJdy
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:33:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:42009 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306AbXCYJdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:33:53 -0400
Received: from tigra.home (Fac04.f.strato-dslnet.de [195.4.172.4])
	by post.webmailer.de (fruni mo5) (RZmta 5.4)
	with ESMTP id P0578aj2P6cIye ; Sun, 25 Mar 2007 11:33:52 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A700D277B6;
	Sun, 25 Mar 2007 11:33:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4839CBF79; Sun, 25 Mar 2007 11:33:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwt15c150.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFm6
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43049>

Junio C Hamano, Sun, Mar 25, 2007 08:01:31 +0200:
> However, I have a few comments.
> 
> Have you run any benchmark?  I suspect "and speeds things up" is

I didn't benchmark any of these, so I can't backup the statement with
the number but...

> a gross overstatement.  A qualified "SOMETIMES speeds things up"
> would be a more honest thing to say.

it must speed things up, if only for removed shell-side efforts to
redirect the output and store it in heap. To overstatement it I should
have said: "greatly speeds things up".
