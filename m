From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix "git commit directory/" performance anomaly
Date: Fri, 10 Aug 2007 11:31:34 -0700
Message-ID: <7vsl6rs0l5.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
	<7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
	<7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
	<7v643ovyli.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJZGt-0006nG-KE
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 20:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbXHJSbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 14:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbXHJSbg
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 14:31:36 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62700 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbXHJSbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 14:31:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810183134.HUOG7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 10 Aug 2007 14:31:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aJXa1X0081kojtg0000000; Fri, 10 Aug 2007 14:31:34 -0400
In-Reply-To: <alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 10 Aug 2007 09:51:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55561>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This trivial patch avoids re-hashing files that are already clean in the 
> index. This mirrors what commit 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe 
> did for "git add .", only for "git commit ." instead.

Makes sense.  Thanks.
