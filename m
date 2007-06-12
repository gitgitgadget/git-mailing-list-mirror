From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-fetch, was Re: [PATCH] Port git-tag.sh to C.
Date: Tue, 12 Jun 2007 19:55:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706121953080.5848@iabervon.org>
References: <11813427591137-git-send-email-krh@redhat.com>
 <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
 <Pine.LNX.4.64.0706112314300.5848@iabervon.org> <Pine.LNX.4.64.0706121341250.4059@racer.site>
 <Pine.LNX.4.64.0706121427410.18585@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carlos Rica <jasampler@gmail.com>,
	=?X-UNKNOWN?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 13 01:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyGCv-0006Ro-Ik
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 01:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbXFLXz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbXFLXz2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 19:55:28 -0400
Received: from iabervon.org ([66.92.72.58]:2180 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbXFLXz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 19:55:28 -0400
Received: (qmail 19365 invoked by uid 1000); 12 Jun 2007 23:55:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 23:55:26 -0000
In-Reply-To: <Pine.LNX.4.64.0706121427410.18585@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50008>

On Tue, 12 Jun 2007, Julian Phillips wrote:

> On Tue, 12 Jun 2007, Johannes Schindelin wrote:
> 
> > Hi,
> >
> > On Mon, 11 Jun 2007, Daniel Barkalow wrote:
> >
> > > On Sat, 9 Jun 2007, Carlos Rica wrote:
> > >
> > > > Feel free to choose the script which you need to get replaced first,
> > > > or, depending on your urgency, you could ask me for one of them and I
> > > > would try to concentrate my efforts on it. Why do you started with
> > > > git-tag? For me, it was enough easy to begin with, perhaps you could
> > > > have other reasons.
> > >
> > > Incidentally, I have been working on fetch, based on Julian Phillips's
> > > version. I'm trying to split out the "how do I communicate with remote
> > > repositories" code, and use it for pushing and ls-remote as well as
> > > fetch. I've got a bunch of not-for-official-history development that you
> > > should look at if you try any of the remote-repository-access scripts.
> >
> > How about pushing them onto repo.or.cz as a fork of git.git?
> 
> I'd quite like to see these changes too - since I haven't finished the fetch
> work yet, and I don't want to duplicate effort ;)

Okay, git://iabervon.org/~barkalow/git.git builtin-fetch.

	-Daniel
*This .sig left intentionally blank*
