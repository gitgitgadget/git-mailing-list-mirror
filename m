From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Tue, 06 Jan 2009 22:21:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901062212060.26118@xanadu.home>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
 <alpine.LFD.2.00.0901062059230.26118@xanadu.home>
 <1231296475.8870.89.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 04:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKP0s-0008K2-9n
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 04:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbZAGDWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZAGDV7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 22:21:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32506 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZAGDV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 22:21:58 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD200A19ZZ403Y0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 22:21:05 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1231296475.8870.89.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104750>

On Tue, 6 Jan 2009, R. Tyler Ballance wrote:

> On Tue, 2009-01-06 at 21:09 -0500, Nicolas Pitre wrote:
> > > I've tarred one of the repositories that had it in a reproducible
> > state
> > 
> > That is wonderful.
> > 
> > > so I can create a build and extract the tar and run against that to
> > > verify any patches anybody might have, but unfortunately at 7GB of
> > > company code and assets, I can't exactly share ;)
> > 
> > First step is to understand what is going on.  Only then could reliable 
> > patches be made.
> 
> If you want to point me in the right direction, I have a few hours to
> kill this evening and fscking around with gdb(1) and printf() just might
> be some of my favorite things</sarcasm> ;)

Heh.  ;-)

To start with, a simple log of what you need to do to reproduce the 
issue would be nice.  Just do

	script /tmp/foo

then reproduce the issue and exit, after which I'd be interrested in the 
content of /tmp/foo.


Nicolas
