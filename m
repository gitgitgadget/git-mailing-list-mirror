From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 01 Feb 2006 15:21:48 -0800
Message-ID: <7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 00:22:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4RIQ-0004Fz-04
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 00:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbWBAXVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423021AbWBAXVu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 18:21:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40853 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1423017AbWBAXVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 18:21:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201231908.JYGW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 18:19:08 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602012301.56141.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Wed, 1 Feb 2006 23:01:55 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15463>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> My question, in this case is there any reason (such as git creating home 
> directoriy temp files or something) why each developer could not have their 
> home directory as the root of all the repositories (ie where my git user in 
> the above example had its home directory).

Do you mean to reuse single directory /home/gitu/ for user A, B, C,
and hang repositories /home/gitu/{X,Y,Z} for projects?  I'd
imagine things could be arranged that way.  User A and B but not
C may be in "projectX" group and /home/gitu/X is writable only
by projectX group members and such...
