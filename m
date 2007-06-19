From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 12:11:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191210020.4059@racer.site>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org> 
 <Pine.LNX.4.64.0706191037590.4059@racer.site>
 <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0bd2-00043y-EM
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbXFSLMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbXFSLMG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:12:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:59733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755883AbXFSLMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:12:05 -0400
Received: (qmail invoked by alias); 19 Jun 2007 11:12:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 19 Jun 2007 13:12:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+gSgzSSM+OebKMs3Ha8Vx+nEJspIkePJnXg6pZQ
	hQt4BGZEPWqMWK
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50468>

Hi,

On Tue, 19 Jun 2007, Alex Riesen wrote:

> On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >  * when a branch config file section refers to a branches/* remote, the
> > >    merge setting is used (if one is given), even though this isn't useful
> > >    either way.
> > 
> > Maybe this is the right time to cut off branches/* and remotes/*?
> 
> Seconded. Don't use the remotes/ since some months now.
> But... isn't a git package with code of something like 1.4.4 is still
> in some major distributions?

Yes, AFAICT it is Ubuntu "the most up-to-date distro there is". At least 
many questions on the list and in IRC suggest that.

So, how about checking (at least for a year) in builtin-fetch, if 
"branches/" or "remotes/" exist, and fail, with a nice message how to move 
to config-based remotes?

Ciao,
Dscho
