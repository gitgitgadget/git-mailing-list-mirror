From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 14:36:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231433370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virmscl2u.fsf@assigned-by-dhcp.cox.net> <7vd5d09pe2.fsf@assigned-by-dhcp.cox.net>
 <20060623122501.GD15631@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftktb-0000dd-A6
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWFWMgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWFWMgN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:36:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27885 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932603AbWFWMgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:36:12 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 2494F2AC6;
	Fri, 23 Jun 2006 14:36:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 188832AC4;
	Fri, 23 Jun 2006 14:36:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 065662AAE;
	Fri, 23 Jun 2006 14:36:10 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060623122501.GD15631@cip.informatik.uni-erlangen.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22415>

Hi,

On Fri, 23 Jun 2006, Thomas Glanzmann wrote:

> Hello Junio,
> 
> > So in that sense I would imagine --squash is not really useless
> > in such a situation as I made it sound like, but at the same
> > time I suspect people might be better off to use tools like
> > StGIT which are specially designed to support such a workflow if
> > they were to do this.
> 
> thanks for --squash. So --squash is basically a 'suck multiple deltas
> from another branch into ., but don't commit it'. I very often use that
> way of work flow. I do small and many commits, and when I am done I
> merge them to one a bit bigger one and submit it upstream. I useally use
> 'one branch per feature'.

Isn't this the same as 'git-cherry-pick -n'? I often do a poor man's StGIT 
by cherry picking my way through a messy branch, often combining patches 
by '-n'.

Ciao,
Dscho
