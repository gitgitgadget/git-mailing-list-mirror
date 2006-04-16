From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pager: do not fork a pager if environment variable
 PAGER is set to NONE
Date: Sun, 16 Apr 2006 04:01:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604160357460.31461@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtdqef6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 04:01:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUwa3-0000m1-BO
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 04:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDPCBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 22:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWDPCBf
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 22:01:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43161 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932188AbWDPCBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 22:01:34 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 342C11B10;
	Sun, 16 Apr 2006 04:01:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 28E741A66;
	Sun, 16 Apr 2006 04:01:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id F3096199F;
	Sun, 16 Apr 2006 04:01:30 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtdqef6u.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18770>

Hi,

On Sat, 15 Apr 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This helps debugging tremendously.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> I like what this wants to do.  I am not so sure PAGER=NONE is a
> good convention, however.

I am sure it is not.

One solution would be to introduce yet another command line option 
"--no-pager", but I find that ugly.

Another solution would be to check if the environment variable NO_PAGER is 
set.

Wishes?

Ciao,
Dscho
