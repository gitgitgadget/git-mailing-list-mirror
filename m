From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Fri, 11 May 2007 09:45:18 -0700
Message-ID: <7v7irfcns1.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <f20gjc$rne$1@sea.gmane.org>
	<7vd518gkyo.fsf@assigned-by-dhcp.cox.net>
	<200705111326.35577.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 18:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYFD-0006we-Mg
	for gcvg-git@gmane.org; Fri, 11 May 2007 18:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbXEKQpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 12:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757075AbXEKQpV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 12:45:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46612 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbXEKQpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 12:45:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511164520.VXRP6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 12:45:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xslJ1W00w1kojtg0000000; Fri, 11 May 2007 12:45:19 -0400
In-Reply-To: <200705111326.35577.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 11 May 2007 13:26:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46963>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 11 May 2007, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> In the new version of git I *think* you can use "git add -u path/"
>> 
>> I know you meant well, but next time could you please check the
>> fact before speaking?
>
>> 		if (i < argc)
>> 			die("-u and explicit paths are incompatible");
>
>> The list is getting more and more cluttered recently, perhaps
>> which is a good sign that more new people are actually using
>> git.  Let's try to keep the signal quality of the messages on
>> the list high.
>
> I'm sorry I haven't checked this before writing, especially that
> information in the synopsis contradict a bit the information in
> the `-u' option description:
> ...
>   -u::
>         Update all files that git already knows about. This is what
>         "git commit -a" does in preparation for making a commit.

What does "git commit -a" do?  Does it take paths?

> I think however that "git add -u dir/" could be quite useful; it is
> not needed to have `-u' and explicit paths incompatibile.

I tend to agree, and I think that change should not be too
difficult.

Also it might make sense to have "git commit" use it in the
"git-commit --only $paths" codepath.  I dunno.
