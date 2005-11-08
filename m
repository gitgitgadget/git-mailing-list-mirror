From: Junio C Hamano <junkio@cox.net>
Subject: Re: Check for differents trees
Date: Tue, 08 Nov 2005 09:13:55 -0800
Message-ID: <7vhdanhxkc.fsf@assigned-by-dhcp.cox.net>
References: <20051106190249.39384.qmail@web26314.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 18:18:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZX2s-00014g-OP
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 18:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVKHRN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 12:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKHRN7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 12:13:59 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45486 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030274AbVKHRN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 12:13:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108171256.BMEZ2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 12:12:56 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051106190249.39384.qmail@web26314.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sun, 6 Nov 2005 11:02:49 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11342>

Marco Costalba <mcostalba@yahoo.it> writes:

>    as you said, the speed is almost the same but your way is clearly better.

How often do you do this --diff-filter=AD and why?

If it is a common enough operation, we could add a specific hack
to stop feeding the diff machinery with unwanted kind of changes
when diff-filter is set and none of -B/-C/-M are used.  That
_might_ speed things up for you.
