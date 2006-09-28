From: Jeff King <peff@peff.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 23:52:25 -0400
Message-ID: <20060928035225.GA22006@coredump.intra.peff.net>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 05:52:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmwp-0006fX-6z
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWI1Dw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWI1Dw2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:52:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:57780 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750773AbWI1Dw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 23:52:28 -0400
Received: (qmail 20561 invoked from network); 27 Sep 2006 23:52:25 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Sep 2006 23:52:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2006 23:52:25 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <451B45D6.1010006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27978>

On Wed, Sep 27, 2006 at 08:47:34PM -0700, A Large Angry SCM wrote:

> >A first step to this would be an argument to git-clone to allow cloning
> >only a subset of refs.
> Something like this?
> 
> 	git-init-db
> 	git-fetch <repository> <refspecs>

Exactly, but I was suggesting something more user-friendly (e.g., it's
nice to use git-clone because it creates the remotes file). I was going
to hack up a quick change to git-clone, but I think some thought needs
to be given to semantics, especially with respect to tags (should it
imply no tags? Only tags which point to refs we're already fetching?).

-Peff
