From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 13:01:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181256310.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>  <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org> <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com> <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
 <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLxb-0001m3-UT
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab0CRUEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 16:04:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48961 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0CRUEq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 16:04:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IK4ijR018783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 13:04:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IK4iWj012861;
	Thu, 18 Mar 2010 13:04:44 -0700
In-Reply-To: <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142512>



On Thu, 18 Mar 2010, Linus Torvalds wrote:
> 
> So as a human, which one do you think people care about and fix more 
> quickly?

Btw, one other thing you can take away from it is that even when they 
_are_ shown, and even when they _are_ meaningful, people still don't care. 

There's absolutely tons of "(none)" emails even in the _visible_ parts, 
which is really really sad. But it does tell a lot about humans - they 
won't be noticing even _obvious_ mistakes like that.

(And yes, it does say that git should probably have errored out way more 
aggressively about badly set up host/domain names in the "guess at email 
address" code. My bad. Maybe it's still worth fixing for the future)

			Linus
