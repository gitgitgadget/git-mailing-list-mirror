From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Mirroring svn
Date: Thu, 6 Dec 2007 12:15:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061214340.27959@racer.site>
References: <1196922153.10408.101.camel@brick>  <20071206064317.GC18698@coredump.intra.peff.net>
 <1196923525.10408.103.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Fef-000180-VB
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXLFMQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbXLFMQS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:16:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:40208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752351AbXLFMQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:16:17 -0500
Received: (qmail invoked by alias); 06 Dec 2007 12:16:15 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 06 Dec 2007 13:16:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pBcA7ej7pdd0rNIhq7Wpz3VzJLi4ZaAd8xYchiZ
	i5hVg+EURAqqlN
X-X-Sender: gene099@racer.site
In-Reply-To: <1196923525.10408.103.camel@brick>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67278>

Hi,

On Wed, 5 Dec 2007, Harvey Harrison wrote:

> On Thu, 2007-12-06 at 01:43 -0500, Jeff King wrote:
> > On Wed, Dec 05, 2007 at 10:22:33PM -0800, Harvey Harrison wrote:
> > 
> > > // fetching someone else's remote branches is not a standard thing to do
> > > // so we'll need to edit our .git/config file
> > > // you should have a section that looks like:
> > > [remote "gcc.gnu.org"]
> > > 	url = git://git.infradead.org/gcc.git
> > > 	fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> > > // infradead's mirror puts the gcc svn branches in its own namespace
> > > // refs/remotes/gcc.gnu.org/*
> > > // change our fetch line accordingly
> > > [remote "gcc.gnu.org"]
> > > 	url = git://git.infradead.org/gcc.git
> > > 	fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
> > 
> > FWIW, if you are writing a shell recipe for other people to cut and
> > paste, you can say this as:
> > 
> >   git config remote.gcc.gnu.org.fetch \
> >     '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'
> 
> I thought about that, but I like to encourage people to actually look at 
> the config file, it's pretty easy to understand.

I agree that people should be encouraged to edit their .git/config.  But a 
recipe is something easy-to-follow IMHO, so I would write this as a shell 
script (with #-comments, not //-comments).

Ciao,
Dscho
