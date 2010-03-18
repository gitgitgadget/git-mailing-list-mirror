From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:07:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL7N-0007bB-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab0CRTKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:10:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56455 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0CRTKs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:10:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJAFsh014507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:10:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJAF1f010353;
	Thu, 18 Mar 2010 12:10:15 -0700
In-Reply-To: <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142496>



On Thu, 18 Mar 2010, Jon Smirl wrote:
> 
> We could hash people emails and then build a .mailmap equivalent thus
> hiding their identity.

So? Why? What's the advantage?

I literally _only_ see disadvantages to the whole thing. If the uuid has 
some meaning (ie it's related to actual _real_ information), then it is 
nothing but a really inconvenient placeholder for the real information, 
adn another source of new problems (like "how do we know they are in 
sync? I edit the .gitconfig file by hand all the time").

And if it doesn't have meaning, then it's just annoying and will never 
ever be attached to anything relevant long-term.

Either way, there are only downsides, no upsides. There is absolutely _no_ 
way that teh uuid would ever actually encode any real meaningful 
information that isn't better represented by the name/email.

			Linus
