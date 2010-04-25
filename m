From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Sun, 25 Apr 2010 22:05:16 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1004252204020.24585@cone.home.martin.st>
References: <20100311163715.GE7877@thor.il.thewrittenword.com> <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st> <20100312045654.GH7877@thor.il.thewrittenword.com> <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
 <20100312151522.GA11943@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 21:05:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6794-00082H-A4
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 21:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab0DYTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 15:05:23 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60576 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab0DYTFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 15:05:22 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D05728589; Sun, 25 Apr 2010 22:05:19 +0300
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20100312151522.GA11943@thor.il.thewrittenword.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145759>

Hi Gary,

On Sun, 25 Apr 2010, Gary V. Vaughan wrote:

> On Fri, Mar 12, 2010 at 09:24:01AM +0200, Martin Storsj? wrote:
> > 
> > Yes, but if the sockaddr struct can be arranged in different ways, the 
> > other ones (sockaddr_in, sockaddr_storage, sockaddr_in6) must also be 
> > defined coherently - you're always supposed to be able to cast an 
> > sockaddr_in (or any other of them) to a sockaddr and read the sa_family 
> > field. As far as I know, at least.
> 
> Ah, good point.  And now, having tested that on all our machines it
> works perfectly, and is much more elegant!
> 
> I'll resubmit presently.

Actually, Brandon Casey already submitted a patch doing this, which is 
available in master by now, so this issue is all taken care of. :-)

// Martin
