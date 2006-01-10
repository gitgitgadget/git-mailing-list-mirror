From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 17:45:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601101743180.26542@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43C2D2C4.2010904@cc.jyu.fi>  <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
  <20060110045533.GO18439@ca-server1.us.oracle.com> 
 <Pine.LNX.4.63.0601101549360.26054@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0601100817h2a288a4ag337c749857f2c7fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 17:46:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwMcr-0002Eq-GU
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 17:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWAJQpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWAJQpU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 11:45:20 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:45506 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751147AbWAJQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 11:45:17 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F01DAE6003; Tue, 10 Jan 2006 17:45:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id E0751984;
	Tue, 10 Jan 2006 17:45:16 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id C50B1972;
	Tue, 10 Jan 2006 17:45:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9BF9E14134C; Tue, 10 Jan 2006 17:45:16 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601100817h2a288a4ag337c749857f2c7fc@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14427>

Hi,

On Tue, 10 Jan 2006, Alex Riesen wrote:

> On 1/10/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >       Can we teach the git:// fetch program to use CONNECT over HTTP
> > > proxies?  rsync can do this, but git:// cannot, so firewalls that block
> > > 9418 mean we use rsync://
> >
> > I think it is good and well with the proxy command support. Everybody can
> > write a little script.
> >
> > Otherwise, where would it end? If you include http_proxy functionality in
> > git, why not also https_proxy functionality? And if that, why not
> 
> And, BTW, why not? It may as well stop here.

Because it's not the purpose of git. It is the purpose of a tunnel. Let's 
not make the mistake of Microsoft here: integrate everything until 
everything breaks.

Ciao,
Dscho
