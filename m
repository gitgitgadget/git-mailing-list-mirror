From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 19:01:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171901310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITsa-00024L-Uk
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993006AbXBQSBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993007AbXBQSBq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:01:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:39271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2993006AbXBQSBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:01:45 -0500
Received: (qmail invoked by alias); 17 Feb 2007 18:01:44 -0000
X-Provags-ID: V01U2FsdGVkX19YJEo0h2xY2PVtC5Ai64WhQ6Ymplu3FBZ2XjnIhR
	A6vg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39999>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Instead of (or, in addition to) --tags, to use only tags for naming,
> >> you can now use --ref-filter=<regex> to specify which refs are
> >> used for naming.
> >> 
> >> Example:
> >> 
> >> 	$ git name-rev --ref-filter='/v1' 33db5f4d
> >> 	33db5f4d tags/v1.0rc1^0~1593
> >
> > Likes, dislikes?
> 
> "Describe these objects in terms of these refs -- do not use any
> other random refs, even if they are closer" was sorely lacking
> for it to be usable for me, so I like what it does.
> 
> When we talk about path and path-like things including refs
> I think we consistently use fnmatch not regexp.  At least I
> think we try to.

Okay. Will rework.

Ciao,
Dscho
