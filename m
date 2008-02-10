From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 9 Feb 2008 17:22:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <alpine.LSU.1.00.0802100110450.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:23:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0v1-000082-Md
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbYBJBWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYBJBWt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:22:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43949 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819AbYBJBWt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 20:22:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1A1MLEi021491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Feb 2008 17:22:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1A1MLH1006717;
	Sat, 9 Feb 2008 17:22:21 -0800
In-Reply-To: <alpine.LSU.1.00.0802100110450.11591@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73283>



On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> 
> I was thinking the other night why I did not like the generation header.  
> And I found out why: it is redundant information.

Actually, that's not the real issue.

The real issue is that it doesn't work. I thought about it, and with 
multiple roots (which _can_ get merged together) it just isn't something 
that actually helps.

If you couldn't merge across roots, you could have a "uuid+generation 
header", but the moment you have multiple roots it actually gets quite 
complex.

So scratch the generation header.  It's not the answer.

And I do think that we can do it without it. I'm still thinking about how 
to do it efficiently, but I think I can get there. I just haven't had the 
time to sit down and really think it through and try out my ideas yet.

		Linus
