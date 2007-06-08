From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain an
 empty line
Date: Fri, 08 Jun 2007 04:14:24 +0200
Message-ID: <200706080414.24388.johan@herland.net>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <200706080128.48637.johan@herland.net>
 <alpine.LFD.0.99.0706072158160.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 04:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwTzo-0007xm-9c
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 04:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966321AbXFHCO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 22:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966348AbXFHCO2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 22:14:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:63406 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966321AbXFHCO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 22:14:28 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJA00L03OW2W400@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 04:14:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA00MXGOW0HD40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 04:14:25 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJA001D0OW0U790@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 04:14:24 +0200 (CEST)
In-reply-to: <alpine.LFD.0.99.0706072158160.12885@xanadu.home>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49425>

On Friday 08 June 2007, Nicolas Pitre wrote:
> On Fri, 8 Jun 2007, Johan Herland wrote:
> 
> > I agree that we should fail gracefully, and my code is clearly not doing 
> > that in this case. My bad.
> > 
> > But the code should also detect invalid tag objects, and in this case I'm 
> > not yet convinced that the tag object causing the failure is in fact valid. 
> > If someone can convince me that the blank line after headers is optional, 
> > then I'll gladly fix the code.
> 
> That's irrelevant.
> 
> Because you are fed invalid data is no excuse for crashing.
> 
> Especially in a tool like fsck, you should _expect_ and cope with 
> invalid data. That's why it exists in the first place: to identify such
> data.

Of course. If you read my first sentence in the quote above, you will see
that I agree with you 100%.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
