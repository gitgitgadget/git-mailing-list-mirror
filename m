From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Another config file parsing fix.
Date: Sat, 6 May 2006 23:01:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605062300530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060506141402.3909cb37.seanlkml@sympatico.ca>
 <BAYC1-PASMTP08FCAC8B8FB768ED1791F1AEAA0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 06 23:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcTuH-00085K-Nb
	for gcvg-git@gmane.org; Sat, 06 May 2006 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWEFVBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 17:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWEFVBh
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 17:01:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:9954 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751109AbWEFVBg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 17:01:36 -0400
Received: (qmail invoked by alias); 06 May 2006 21:01:35 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp036) with SMTP; 06 May 2006 23:01:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08FCAC8B8FB768ED1791F1AEAA0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19669>

Hi,

On Sat, 6 May 2006, sean wrote:

> On Sat, 6 May 2006 14:14:02 -0400
> sean <seanlkml@sympatico.ca> wrote:
> 
> > If the variable we need to store should go into a section
> > that currently only has a single variable (not matching
> > the one we're trying to insert), we will already be into
> > the next section before we notice we've bypassed the correct
> > location to insert the variable.
> > 
> > To handle this case we store the current location as soon
> > as we find a variable matching the section of our new
> > variable.
> > 
>     
> Sorry.. this should really be amended to mention that it was Linus
> who spotted the problem.

Thanks to both of you!

Ciao,
Dscho
