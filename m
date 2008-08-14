From: Sam Vilain <sam@vilain.net>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Fri, 15 Aug 2008 00:42:23 +1200
Message-ID: <1218717743.11530.99.camel@maia.lan>
References: <200807080227.43515.jnareb@gmail.com>
	 <200808140457.56464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	gittorrent@lists.utsl.gen.nz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 14:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTcB2-0004sE-AM
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 14:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbYHNMmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 08:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYHNMmg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 08:42:36 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54858 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbYHNMmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 08:42:35 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id A33AC21C81E; Fri, 15 Aug 2008 00:42:32 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 109D821C318;
	Fri, 15 Aug 2008 00:42:21 +1200 (NZST)
In-Reply-To: <200808140457.56464.jnareb@gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92355>

On Thu, 2008-08-14 at 04:57 +0200, Jakub Narebski wrote:
> 1. GitTorrent
>  
> Student: Joshua Roys
> Mentor: Sam Vilain
> 
> If I remember correctly at midterm it was deemed to be somewhat late;
> metainfo was done, tracker was in works, some core infrastructure
> and beginnings of peer to peer:
>   http://thread.gmane.org/gmane.comp.version-control.git.gittorrent/1
> 
> Unfortunately this project, even that is as much tied with git as
> StGIT,
> or egit/jgit, or git-gui or gitk, all of which use git mailing list
> for 
> discussion and patches, choose to have its own separate mailing list; 
> moreover I think most of discussion was kept private.
> 
> Status: I have no idea how close GitTorrent is to completion (where
> by 
> completion I mean ready, tested and benchmarked code running e.g. on 
> kernel.org).  I'm not sure if it is meant to be incorporated in git, 
> even in contrib, or remain separate like StGIT, TopGit or jgit.

The scope outlined in the GitTorrent proposal was a little bit more of a
research project; being ready for production use on kernel.org or having
code ready to merge to git was not directly a deliverable.

The approved idea at the outset of *this* project was to try out the RFC
protocol design as it stands, iron out the weaknesses and see how it
performs.  As it was pointed out along the way, there are other simpler
designs possible, but I tried to explain how the fully denormalized
design of the current RFC gives it more legs compared to other
approaches.  ie the goal was to prove the proposed network design, and
test it and show it to be as resource efficient as the more pragmatic
designs proposed by people like Johannes (or, indeed, earlier versions
from Jonas which were much closer to bittorrent in design).

I was certainly hoping that at or shortly after the end it would at that
point also be good enough to be useful for production sites, even
kernel.org sized (perhaps requiring the odd piece rewritten in C).  We
just need to crawl before we can walk, so to speak.

I think saying "we're on track to prove the protocol" might be a little
of an exaggeration at this point.  But we have got a test script that is
performing a replication between two test directories, transmitting data
over sockets using GTP.

Once Joshua has wrapped up this work to make it "less hackish" to
drive ;) then we can review the implementation and sign off on
completion of what was technically set out to complete.  At that point
the design becomes open to suggestions from the floor again.

Anyway, that's the current status at this time.  Thanks for the prod to
update, Jakub.  Come the actual completion date of the program, there
will be complete news.

Cheers,
Sam.

---
and now the rant:

Please bear in mind that some of the "why Didn't You Just..." type
comments are really "20/20 hindsight" now.  And please, comments about
what was made public and what not are also not useful.  The initial
design decisions between Jonas and myself are mostly in the RFC in
comments and in history from gittorrent.utsl.gen.nz.  Sure we chatted on
IRC about it here and there as well.  But the RFC has had a public
profile since at least last year's GSoC when our last student was
accepted to build it, but few people found time to comment on it.  I
have made every effort to keep everything useful in the public arena and
as far as I know never turned down the opportunity to answer questions.
And snide remarks about my choice to press a few buttons on my list
server to make a new mailing list for a project I was undertaking I
simply have no time for.
