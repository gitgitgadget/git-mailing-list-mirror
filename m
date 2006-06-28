From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing
 commands.
Date: Wed, 28 Jun 2006 11:21:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net>
 <44A23A38.3090206@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWEh-0003v8-Ah
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWF1JVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWF1JVX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:21:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:36254 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932125AbWF1JVX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:21:23 -0400
Received: (qmail invoked by alias); 28 Jun 2006 09:21:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 28 Jun 2006 11:21:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44A23A38.3090206@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22788>

Hi,

On Wed, 28 Jun 2006, Andreas Ericsson wrote:

> Junio C Hamano wrote:
> > Andreas Ericsson <ae@op5.se> writes:
> > 
> > 
> > > Somewhere in the alias handling git turned hostile on fat fingers:
> > > 
> > > 	$ git showbranch
> > > 	Failed to run command '': Is a directory
> > 
> > 
> > Does not happen here (nor on Cygwin 1.4.1.rc1).  Care to help
> > reproducing it?

Try this:

$ mkdir 5
$ cd 5
$ git-init-db
$ rm .git/config # yes, really.
$ git abc

Ciao,
Dscho
