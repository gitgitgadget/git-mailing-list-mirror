From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 23:42:34 -0800
Message-ID: <7v64missd1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
	<7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 08:42:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIhhR-0004VK-TF
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 08:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCMHmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 02:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWCMHmi
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 02:42:38 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2549 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932234AbWCMHmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 02:42:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313074047.NXWT6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 02:40:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17559>

Linus Torvalds <torvalds@osdl.org> writes:

> Just compare the result...
>
> Now, that said, they _both_ find some pretty funky renames. I think there 
> is probably some serious room for improvement, regardless (or at least 
> changing the default similarity cut-off to something better ;)

Yes.  The "compare with larger" seems to cull nonsensical ones
found by "next" one much better.
