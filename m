From: Junio C Hamano <junkio@cox.net>
Subject: Re: "fatal: Untracked working tree file 'so-and-so' would be overwritten by merge"
Date: Mon, 09 Oct 2006 23:32:31 -0700
Message-ID: <7vfydw7kao.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
	<7v7izaf62c.fsf@assigned-by-dhcp.cox.net>
	<7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610090858120.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 08:32:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBAK-00037a-T8
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWJJGcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWJJGcd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:32:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53495 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965019AbWJJGcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 02:32:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010063231.KDO6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 02:32:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YWYa1V00H1kojtg0000000
	Tue, 10 Oct 2006 02:32:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610090858120.3952@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 9 Oct 2006 09:03:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28607>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 8 Oct 2006, Junio C Hamano wrote:
>> 
>> Note note note.  The above patch alone leaves merge risky to
>> remove an untracked working tree files, and needs to be
>> compensated by corresponding checks to the git-merge-xxx
>> strategies.  The original code was overcautious, but was
>> protecting valid cases too.
>
> I think the difference _should_ be that we only remove the local file if 
> it was removed _remotely_.
>...
> Agreed?

I reviewed the patch I sent out, the one after the one you
responded to, and I think it (which is the one I have in "pu")
is in line with the reasoning you outlined in your message.
