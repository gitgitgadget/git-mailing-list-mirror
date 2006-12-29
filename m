From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 29 Dec 2006 10:25:38 -0800
Message-ID: <7vhcveo8yl.fsf@assigned-by-dhcp.cox.net>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 19:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0MQS-0007oF-2J
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 19:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWL2SZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbWL2SZl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 13:25:41 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52682 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbWL2SZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 13:25:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229182539.RFXH29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 13:25:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4iQt1W00a1kojtg0000000; Fri, 29 Dec 2006 13:24:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 29 Dec 2006 18:55:56 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35600>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 28 Dec 2006, Junio C Hamano wrote:
>
>> * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
>>  + git-merge: preserve and merge local changes when doing fast
>>    forward
>
> I'd like this, but behind a command line switch. And in addition to saying 
> "cannot merge, blabla needs update", git could spit out "if you want to 
> risk a 3way merge, go ahead and add the --preserve-local flag to 
> git-merge".
>
> Comments?

I think what you propose is in line is what I originally wanted
to do, but I backburnered it exactly because I did not like the
"if you want to risk a 3-way" phrase.  It's not the wording, but
the fact that I have to say "risk" bothers me.  No matter how
you cut it, it _is_ risky, and indicates to me that we are
somehow doing this in a wrong way. I have a nagging suspicion
that there may be a better approach, but I haven't found one.

But you are welcome to take a crack at it.
