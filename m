From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Confusing language in man page
Date: Sun, 15 Jul 2007 11:40:38 +0200
Message-ID: <20070715094038.GE2568@steel.home>
References: <a781481a0707141108g4664a627w94e0d21c3629cb49@mail.gmail.com> <a781481a0707141327k5b6f8f43sc6330ff8cc504dd1@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Satyam Sharma <satyam.sharma@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 11:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA0bE-0007wx-N3
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 11:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbXGOJkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757450AbXGOJkl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 05:40:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:24721 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057AbXGOJkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 05:40:40 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo50) (RZmta 8.3)
	with ESMTP id z01c11j6F8fN82 ; Sun, 15 Jul 2007 11:40:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CE30C277BD;
	Sun, 15 Jul 2007 11:40:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A7948C164; Sun, 15 Jul 2007 11:40:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a781481a0707141327k5b6f8f43sc6330ff8cc504dd1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52538>

Satyam Sharma, Sat, Jul 14, 2007 22:27:52 +0200:
> * On my system, doing:
> 
> $ git diff
> 
> with no outstanding changes in my current working tree produces some
> bogus newlines, throwing the prompt to the bottom of the xterm window.
> This sounds like weird / undesirable behaviour and I have a feeling must
> already be fixed in latest git (?)

It is not git. It is the program less which git uses. The problem is
known to the author of less.
