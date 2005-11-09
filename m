From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with binary patches (pull) and spaces in filenames (gitk)
Date: Wed, 09 Nov 2005 14:09:41 -0800
Message-ID: <7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net>
References: <20051109213730.GA23052@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:13:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZy8Y-0005Mr-Rk
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVKIWJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVKIWJn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:09:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26260 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030398AbVKIWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 17:09:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109220910.WXC4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 17:09:10 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11421>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> 1) When pulling an updated binary files, I guess it still tries to 
>    print this update summary by making and processing patches, and so
>    gives this error:
>
>        Updating from ab1c4033ba98c043e13da3446e7f244ac7f79942 to
>        c164231f6b59fd80171e95f31d762a80d884c708.
>        Fast forward
>        fatal: patch with only garbage at line 3249

Hmm.  Perhaps a suboption to git-apply --stat to tell it not to
barf is helpful?  In the meantime, could you pull with -n flag?

> 2) When there are spaces in filenames, gitk only shows the first part of
>    the name in the filelist at the buttom right.

Another minor gitk gripe I have is that it does not look at
subdirectories of refs/{heads,tags}/ so I do not get labels to
my topic branch heads.
