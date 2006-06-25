From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Sun, 25 Jun 2006 03:54:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250353220.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz>
 <7vejxgckq9.fsf@assigned-by-dhcp.cox.net> <m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
 <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
 <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
 <20060623011205.GJ21864@pasky.or.cz> <7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
 <20060623123904.GL21864@pasky.or.cz> <7vejxf74e3.fsf@assigned-by-dhcp.cox.net>
 <7vzmg35pkt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606242207510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmg2rpxt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJp9-00066L-Fw
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWFYByE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWFYByE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62435 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751344AbWFYByC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 21:54:02 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 4769B21F6;
	Sun, 25 Jun 2006 03:54:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3BBF0221D;
	Sun, 25 Jun 2006 03:54:01 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 193D321C7;
	Sun, 25 Jun 2006 03:54:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmg2rpxt.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22569>

Hi,

On Sat, 24 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My original idea: on a machine where you have no accurate diff, you at 
> > least want to pass the tests, and you want to ensure you can apply a diff 
> > you generated on that machine.
> 
> I remember that, but I think recently we converted t4100 and
> t4101 to use pregenerated test vectors so it might not be an
> issue anymore?

Exactly.

> I would maybe rename the option to --inaccurate-eof and default
> it to off (i.e. no --accurate-eof option).  After all we are not
> talking about arbitrary inaccuracy but the particular botch of
> not having "\No newline at the end of file."

Sure. Want me to redo the patch?

Ciao,
Dscho
