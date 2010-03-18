From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 10:27:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 18:31:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsJYr-0000Ns-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 18:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab0CRRbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 13:31:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54799 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448Ab0CRRbB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 13:31:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IHUgvN005890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 10:30:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IHUfQF005728;
	Thu, 18 Mar 2010 10:30:42 -0700
In-Reply-To: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142483>



On Thu, 18 Mar 2010, Michael Witten wrote:
>
> Short Version:
> -------------
> 
> Rather than use a (name,email) pair to identify people, let's use
> a (uuid,name,email) triplet.

Even shorter version: NO.

> Long Version:
> ------------

UUID's are some total crazy shit. It's like XML. If you think you need 
them, you're almost certainly wrong. If it's about identifying a unique 
piece of hardware, ok. If it's about identifying people, no.

How about you walk around with a bar-code tattooed to your forehead? Don't 
like the idea? Then think about having to care about a uuid in your 
projects. Same deal.

Nobody is going to associate themselves with a uuid. It's not how humans 
work. It's degrading, and it's work-for-no-gain to anybody who doesn't 
have OCD.

So in practice, the only thing that would happen is that people make up 
random uuid's and they'd be different for every single machine they have, 
because absolutely NOBODY would ever bother to try to save and move their 
uuids around.

So when you point out that emails aren't unique, or that people change 
their emails over time, please realize that the emails are _more_ stable 
than a uuid would ever be. Because an email actually has some emotional 
attachment to the person in question. Yes, they change. So do real names 
too (which change more seldom, exactly because people are way _more_ 
emotionally attached to their real names).

uuid's? I can pretty much guarantee that for me, it would be different for 
every single machine I have. Because I could just not be bothered to care.

			Linus
