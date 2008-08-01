From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 12:56:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0lX-0006dC-UF
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYHAT5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYHAT5O
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:57:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42001 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbYHAT5N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 15:57:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71JuicP030170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 12:56:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Jui0d032552;
	Fri, 1 Aug 2008 12:56:44 -0700
In-Reply-To: <20080801124550.26b9efc0.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91082>



On Fri, 1 Aug 2008, Andrew Morton wrote:
> 
> That's how I noticed it - copied, pasted, MTA barfed.
> 
> Converting a usable name+email-address into an unusable one seems ... unuseful.

Umm. Those signed-off ones weren't even _converted_ They were written by 
people.

Also, you seemed to miss the point that it's not a name+email-address. 

It's a name. Oh, and there's an email address too. But they aren't 
connected. We often just print out the name *without* the email address. 
Why should those things have to know about some totally irrelevant email 
quoting rules? They weren't emails, didn't know about it, and didn't care.

			Linus
