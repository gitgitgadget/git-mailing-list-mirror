From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 23:03:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702112300500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu>
 <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
 <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211001346.GA19656@thunk.org> <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211162136.GA26461@thunk.org> <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGMn3-0007Zp-1Q
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbXBKWDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXBKWDG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:03:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:45761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932570AbXBKWDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:03:05 -0500
Received: (qmail invoked by alias); 11 Feb 2007 22:03:04 -0000
X-Provags-ID: V01U2FsdGVkX1+merEZV22mBvTpCkw7TmGj87mqiM3pAOB3ZuDb01
	zQGg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7n4cqti.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39313>

Hi,

On Sun, 11 Feb 2007, Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > ..., I think we're
> > still safe, since aliases can't override commands.  
> 
> I feel a bit uneasy to hear safety argument based on that current 
> restriction, since we might want to loosen it later.

After seeing that it was a personal breakage only, I think we only have to 
keep the safety in mind, _iff_ we are to loosen it later, not before that.

For the moment, there are no safety issues, but real advantages, IMHO.

Ciao,
Dscho
