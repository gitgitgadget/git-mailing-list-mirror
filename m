From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 22:20:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802192217250.7826@racer.site>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>  <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>  <alpine.LSU.1.00.0802191916020.7797@racer.site>  <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com> 
 <alpine.LSU.1.00.0802191940260.7826@racer.site>  <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>  <47BB3691.9040809@freescale.com>  <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>  <47BB5037.5090302@freescale.com> 
 <e26d18e40802191359r4c435818n4ae7b357d452d51e@mail.gmail.com> <e26d18e40802191413w48fe4a71hd7895b09d15cb44e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:21:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaq0-00080f-1a
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbYBSWUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbYBSWUk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:20:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:36540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754673AbYBSWUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:20:39 -0500
Received: (qmail invoked by alias); 19 Feb 2008 22:20:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 19 Feb 2008 23:20:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oYWQQWAeoiT2xvk1+MNwWz1e7mjBPuKI7thVgoX
	1pmWtuWv0U4pye
X-X-Sender: gene099@racer.site
In-Reply-To: <e26d18e40802191413w48fe4a71hd7895b09d15cb44e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74468>

Hi,

On Tue, 19 Feb 2008, Anatoly Yakovenko wrote:

> On Feb 19, 2008 1:59 PM, Anatoly Yakovenko <aeyakovenko@gmail.com> wrote:
> > > Something is fishy here.  Is your repository bare or not?
> >
> > no, why does it need to be bare?
> >
> so bare or not ssh works but http doesnt:

Having a non-bare repository on a web server does not make sense at all.  
It's not like you will be developing in there, right?

And yes, you can append "/.git/" to your URL and it should work fine.  
HTTP transport is a second class citizen, and will probably never be as 
efficient as GIT transport.

Therefore, you can choose to continue your efforts with the http:// URL, 
but are mostly on your own, or you can go with ssh (git://) and it just 
works.

Unfortunately, I do not have the time to help you more.

Ciao,
Dscho
