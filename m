From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 13:52:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801111348230.31053@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>  <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de> <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 14:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDKJR-0007Rg-9Y
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 14:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYAKNwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 08:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYAKNwI
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 08:52:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:34601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617AbYAKNwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 08:52:07 -0500
Received: (qmail invoked by alias); 11 Jan 2008 13:52:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 11 Jan 2008 14:52:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MsLJg6DVMGI+59mx+2vR9F0v6PTYrMButP5t0sh
	JihlO5eS17/eDp
X-X-Sender: gene099@racer.site
In-Reply-To: <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70161>

Hi,

On Fri, 11 Jan 2008, Mark Levedahl wrote:

> On Jan 11, 2008 7:03 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > IIUC your patch only replaces the term "origin" by something 
> > user-specifiable.  I fail to see the use of it; care to explain what 
> > workflow is easier with your patches than without?
> 
> Consider a project with several servers, each of which is *supposed* is 
> host the same project but due to lags in mirroring across airgaps, etc., 
> are never quite in sync. Now, we get on a teleconference and discuss 
> issues, find differences, and everyone reports that "origin" has x, but 
> in fact "origin" means different servers to almost everyone. Also 
> consider that only a small subset of the group really understands git, 
> most just follow cook-book recipes to get their work done and don't 
> understand what is going on.

Okay, I now understand your intention much better than before.

> This is my problem: "origin" is an abstraction that hides the different 
> server names in use and makes communication difficult, having everyone 
> use nicknames related to their particular upstream server reduces the 
> confusion.

Unfortunately, I think this will just lead to even more confusion.  
Because those people following recipes without thinking will now use a 
name that does not even say the role, let alone the server.

IOW I think that your patch worsens the situation you describe.

IMHO you should optimise the communication by agreeing on one origin, 
or alternatively not talk about a server at all (which is made easy by the 
global uniqueness of commit names; just say "my tip is ac9b7192").

Ciao,
Dscho
