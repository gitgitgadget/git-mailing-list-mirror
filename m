From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 11:09:05 -0800
Message-ID: <7vslrluze6.fsf@assigned-by-dhcp.cox.net>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
	<20060118125158.GN28365@pasky.or.cz>
	<20060118140917.GA15438@mythryan2.michonline.com>
	<Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
	<7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601181010410.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 20:09:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIgD-0006Z4-39
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWARTJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWARTJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:09:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34222 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030365AbWARTJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 14:09:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118190755.LFHH6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 14:07:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601181010410.3240@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Jan 2006 10:22:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14859>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 18 Jan 2006, Junio C Hamano wrote:
>> 
>> Tracking history across renames is something we have only half
>> of the needed support.  We can notice rename points but there is
>> no way to tell our usability tools to automatically follow it.
>> IOW "whatchanged r1/hello.c" will stop at the point the
>> original project renamed hello.c
>
> Note that "whatchanged" really really _really_ must not follow renames.

Sorry for having brought up the issue again.  I personally do
not disagree with you.  Because I did not want to waste your
time rehashing it, I attempted to make it absolutely clear that
I was talking about an _optional_ way to tell the tool to do so,
when somebody so used to "annotate" wants to.  Obviously my
attempt did not work well X-<.

> I realize that this is heresy to people who are used to "annotate" and 
> want to follow not the path, but the "conceptual inode", but the thing is, 
> paths really really are a lot more important to a maintainer. Following an 
> individual file is a secondary issue.
> ...
> In other words, tracking pathnames is really _fundamentally_ a more 
> powerful operation.

I agree with you including this part. At the same time, I think
annotate-minded people would find it useful if there were an
option (or a separate program similar to whatchanged) that
notices file or directory renames, and adjusts the initial path
limiter, probably by adding not replacing the new "possibly
relevant" paths it discovered to it.
