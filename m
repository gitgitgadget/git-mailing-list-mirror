From: Junio C Hamano <junkio@cox.net>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 18:35:31 -0800
Message-ID: <7vvezd9jt8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
	<46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
	<86hdaxf6wq.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510311822080.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 03:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWlzt-0007No-5L
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 03:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVKACfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 21:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKACfe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 21:35:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38324 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932557AbVKACfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 21:35:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101023515.HJE1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 21:35:15 -0500
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
cc: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510311822080.27915@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 31 Oct 2005 18:23:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10921>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 31 Oct 2005, Randal L. Schwartz wrote:
>> 
>> Martin>    cg-diff -r from:to | patch -p1
>> 
>> What's the easiest way then to toss all that intermediate history?
>> I'm thinking of the rcs "-o" switch that "outdates" any deltas in that
>> range.
>
> Start a new branch before the sequence you want to clean up. Then, move 
> the cleaned-up history to that branch, and eventually you can just delete 
> the old one.

Big caveat --- do that before you make that dirty tree available
to outside, otherwise you would be in hot water ;-)
