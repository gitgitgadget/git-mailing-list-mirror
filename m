From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 15:39:43 +0200
Message-ID: <op.utw9khqa1e62zd@balu>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
 <op.utw7buoi1e62zd@balu>
 <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 15:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4bAD-0003DN-0F
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZENNjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 09:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZENNjp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:39:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:36785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752420AbZENNjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 09:39:45 -0400
Received: (qmail invoked by alias); 14 May 2009 13:39:45 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp045) with SMTP; 14 May 2009 15:39:45 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+Pw7lSNGaPmzF8JY6wMGgSrY4zdyQYf7NbqBxpAK
	EVq5bD75i4WBBh
Received: from [127.0.0.1] (helo=balu)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJMZA7-000DBS-P8; Thu, 14 May 2009 15:39:43 +0200
In-Reply-To: <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119190>

Am 14.05.2009, 15:16 Uhr, schrieb Alex Riesen <raa.lkml@gmail.com>:

> It may be not what your wanted, but it is how it is expected to work. If  
> git tag would reduce its arguments down to commits, it would be  
> impossible to sign tags at all (strictly speaking: it would be  
> impossible to create a
> tag, referencing another tag). Which is useful thing to have.

I'll kindly ask you again: please read my messages completely and  
carefully.

I gave up the idea of reducing tag objects to referencing commits two  
messages ago. That was one simple, early, and insufficient suggestion of  
mine to address the bug. It is no longer brought forward.

The bug itself (references to 'deleted' or 'replaced' tag objects remain  
reachable rather than becoming dangling) is still there without a  
suggestion to the solution, and you're uselessly the bug.

I may be wrong, but I do believe you still haven't understood my report -  
this may well be a problem in my way of phrasing it. So let's try this:

If you do not understand parts of the problem, please ask specific  
questions.

If you do not understand enough of this problem to ask such questions,  
please ignore this thread.

Please do not waste someone else's time by keeping up a discussion of  
arguments I've withdrawn hours ago.
I'm not going to repeat earlier reasons either.

-- 
Matthias Andree
