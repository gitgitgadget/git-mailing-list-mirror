From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cogito: Avoid slowness when timewarping large trees.
Date: Sat, 25 Mar 2006 11:55:38 -0800
Message-ID: <7v3bh6wb7p.fsf@assigned-by-dhcp.cox.net>
References: <20060324084423.GA30213@coredump.intra.peff.net>
	<7vd5gc16u2.fsf@assigned-by-dhcp.cox.net>
	<20060324105543.GA2543@coredump.intra.peff.net>
	<7v3bh814z4.fsf@assigned-by-dhcp.cox.net>
	<20060324112246.GA5220@coredump.intra.peff.net>
	<20060324164352.GA20684@spearce.org>
	<20060325093641.GA26284@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 20:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNErW-0001p7-Gg
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 20:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWCYTzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCYTzn
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 14:55:43 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40183 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751142AbWCYTzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 14:55:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325195539.MPON26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 14:55:39 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20060325093641.GA26284@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 25 Mar 2006 04:36:41 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17994>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 24, 2006 at 11:43:52AM -0500, Shawn Pearce wrote:
>
>> Now that I think about it isn't this sort of where you were before
>> in cg-seek?
>
> Yes, that's basically it. Short of Junio explaining how the manual file
> removal can be avoided,...

Please don't let me slow you down -- that "git-read-tree --reset"
one was just confused.  I was not thinking clearly about the
modification you already had in the working tree which you
wanted to temporarily reset while switching.
