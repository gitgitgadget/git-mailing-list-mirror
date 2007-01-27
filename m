From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 13:58:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 13:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAn8k-000413-DR
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 13:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXA0M6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 07:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbXA0M6j
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 07:58:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751736AbXA0M6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 07:58:38 -0500
Received: (qmail invoked by alias); 27 Jan 2007 12:58:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 27 Jan 2007 13:58:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070127080126.GC9966@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37951>

Hi,

On Sat, 27 Jan 2007, Shawn O. Pearce wrote:

> I've been having a lot of discussion on #git with Simon 'corecode' 
> Schubert and Chris Lee about how poorly git-blame performs compared to 
> its counterpart in Subversion.

Well, I don't run git-blame too often, and then it is mostly confined to a 
certain file / lines combo. So git-blame is fast enough for me.

It is slower than Subversion's counterpart, just because SVN's blame 
sucks. You cannot find out the _relevant_ information easily, i.e. once 
you merged something, the _merge_ gets attributed for the change (at least 
the last time I tried it).

So, don't blame blame for being useful in git.

Of course, you could introduce a cache, but then, I don't run blame _that_ 
often.

Besides, we already introduced an orthogonal historisation by reflogs, and 
your method would not cope gracefully with that, would it?

Ciao,
Dscho
