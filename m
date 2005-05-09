From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Mon, 9 May 2005 12:41:59 -0400 (EDT)
Message-ID: <3087.10.10.10.24.1115656919.squirrel@linux1>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
    <2637.10.10.10.24.1115425225.squirrel@linux1>
    <7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
    <2721.10.10.10.24.1115425962.squirrel@linux1>
    <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
    <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>
    <7vll6oz755.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 19:17:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVBDa-0004WK-3y
	for gcvg-git@gmane.org; Mon, 09 May 2005 18:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVEIQmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVEIQmE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 12:42:04 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:22414 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261154AbVEIQmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 12:42:00 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509164159.WBTY1542.simmts12-srv.bellnexxia.net@linux1>;
          Mon, 9 May 2005 12:41:59 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j49GfwYJ007360;
	Mon, 9 May 2005 12:41:58 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 9 May 2005 12:41:59 -0400 (EDT)
In-Reply-To: <7vll6oz755.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2005 12:38 pm, Junio C Hamano said:
>>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:
>
> HPA> Naming the environment variables SHA1_FILE_<anything> is almost
> HPA> certainly wrong; a much more logical name would be
> HPA> GIT_<something>. It'd also be much less likely to cause conflicts.
>
> Exactly my feeling from the beginning.
>
> But you have to realize that you are suggesting to change the
> SHA1_FILE_DIRECTORY that was there from almost the beginning as
> well.  I know the code change required for the rename is
> minimum, but there are users involved.  My feeling is that we
> should contain the damage by changing the definition of
> DB_ENVIRONMENT in cache.h sooner rather than later, but I do not
> think this is the week to do it.
>
>

What about creating a transition plan that uses the GIT_ name if it exists
and the SHA1_ name if it doesn't.  And mark the SHA1_ name as depreciated.
 That should be okay to do this week, no?

Sean


