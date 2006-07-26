From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] git-instaweb: store parameters in config
Date: Wed, 26 Jul 2006 23:13:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262311560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261633320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bcorxbd.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607262147280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 23:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5qhg-0005Dk-3p
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 23:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWGZVN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 17:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWGZVN4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 17:13:56 -0400
Received: from mail.gmx.de ([213.165.64.21]:60833 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751658AbWGZVNz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 17:13:55 -0400
Received: (qmail invoked by alias); 26 Jul 2006 21:13:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 26 Jul 2006 23:13:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0607262147280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24250>

Hi,

On Wed, 26 Jul 2006, Johannes Schindelin wrote:

> On Wed, 26 Jul 2006, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > It already reads the config for defaults, and now it also stores
> > > the last passed parameters in the config.
> > 
> > This might need to be conditional -- usually people override the
> > default from the command line as a one-shot thing, and storing
> > them in the configuration file would upset them.
> 
> I agree that this should be conditional, but the other way round, no? 

Being bitten by my own words. It is plain dumb to store parameters for 
which instaweb fails. And my patch did that. Oh, well.

So, I'd say: just forget about patches [3-5]/5.

Ciao,
Dscho
