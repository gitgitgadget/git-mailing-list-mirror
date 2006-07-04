From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 5 Jul 2006 00:25:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 00:25:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxtKT-0008ON-Or
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWGDWZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWGDWZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:25:09 -0400
Received: from mail.gmx.de ([213.165.64.21]:50838 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932322AbWGDWZH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 18:25:07 -0400
Received: (qmail invoked by alias); 04 Jul 2006 22:25:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 05 Jul 2006 00:25:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23321>

Hi,

On Tue, 4 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > We could introduce a time.maximumSkew variable, and just walk only 
> > that much further when traversing the commits.
> 
> We could have had "commit generation number" in the commit
> object header, and use that instead of commit timestamps for
> these traversal purposes.  The generation number for a commit is
> defined to be max(generation number of its parents)+1 and we
> prime the recursive this definition by defining the generation
> number for the root commit to be one.

Are you really, really sure this is a remedy? I, for one, am quite sure of 
the opposite. What you propose is just another time scale, only this time, 
it is not universally true (not even minus local incompetence to keep the 
clock accurate).

If that should be not true, you always could rely on topo order. Which 
does not seem to solve the problem for you.

Ciao,
Dscho
