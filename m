From: Junio C Hamano <junkio@cox.net>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 22:10:00 -0800
Message-ID: <7v1wwrys07.fsf@assigned-by-dhcp.cox.net>
References: <20060325035423.GB31504@buici.com>
	<Pine.LNX.4.64.0603242014160.15714@g5.osdl.org>
	<20060325043507.GA14644@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 07:10:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN1yW-0007DK-Gp
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWCYGKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWCYGKE
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:10:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33515 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751015AbWCYGKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:10:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325061002.QOIJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 01:10:02 -0500
To: Marc Singer <elf@buici.com>
In-Reply-To: <20060325043507.GA14644@buici.com> (Marc Singer's message of
	"Fri, 24 Mar 2006 20:35:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17955>

Marc Singer <elf@buici.com> writes:

>> 	git merge "Merge with Linus" work linus
>> 
>> instead, which will use the proper "recursive" merge functionality.
>
> OK.  I'll see if that is more successful.  It would be nice if the
> resolve command printed a message about the command being deprecated.

The only reason I didn't do that was because I just did not want
to disrupt the workflow by Linus.  If nobody in the upper
echelon of kernel people (meaning, longest-time git users) use
git-resolve anymore, I think we should mark it deprecated and
remove it eventually.
