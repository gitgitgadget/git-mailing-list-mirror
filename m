From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 5 Jul 2006 19:04:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607051900200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44AAF49F.6090008@gmail.com> <Pine.LNX.4.63.0607050952140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44ABE596.40103@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 05 19:05:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAo8-0005kZ-7V
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 19:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWGERE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWGERE5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 13:04:57 -0400
Received: from mail.gmx.net ([213.165.64.21]:20905 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964868AbWGERE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 13:04:56 -0400
Received: (qmail invoked by alias); 05 Jul 2006 17:04:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 05 Jul 2006 19:04:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44ABE596.40103@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23356>

Hi,

On Wed, 5 Jul 2006, A Large Angry SCM wrote:

> If grafts in your repository create a cycle, the misbehavior of merge-base
> should be among the least of your concerns.

Right. BUT grafts can be very helpful to connect branches which were 
independently imported into git. And in these cases, the clockSkew really 
is no clockSkew. But in that case, the generation number would have to be 
recalculated also.

Anyway, I think that it should be a configurable, which defaults to off, 
i.e. in the normal case merge-base should behave as it does now. And if we 
have that configurable, we might as well take the safe but dumb approach 
to just traverse _everything_.

Ciao,
Dscho
