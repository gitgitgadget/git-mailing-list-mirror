From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 13:19:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711301317060.27959@racer.site>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu>
 <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu>
 <Pine.LNX.4.64.0711301202230.27959@racer.site> <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy5n6-00059B-UA
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 14:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760831AbXK3NTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 08:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760209AbXK3NTZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 08:19:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:47517 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757543AbXK3NTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 08:19:24 -0500
Received: (qmail invoked by alias); 30 Nov 2007 13:19:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 30 Nov 2007 14:19:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1886K8eAQs8oCjKpkYg+rk3R/5FtvuyINs8/sDY2W
	4BNMDC4tqy2EA1
X-X-Sender: gene099@racer.site
In-Reply-To: <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66640>

Hi,

On Fri, 30 Nov 2007, Michael Witten wrote:

> On 30 Nov 2007, at 7:03:15 AM, Johannes Schindelin wrote:
> 
> > On Thu, 29 Nov 2007, Michael Witten wrote:
> > 
> > > In any case, I haven't taken a thorough look at how git-cvsserver 
> > > works, but it seems to duplicate a lot of git-receive-pack.
> > > 
> > > How about turning git-cvsserver into a true middleman, so that it 
> > > constructs a 'temporary git working tree' and then does a real 
> > > git-push into the final git repository.
> > 
> > That would yield a horrible performance.
> > 
> > Would be opposed, if a regular cvsserver user,
> 
> How come?

I remember driving git-cvsserver on a bare repository, with "ln -s 
/usr/bin/git-cvsserver ~cvsuser/bin/", and it was superfast.

One user even asked if I upgraded my cvs, because it was so much faster 
than before.  I said yes.

Ciao,
Dscho
