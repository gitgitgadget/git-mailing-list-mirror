From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Mon, 26 Apr 2010 16:55:22 +0000
Message-ID: <20100426165522.GC28004@thor.il.thewrittenword.com>
References: <20100311163715.GE7877@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st>
 <20100312045654.GH7877@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
 <20100312151522.GA11943@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1004252204020.24585@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Storsj? <martin@martin.st>
X-From: git-owner@vger.kernel.org Mon Apr 26 18:55:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Rai-0001Ax-OS
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 18:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab0DZQzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 12:55:23 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:51511 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0DZQzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 12:55:23 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 2D6545CC9;
	Mon, 26 Apr 2010 17:16:28 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 2D6545CC9
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 91A0EA56;
	Mon, 26 Apr 2010 16:55:22 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 84011BAB7; Mon, 26 Apr 2010 16:55:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004252204020.24585@cone.home.martin.st>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145829>

On Sun, Apr 25, 2010 at 10:05:16PM +0300, Martin Storsj? wrote:
> Hi Gary,

Hi Martin,

There's unfortunately a 1 month time slip between my having written
the messages and having figured out why they were being rejected
(actually 3 things that needed fixing before resends started arriving,
which is why it took so long)...

> On Sun, 25 Apr 2010, Gary V. Vaughan wrote:
> 
> > On Fri, Mar 12, 2010 at 09:24:01AM +0200, Martin Storsj? wrote:
> > > 
> > > Yes, but if the sockaddr struct can be arranged in different ways, the 
> > > other ones (sockaddr_in, sockaddr_storage, sockaddr_in6) must also be 
> > > defined coherently - you're always supposed to be able to cast an 
> > > sockaddr_in (or any other of them) to a sockaddr and read the sa_family 
> > > field. As far as I know, at least.
> > 
> > Ah, good point.  And now, having tested that on all our machines it
> > works perfectly, and is much more elegant!
> > 
> > I'll resubmit presently.
> 
> Actually, Brandon Casey already submitted a patch doing this, which is 
> available in master by now, so this issue is all taken care of. :-)

...and I didn't notice that until I started rebasing the changesets
against a newer release.

Excellent that one issue is now resolved though, I'll repost my
outstanding patches presently.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
