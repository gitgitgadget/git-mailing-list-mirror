From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk with hyperspace support
Date: Fri, 2 Sep 2005 15:20:00 +0200
Message-ID: <81b0412b0509020620559ab811@mail.gmail.com>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
	 <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
	 <17171.47747.10616.537936@cargo.ozlabs.ibm.com>
	 <81b0412b0509011310386ee9a1@mail.gmail.com>
	 <51773.10.10.10.10.1125609974.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 15:21:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBBSp-0002L5-GQ
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 15:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVIBNUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVIBNUH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 09:20:07 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:30338 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751001AbVIBNUF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 09:20:05 -0400
Received: by nproxy.gmail.com with SMTP id x37so210625nfc
        for <git@vger.kernel.org>; Fri, 02 Sep 2005 06:20:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0BBlCG+Lx7QJFoiMH7f4EtpX1IqvLUtwo2dT3NjXc6Em7t6urfylKLD4jCiwOmINGiCMdmKW/Wu1VOK/uySMyR1yeF9e7ek3qP6bWi1Tu4D77Ii1uZG6KC/q/Saew3PabQVp8Fvmtp6kPytn6iZ9OcEcysqFvp1oTKQa6dXxqQ=
Received: by 10.49.5.17 with SMTP id h17mr160571nfi;
        Fri, 02 Sep 2005 06:20:00 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Fri, 2 Sep 2005 06:20:00 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <51773.10.10.10.10.1125609974.squirrel@linux1>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8024>

On 9/1/05, Sean <seanlkml@sympatico.ca> wrote:
> > BTW, did you sometimes notice lines you can't click at all?
> > An example is the red line on the most left side of the graph
> > by SHA 66129f88c4cc719591f687e5c8c764fe9d3e437a.
> For what it's worth, everything near that SHA1 works here as expected.
> Although I wasn't able to follow what you meant by "blue up-arrow through
> green left bump..." etc.   But all the lines respond to being clicked and
> all the arrow heads in that area properly jump to their corresponding
> commit.
> 
> That's with the latest checked out version of git and tcl/tk 8.4.9 as well.

I just tested it on another system (8.4.6, Slackware 10+), and it works
correctly too. Probably it is Gentoo's (or mine, you never know in Gentoo)
Tcl/Tk, which is broken somewhere.
