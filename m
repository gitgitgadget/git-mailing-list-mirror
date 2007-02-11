From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 17:03:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu>
 <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
 <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211001346.GA19656@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHAv-0003Tw-3V
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXBKQDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbXBKQDc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:03:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:49885 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbXBKQDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:03:31 -0500
Received: (qmail invoked by alias); 11 Feb 2007 16:03:29 -0000
X-Provags-ID: V01U2FsdGVkX1/bbQoeJLPbISlfq1MMu04MuztvxbFtYlwJIfdPTZ
	dvHw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211001346.GA19656@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39286>

Hi,

On Sat, 10 Feb 2007, Theodore Tso wrote:

> On Sat, Feb 10, 2007 at 09:34:38PM +0100, Johannes Schindelin wrote:
> 
> > It made me feel a little uneasy that we can execute _any_ command now, 
> > but I can only find one way to exploit this, when an attacker does not 
> > have shell access anyway: git-shell.
> 
> ... and git-shell only allows git-receive-pack and git-upload-pack to be 
> called, with a single argument, and aliases aren't allowed to override 
> commands.  So we're safe here, I think.

Yes, sorry. I have a modified git-shell, which allows the git wrapper, 
too, to allow setting the config. I'll just fix it here.

Ciao,
Dscho
