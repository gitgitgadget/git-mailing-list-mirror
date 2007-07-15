From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Restoring files from old commits
Date: Sun, 15 Jul 2007 10:41:41 +0200
Message-ID: <20070715084141.GA2568@steel.home>
References: <4698BD17.5080205@random-state.net> <20070714123754.GA29622@piper.oerlikon.madduck.net> <20070714143233.GC2544@steel.home> <7vbqeeizue.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Nikodemus Siivola <nikodemus@random-state.net>,
	martin f krafft <madduck@madduck.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 10:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9zfo-0006AI-Jq
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 10:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbXGOIlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756605AbXGOIlp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 04:41:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:15152 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbXGOIlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 04:41:44 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (fruni mo16) (RZmta 8.3)
	with ESMTP id L00097j6F21XwW ; Sun, 15 Jul 2007 10:41:42 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A3540277BD;
	Sun, 15 Jul 2007 10:41:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 84D86C164; Sun, 15 Jul 2007 10:41:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbqeeizue.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52534>

Junio C Hamano, Sat, Jul 14, 2007 20:50:49 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> >
> > It does not work for directories, though.
> 
> Are you sure about that?  I just did this in my git.git workspace:
> 
> 	$ mv Documentation Documentation-
>         $ git checkout HEAD Documentation/
>         $ diff -r Documentation- Documentation
> 

Missed it. Happy now :)
