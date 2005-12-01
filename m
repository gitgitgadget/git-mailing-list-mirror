From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-remotes slightly broken
Date: Thu, 01 Dec 2005 14:40:37 -0800
Message-ID: <7viru8cufu.fsf@assigned-by-dhcp.cox.net>
References: <438F76EA.2030104@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 23:43:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehx6Y-0006Aa-1r
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 23:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVLAWkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Dec 2005 17:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVLAWkj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 17:40:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2234 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932532AbVLAWkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 17:40:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201223955.VYSN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 17:39:55 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <438F76EA.2030104@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Thu, 01 Dec 2005 23:19:22 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13085>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> The commit e8cc80d03934cc607e3a4d89a05350c238dbf9c5 broke git-ls-remo=
te.
>
> git-sh-setup is no longer included, thus I get the following error.
>
> # cg-fetch=20
> Fetching pack (head and objects)...
> Fetching tags...
> fatal: unexpected EOF
> /home/lukas/bin/git-ls-remote: line 73: die: command not found
> Up to date.

Sorry, and thanks for the report.  Should be fixed with
1abacf3b5b53f6cde7148862234d451cd88d0de3 commit.
