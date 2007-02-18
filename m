From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 12:40:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702181240320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b54p78r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180259340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejoonrdm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 12:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIkPo-0004jQ-SH
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 12:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbXBRLlB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 06:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXBRLlB
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 06:41:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:45256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750700AbXBRLlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 06:41:00 -0500
Received: (qmail invoked by alias); 18 Feb 2007 11:40:58 -0000
X-Provags-ID: V01U2FsdGVkX1+SK9hFMWuSx5o1Jb4LV3ruJ3WjUc318dz3H/vtVy
	d6iw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejoonrdm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40072>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 17 Feb 2007, Junio C Hamano wrote:
> >
> >> I do agree diff-file is too confusing with diff-files, but...
> >
> > ... but nobody writes out diff-files these days, right?
> 
> Actually, "diff-files -c -p" while looking at a merge conflict
> is the only thing I found "git diff" does not let me do.   The
> latter always gives condensed combined diff.

So, diff2 is my preference. If anybody has better suggestions: go ahead.

Ciao,
Dscho
