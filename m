From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<pattern> option
Date: Sun, 18 Feb 2007 00:55:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180054540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vabzctydf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZP8-0000cy-NU
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965409AbXBQXzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965412AbXBQXzn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:55:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:56204 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965409AbXBQXzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:55:42 -0500
Received: (qmail invoked by alias); 17 Feb 2007 23:55:41 -0000
X-Provags-ID: V01U2FsdGVkX18fc8YywP8fF72d2bYc7OcZWfVCmdJgPJgkGF54PC
	azpQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vabzctydf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40030>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Instead of (or, in addition to) --tags, to use only tags for naming,
> > you can now use --ref-filter=<patter> to specify a shell pattern
> > which the refs must match to be used for naming.
> >
> > Example:
> >
> > 	$ git name-rev --ref-filter=*v1* 33db5f4d
> > 	33db5f4d tags/v1.0rc1^0~1593
> 
> I am sorry I did not mention earlier, but doesn't --ref-filter
> sound too long?  How about '--refs=*v1*'?
> 
> No need to resend, just Ack / Nack would do.

Ack. I am okay with any change, since I will probably not use it anyway. 
name-rev is usable to me, but since you said it is not to you, I wanted to 
change _that_.

Ciao,
Dscho
