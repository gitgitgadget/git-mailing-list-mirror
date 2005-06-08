From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cogito-0.10 broken for cg-commit < logmessagefile
Date: Wed, 8 Jun 2005 20:17:47 +0200
Message-ID: <20050608181747.GA982@pasky.ji.cz>
References: <20050608144632.A28042@flint.arm.linux.org.uk> <tnxhdg8g6e1.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:15:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg53r-0003u2-VH
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFHSRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVFHSRw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:17:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60382 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261468AbVFHSRt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:17:49 -0400
Received: (qmail 2317 invoked by uid 2001); 8 Jun 2005 18:17:47 -0000
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Disposition: inline
In-Reply-To: <tnxhdg8g6e1.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 08, 2005 at 06:28:22PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@arm.com> told me that...
> Russell King <rmk@arm.linux.org.uk> wrote:
> > The command in the subject prepends the log message with a blank line.
> > This ain't good because it messes up commit messages as per Linus'
> > requirements (the first line must be a summary.)
> 
> The patch below should fix the problem. There is no point in writing
> the status information in a file which is read from stdin.

Oh, yes. Thanks, applied.

FYI, I plan to release 0.11.2 this evening. I'll try to go through some
more queued patches before and update cg-log to fully use git-rev-list.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
