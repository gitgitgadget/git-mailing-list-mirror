From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] show-branch --reflog: show the reflog message at the top.
Date: Fri, 19 Jan 2007 16:53:07 -0800
Message-ID: <7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84Tp-000300-Eq
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbXATAxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXATAxK
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:53:10 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35948 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965051AbXATAxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:53:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120005308.RRYX19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:53:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCtR1W00c1kojtg0000000; Fri, 19 Jan 2007 19:53:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 01:42:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37234>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 19 Jan 2007, Junio C Hamano wrote:
>
>> I still am having a hard time trying to explain what these
>> commands would do, and why they might be useful:
>> 
>> 	git-log --walk-reflogs master..next
>
> I had less problems explaining that when walking fell back to walking the 
> parents.
>
> It could even make sense to...

(meaning that is not what the code does...)

> Of course, you could always say: if you ask for strange things, you will 
> get strange things.

But if you have to say that, doesn't it suggest that accepting
the option --walk-reflogs when you have anything other than one
single positive commit in revs.pending leads to end user
confusion?

That's what I was after.  The theme is the same about my
hesitation against --reverse.

On the other hand,

>> 	git-log --walk-reflogs master -- Documentation/
>
> Ah, but that is way easier!
>
> For example: I _know_ that something worked some time ago, and it was 
> probably in git.c. So ask "git-log --walk-reflogs -- git.c", and you will 
> soon find out where to start bisecting.

there is no reason to forbid pathspec when --walk-reflogs is in
effect, which I agree.
