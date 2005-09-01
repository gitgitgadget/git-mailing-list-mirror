From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: gitk with hyperspace support
Date: Thu, 1 Sep 2005 17:26:14 -0400 (EDT)
Message-ID: <51773.10.10.10.10.1125609974.squirrel@linux1>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com> 
    <7vr7ct124c.fsf@assigned-by-dhcp.cox.net> 
    <17171.47747.10616.537936@cargo.ozlabs.ibm.com>
    <81b0412b0509011310386ee9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 23:28:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAwZk-0001uC-8t
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 23:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVIAV0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVIAV0U
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 17:26:20 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:40672 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030396AbVIAV0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 17:26:19 -0400
Received: from linux1 ([64.231.206.41]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050901212615.NPTR1005.simmts12-srv.bellnexxia.net@linux1>;
          Thu, 1 Sep 2005 17:26:15 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j81LQC3p000483;
	Thu, 1 Sep 2005 17:26:12 -0400
Received: from 10.10.10.10
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 1 Sep 2005 17:26:14 -0400 (EDT)
In-Reply-To: <81b0412b0509011310386ee9a1@mail.gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8001>

On Thu, September 1, 2005 4:10 pm, Alex Riesen said:

> That's a fine feature :)
>
> BTW, did you sometimes notice lines you can't click at all?
> An example is the red line on the most left side of the graph
> by SHA 66129f88c4cc719591f687e5c8c764fe9d3e437a.
> It goes from blue up-arrow  through green left bump to the grey
> down-arrow (on my system in the kernel tree). Clicking on the blue
> arrow (on the line, not the arrow itself) will turn the blue line
> stricken-
> through with the red line (a bold blue line with a red streak inside),
> the next click leaves me with with just bold blue line and broken
> red line above it.

For what it's worth, everything near that SHA1 works here as expected.  
Although I wasn't able to follow what you meant by "blue up-arrow through
green left bump..." etc.   But all the lines respond to being clicked and
all the arrow heads in that area properly jump to their corresponding
commit.

That's with the latest checked out version of git and tcl/tk 8.4.9 as well.

Sean
