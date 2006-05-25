From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch possible regressions
Date: Fri, 26 May 2006 01:28:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605260125420.16816@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
 <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605252338530.31700@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0605260014340.13003@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 26 01:29:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjPGJ-0005ys-1Y
	for gcvg-git@gmane.org; Fri, 26 May 2006 01:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWEYX3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 19:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWEYX3A
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 19:29:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:39350 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965189AbWEYX27 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 19:28:59 -0400
Received: (qmail invoked by alias); 25 May 2006 23:28:57 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp001) with SMTP; 26 May 2006 01:28:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7wpr97n.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20771>

Hi,

On Thu, 25 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Thinking about this again, it makes more sense not to imply --numbered:
> 
> Yes, that makes sense.  That way you can say "Please start
> naming the output files at 0032-xxxx.txt, because you gave me 31
> patch series last time, but I do not want [PATCH x/y] on the
> subject line, just [PATCH]".
> 
> That brings up another issue.  Don't we need to have another
> option --total-number that overrides the /y part above?

I thought about that, too. Isn't the --numbered only useful for submitting 
a patch series via mail? And isn't it necessary to make certain that these 
patches really apply in that order? Isn't it then sensible to force the 
user to have a branch (at least a throw-away one) having exactly these 
patches, just to make sure that the patches really, really apply in that 
order?

If all that is true, then --start-number && --numbered does not make sense 
at all.

Ciao,
Dscho
