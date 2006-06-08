From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 14:21:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081415380.26091@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
  <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com>
 <dbfc82860606080506y52dc2771sbf6c90e7246ca4c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Ekman <svekman@yahoo.se>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 14:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoJWY-0000BI-Q7
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 14:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFHMV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 08:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFHMV6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 08:21:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9127 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751285AbWFHMV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 08:21:57 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8E03B1426;
	Thu,  8 Jun 2006 14:21:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7F0F820BC;
	Thu,  8 Jun 2006 14:21:56 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4F5381D4A;
	Thu,  8 Jun 2006 14:21:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860606080506y52dc2771sbf6c90e7246ca4c9@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21484>

Hi,

On Thu, 8 Jun 2006, Nikolai Weibull wrote:

> On 6/8/06, Sven Ekman <svekman@yahoo.se> wrote:
> > <Johannes.Schindelin@gmx.de> skrev:
> > 
> > > There are three subjects for discussion:
> > 
> > Have you considered making ~/.gitconfig a directory?
> > Maybe Git wants to store more data later.
> 
> I second that.

I don't. What's wrong with the simple approach of a single config file? 
You can use a single tool for all the configuration, and do not need to 
care about anything.

After all, it is about _configuration_, not data storing. That is what 
$GIT_DIR/objects is for.

> And it'd be nice if it was configurable through an environment variable, 
> e.g., GIT_USER_CONFIG_HOME.

<sarcasm ignore=if-possible>
Let's see. AFAIK all programs I know (including cvs and vim, for 
one) have a fixed name. Hmm. Perhaps this is for a reason? Like, to reduce 
confusion?

Alternatively, we could introduce a config variable "core.globalConfig" to 
see where the global config is.
</sarcasm>

Ciao,
Dscho
