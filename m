From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 14:44:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241443230.8986@racer>
References: <20080723145518.GA29035@laptop>  <alpine.DEB.1.00.0807231713280.8986@racer>  <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>  <alpine.DEB.1.00.0807231753240.8986@racer>  <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
  <alpine.DEB.1.00.0807241340490.8986@racer> <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 15:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM18B-0002E8-Cf
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYGXNoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYGXNoR
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:44:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:48310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752830AbYGXNoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 09:44:17 -0400
Received: (qmail invoked by alias); 24 Jul 2008 13:44:15 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp058) with SMTP; 24 Jul 2008 15:44:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FrMsKGkDFtA42B2gY+WP+je9BoXpyxyYnKkSbA0
	POjj3Fy511w+mb
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89880>

Hi,

On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:

> On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  > > No, I did mean the index.  This is an attribute of the index: 
> >  > > either it is sparsely checked out or not.  You can even have 
> >  > > multiple indices (switching between them by setting 
> >  > > GIT_INDEX_FILE) which have different prefixes.
> >  >
> >  > I don't think so. It's a mask for workdir, right? If you save it it 
> >  > index, you can switch index and the prefix as well, but workdir 
> >  > only has several subtrees that do not fit any other prefix than the 
> >  > original prefix.
> >
> >
> > Ah, you adroitly avoided addressing the issue that the user can change 
> > the prefix without the index ever noticing.
> 
> Forgive my ignorance. I still do not get why index must notice prefix 
> change? The only reason I can think of is that we must make sure there 
> won't be any user-modification in index outside the prefix. But that can 
> be guarded from higher level (plumbings and porcelains) because index is 
> allowed to have modification outside sparse prefix (auto-merged 
> entries).

Why do you want to guard it from the outside?  When the obvious fix is to 
put together what belongs together?

Hth,
Dscho
