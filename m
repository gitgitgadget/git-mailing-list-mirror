From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 4 Jul 2006 13:40:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041336220.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsllhhcxr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:40:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxjGO-0006lU-8X
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGDLkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWGDLkQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:40:16 -0400
Received: from mail.gmx.net ([213.165.64.21]:20938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932209AbWGDLkO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:40:14 -0400
Received: (qmail invoked by alias); 04 Jul 2006 11:40:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 04 Jul 2006 13:40:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsllhhcxr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23290>

Hi,

On Tue, 4 Jul 2006, Junio C Hamano wrote:

> However, I am not sure how you are going to use that maximumSkew
> variable.

My idea was to continue traversing the merge base's ancestors, marking 
them UNINTERESTING, until hitting a commit which is maximumSkew older than 
the merge base (and not just stop at the merge base, as is the case right 
now, and neither continue traversing in eternity like suggested).

This would not help _evil_ cases (i.e. intentional), but most certainly 
your regular clock skew in a Microsoft network.

Ciao,
Dscho
