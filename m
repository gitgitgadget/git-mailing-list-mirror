From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Generic configuration plumbing (Was: Re: [RFC 2/2] Automatically
 transform...)
Date: Mon, 28 Nov 2005 16:26:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511281620520.11052@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <200511281359.04741.Josef.Weidendorfer@gmx.de> <438B021F.5030204@op5.se>
 <200511281532.36054.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 28 16:29:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egktp-0000Uh-0X
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 16:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVK1P0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVK1P0e
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 10:26:34 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28297 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750869AbVK1P0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 10:26:33 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7072813FE29; Mon, 28 Nov 2005 16:26:32 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54F479F479; Mon, 28 Nov 2005 16:26:32 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 413E89DB02; Mon, 28 Nov 2005 16:26:32 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D2F1D13FE29; Mon, 28 Nov 2005 16:26:31 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511281532.36054.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12887>

Hi,

On Mon, 28 Nov 2005, Josef Weidendorfer wrote:

> On Monday 28 November 2005 14:11, Andreas Ericsson wrote:
> > Josef Weidendorfer wrote:
> > > 
> > > To allow for this, git_config() should not be hardcoded to only
> > > read .git/config, but perhaps a list of files in environment variable
> > > GIT_CONFIG_FILES.
> > > 
> > 
> > $HOME/.gitrc:$GIT_DIR/conf/*
> 
> Yes, perhaps with this as default...
> 
> > All files could support the freestanding "include" syntax.
> 
> Better run cpp on the config files before loading ;-)
> Or provide a hook which returns the config on stdout.
> The default for .git/hooks/config would be
> 
> 	cat $GIT_DIR/config
> 
> Hmm... this was only meant to be a joke; but now I actually think
> this is a nice idea as basic configuration mechanism of git plumbing.

The longer I read this thread the more I *positively* *hate* to have 
started it.

People, I wanted simplification. And you ask instead for every feature and 
his dog, and could I have fries with that?

KISS!

I *don't* want split config files. Why? Because it buys you only confusion 
and complication. If you want to group variables, do so with sections (BTW 
that's what they were designed for).

I am perfectly okay when somebody says that I should leave things as they 
are and not fsck around with configuration. The impression I get is that 
you want to force me to admit that I was wrong from the start.

Ciao,
Dscho
