From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git's database structure
Date: Thu, 6 Sep 2007 13:56:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061354180.28586@racer.site>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> 
 <7vtzqany0z.fsf@gitster.siamese.dyndns.org> 
 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com> 
 <20070904212507.GA24434@thunk.org>  <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
  <46DE5861.4050201@op5.se>  <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
  <46DEC26E.7030809@op5.se>  <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
  <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
 <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:57:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITGun-0004PA-Tl
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 14:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbXIFM4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 08:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbXIFM4w
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 08:56:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:33483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753904AbXIFM4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 08:56:51 -0400
Received: (qmail invoked by alias); 06 Sep 2007 12:56:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 06 Sep 2007 14:56:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SyMsSmXkS3LoFRabkqs1KCkeIfueGoTvD2MwEQX
	N2nPKOk36wN1dI
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57874>

Hi,

On Wed, 5 Sep 2007, Jon Smirl wrote:

> On 9/5/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> > On Wed, 5 Sep 2007, Jon Smirl wrote:
> >
> > >> Ah, there we go. A use-case at last :)
> >
> > But not a brilliant one.  You sign off on commits not blobs.  So you 
> > go from the sign-off to paths, then to blobs.  There is no need to go 
> > from blob to path unless you deliberately introduce such a need.
> 
> Use blame for an example. Blame has to crawl every commit to see if it 
> touched the file. It keeps doing this until it figures out the last 
> author for every line in the file. Worse case blame has to crawl every 
> commit in the data store.

But you can add _yet another_ index to it, which can be generated on the 
fly, so that Git only has to generate the information once, and then reuse 
it later.  As a benefit of this method, the underlying well-tested 
structure needs no change at all.

BTW could you please, please, please cut the quoted message that you are 
_not_ responding to?  It really _wastes_ my time.

Ciao,
Dscho
