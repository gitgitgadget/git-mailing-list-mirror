From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 15:35:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081532370.26823@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
  <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com> 
 <dbfc82860606080506y52dc2771sbf6c90e7246ca4c9@mail.gmail.com> 
 <Pine.LNX.4.63.0606081415380.26091@wbgn013.biozentrum.uni-wuerzburg.de>
 <dbfc82860606080613n5b5f6a5bs7a8f461a4188228c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Ekman <svekman@yahoo.se>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 15:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoKfp-0005UE-Cw
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 15:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFHNfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 09:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWFHNfi
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 09:35:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:33452 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964830AbWFHNfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 09:35:37 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id CB364B2B;
	Thu,  8 Jun 2006 15:35:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BEED6B3C;
	Thu,  8 Jun 2006 15:35:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id AB14FA9B;
	Thu,  8 Jun 2006 15:35:36 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860606080613n5b5f6a5bs7a8f461a4188228c@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21488>

Hi,

On Thu, 8 Jun 2006, Nikolai Weibull wrote:

> Who said anything about something more than one configuration file? It's 
> nice to have a directory if we later decide to store other kinds of 
> files there as well, e.g., templates or some keyring information or 
> something else, perhaps not well-suited for storing in an ini-like file.

My point was: this has nothing to do with the "git config". Gitk, for 
example, has its own file there, ~/.gitk.

> > Alternatively, we could introduce a config variable "core.globalConfig" to
> > see where the global config is.
> 
> That is a very good idea.  We wouldn't need an environment variable in
> that case.
> 
>  nikolai (who wonders if people can spot irony and sarcasm without extra 
> help)

No they can't. You almost had me falling for it...

Ciao,
Dscho

P.S.: I also wanted to mention that we could migrate all the config into 
an XML format. And maybe have an SQL backend instead of an object store.
