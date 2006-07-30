From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1]   Make git-tar-tree more flexible
Date: Sun, 30 Jul 2006 13:57:38 -0700
Message-ID: <7vbqr6dd4t.fsf@assigned-by-dhcp.cox.net>
References: <20060730174847.GA32574@eve.kumria.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 22:57:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7IM7-0007Oj-RG
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 22:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWG3U5k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWG3U5k
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 16:57:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15857 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932152AbWG3U5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 16:57:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060730205739.UEWF6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 16:57:39 -0400
To: Anand Kumria <wildfire@progsoc.org>
In-Reply-To: <20060730174847.GA32574@eve.kumria.com> (Anand Kumria's message
	of "Mon, 31 Jul 2006 03:48:47 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24473>

Anand Kumria <wildfire@progsoc.org> writes:

>   If you have a project which is setup like:
>      project
>      website
>   and you decide you wish to generate a tar archive of _just_ the 'project'
>   portion, git-tar-tree is not able to help. This patch adds two parameters
>   which can assist.

No need I see.

	git tar-tree tag-1.0:project project-1.0/project
	git tar-tree tag-1.0:project project-1.0
