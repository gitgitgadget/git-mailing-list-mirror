From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: trivial: remove the dots at the end of file names
Date: Sat, 7 Jan 2006 11:32:02 +0100
Message-ID: <20060107103202.GC5536@steel.home>
References: <81b0412b0601050346v43dc1e58k7e0b51c6d6817d1e@mail.gmail.com> <7vu0chrniz.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBMr-0005al-W9
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWAGKcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWAGKcK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:32:10 -0500
Received: from devrace.com ([198.63.210.113]:29192 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030397AbWAGKcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 05:32:09 -0500
Received: from tigra.home (p54A073FD.dip.t-dialin.net [84.160.115.253])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k07AW6n8045302;
	Sat, 7 Jan 2006 04:32:07 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EvBMg-0000EF-00; Sat, 07 Jan 2006 11:32:02 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EvBMg-0001WV-Qy; Sat, 07 Jan 2006 11:32:02 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0chrniz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14253>

Junio C Hamano, Fri, Jan 06, 2006 23:37:24 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Subject: [PATCH] Remove the dots at the end of file names
> > to make the output more mouse copy-paste friendly.
> 
> > -		echo "ERROR: Merge conflict in $4."
> > +		echo "ERROR: Merge conflict in $4"
> 
> Hmph.  I think there are places we state pathname within 'single
> quotes' as a part of sentence, which may have the same issue.

No-no-no! These are perfectly fine (for bash, at least)!

> I understand and am sympathetic to the motivation, but at the same
> time messages that do not end with full-stop somehow make me feel
> quite uneasy. I'll swallow the patch; maybe it is just me.

I hope so. Don't you ever use mouse copy-pasting?!
