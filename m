From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Thu, 25 Aug 2005 15:41:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508251210030.23242@iabervon.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
 <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
 <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
 <tnxvf1wd24m.fsf@arm.com> <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
 <20050823212305.GA5936@fanta> <Pine.LNX.4.63.0508231731370.23242@iabervon.org>
 <20050825070955.GA762@eros.intern.mind.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 21:38:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8NXr-0003Sv-1Q
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 21:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVHYThs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHYThs
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 15:37:48 -0400
Received: from iabervon.org ([66.92.72.58]:43278 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751373AbVHYThr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 15:37:47 -0400
Received: (qmail 19394 invoked by uid 1000); 25 Aug 2005 15:41:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Aug 2005 15:41:23 -0400
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050825070955.GA762@eros.intern.mind.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7757>

On Thu, 25 Aug 2005, Jan Veldeman wrote:

> Daniel Barkalow wrote:
>
> > I'm not sure how applicable to this situation stgit really is; I see stgit
> > as optimized for the case of a patch set which is basically done, where
> > you want to keep it applicable to the mainline as the mainline advances.
>
> Maybe I forgot to mention this: I would also like to have my development
> tree split up in a patch stack. The separate patches makes tracking the
> mainline a lot easier (conflicts are a lot easier to solve)

I just try to keep things in this state sufficiently briefly that it
doesn't become a problem. I also split things up into a bunch of branches,
rather than into a stack of patches, and only work on parallel development
before I've actually got a candidate for a series.

> But this would assume that once the patch goes into stgit, it won't
> change except when the parent gets updated. I think we will still change
> the patches quite a bit and simultanious by a couple of people.

The extension I had proposed to stgit should work for this; it would let
you version control each patch just like other git projects. I just think
it wouldn't work so well before the group has agreed on what patches there
are.

	-Daniel
*This .sig left intentionally blank*
