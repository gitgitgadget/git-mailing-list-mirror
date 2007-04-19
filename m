From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 19 Apr 2007 02:23:57 +0200
Message-ID: <20070419002357.GC14247@steel.home>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 02:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeKRT-0005VH-4p
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 02:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993055AbXDSAYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 20:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993049AbXDSAYA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 20:24:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:34993 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993055AbXDSAYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 20:24:00 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (mrclete mo43) (RZmta 5.5)
	with ESMTP id D0014aj3INAIE6 ; Thu, 19 Apr 2007 02:23:58 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5895F277BD;
	Thu, 19 Apr 2007 02:23:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0309BBDDE; Thu, 19 Apr 2007 02:23:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44971>

Junio C Hamano, Thu, Apr 19, 2007 02:04:13 +0200:
> 
> Stalled; Alex has a set of tests that should go on top of this
> series but I haven't taken a look at it yet.  I think we should
> have enough for interested people to start futzing with, and I
> am wondering why nobody has sent a note saying "Hey, I did this
> using tree objects with commits in it, it works nicely for these
> operations but these things are still cumbersome to do and I
> need to polish it more".
> 

I am setting up a super-repo for my own very private use (small home
server setup). Still working on what _recursive_ tools do I really
need (and fsck is not the most interesting one: git-diff-files is. Am
afraid of releasing a system I wont ever be able to get to the source
of).

It is, as predicted, becoming mostly work on build infrastructure and
integrity checks in the super-project. Being the sole user of this
project I'll definitely miss all the issues of really big modularized
projects, though.

> 
> * jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
>  - Make read-cache.c "the_index" free.
>  - Move index-related variables into a structure.
> 
> A small part of libification; nobody seems to want it.
> 

No user _can_ want it. We need to make the future less a nightmare (it
may not even become one).
