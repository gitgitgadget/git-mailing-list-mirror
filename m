From: Junio C Hamano <junkio@cox.net>
Subject: Re: svn:externals using git submodules
Date: Tue, 01 May 2007 15:37:52 -0700
Message-ID: <7vzm4o41bz.fsf@assigned-by-dhcp.cox.net>
References: <200705011121.17172.andyparkins@gmail.com>
	<200705011936.14345.andyparkins@gmail.com>
	<20070501191703.GA25287@pe.Belkin>
	<200705012048.04817.andyparkins@gmail.com>
	<20070501202356.GA25531@pe.Belkin>
	<alpine.LFD.0.98.0705011512300.3808@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 02 00:37:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0ys-0001ET-IE
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbXEAWhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbXEAWhz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:37:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49321 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbXEAWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:37:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501223753.ZWSJ1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 18:37:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tyds1W0081kojtg0000000; Tue, 01 May 2007 18:37:52 -0400
In-Reply-To: <alpine.LFD.0.98.0705011512300.3808@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 1 May 2007 15:19:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 1 May 2007, Chris Shoemaker wrote:
>> 
>> Making git-svn handle svn:externals with specified revisions would be
>> _quite_ useful.  There's a special-case of this that I use personally:
>> svn:externals that point to other paths (and other revisions) of the
>> parent repo.
>
> Side note: even _without_ a specified revision, I think it's quite sane to 
> have the rule that a submodule hash of all zeroes is "unversioned".

Yup.

> But while I'm encouraged that the whole gitlink thing seems to be working 
> for Andy, and some others are playing with it too, I'm also a bit 
> discouraged by the fact that there hasn't been any noise or work on the 
> porcelain side. I was obviously optimistic and hoping we'd see support in 
> checkout/diff, but I haven't heard anybody talk about actually 
> implementing .gitmodules and the porcelain support that uses them..

The thing is, almost all the core git people happen to be busy
at the same time at this moment.  Johannes has just moved, Shawn
and I are deep in day-jobs to the neck, ...

Don't worry, it eventually will come.  
