From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 13:42:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241340490.8986@racer>
References: <20080723145518.GA29035@laptop>  <alpine.DEB.1.00.0807231713280.8986@racer>  <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>  <alpine.DEB.1.00.0807231753240.8986@racer> <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM0Ae-0001S9-TU
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbYGXMms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbYGXMms
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:42:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:57201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753696AbYGXMmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:42:47 -0400
Received: (qmail invoked by alias); 24 Jul 2008 12:42:46 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp002) with SMTP; 24 Jul 2008 14:42:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gILdg3fPgIL8LNanxN7t45KAbaTskyl2q/gGtLJ
	ZuEQIYgkF66yF4
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89875>

Hi,

On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:

> On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Wed, 23 Jul 2008, Nguyen Thai Ngoc Duy wrote:
> >
> >  > On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  >
> >  > > And with core.sparseCheckout you are at the whim of the user, 
> >  > > since .git/config is _supposed_ to be user-editable.
> >  >
> >  > Well, whatever place. I chose .git/config because I did not want to 
> >  > introduce a new config place. But then how about 
> >  > .git/sparsecheckout?
> >
> > No, I did mean the index.  This is an attribute of the index: either 
> > it is sparsely checked out or not.  You can even have multiple indices 
> > (switching between them by setting GIT_INDEX_FILE) which have 
> > different prefixes.
> 
> I don't think so. It's a mask for workdir, right? If you save it it 
> index, you can switch index and the prefix as well, but workdir only has 
> several subtrees that do not fit any other prefix than the original 
> prefix.

Ah, you adroitly avoided addressing the issue that the user can change the 
prefix without the index ever noticing.

Well, in any case, if you do not agree that the prefix is really an 
attribute of the index, then there is nothing else I have to say on this 
series.

Ciao,
Dscho
