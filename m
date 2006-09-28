From: Jeff King <peff@peff.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 00:00:27 -0400
Message-ID: <20060928040027.GA22489@coredump.intra.peff.net>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com> <20060928035225.GA22006@coredump.intra.peff.net> <20060928035855.GD22897@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSn4b-0007r3-5r
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWI1EAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWI1EAa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:00:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:9654 "HELO
	peff.net") by vger.kernel.org with SMTP id S965164AbWI1EA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 00:00:29 -0400
Received: (qmail 20927 invoked from network); 28 Sep 2006 00:00:27 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Sep 2006 00:00:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2006 00:00:27 -0400
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060928035855.GD22897@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27981>

On Wed, Sep 27, 2006 at 11:58:55PM -0400, Shawn Pearce wrote:

> If you are fetching a set of commits from a repository you probably
> should be fetching any tags that point at the commits you've fetched.
> They tend to be few compared to the commits, they tend to be small,
> and they tend to be important milestones in the tracked project.
> 
> I think that's why the native Git protocol sends tags for any
> commits that were also sent.  :)

Oh, that's clever. :)

Do we do the right thing for non-git transports?

-Peff
