From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 06:39:38 -0500
Message-ID: <20070227113938.GA5423@coredump.intra.peff.net>
References: <20070226121557.GA18114@coredump.intra.peff.net> <7virdnhpbt.fsf@assigned-by-dhcp.cox.net> <20070227105212.GA21757@coredump.intra.peff.net> <200702271131.57856.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 12:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0gJ-0001MR-Nw
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbXB0Ljl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933047AbXB0Ljl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:39:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4956 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933044AbXB0Ljk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:39:40 -0500
Received: (qmail 16752 invoked from network); 27 Feb 2007 06:39:53 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Feb 2007 06:39:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2007 06:39:38 -0500
Content-Disposition: inline
In-Reply-To: <200702271131.57856.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40712>

On Tue, Feb 27, 2007 at 11:31:52AM +0000, Andy Parkins wrote:

> > there are dozens of repositories; I would now like to group them in the
> > same repo for ease of clone/fetch.
> 
> It doesn't have fetch or clone support, but perhaps my poorman's submodule 
> code will help you a bit, until real submodule support appears in git.

Thanks for the pointer, but it doesn't handle one of my pet peeves with
many repositories: fetching 25 repositories takes a long time. I have a
"look at every repository and see if anything needs fetched or pushed"
script; it takes about 0.5-1.0 seconds per repository. Turning 25
fetches into 1 makes it a lot nicer to use.

So of all the problems hoped to be solved by submodule support, I think
your poor man's submodule support solves the ones I don't care about
(tracking external repositories with merge resolution) but not the one I
do (fetch/clone effort). :)

-Peff
