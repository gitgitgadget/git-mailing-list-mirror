From: Jeff King <peff@peff.net>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 11:57:12 -0400
Message-ID: <20071025155712.GA21446@coredump.intra.peff.net>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025155142.GB19655@coredump.intra.peff.net> <86fxzz6vfh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il55M-0006Nj-B9
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 17:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXJYP5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbXJYP5P
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 11:57:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4013 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbXJYP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 11:57:15 -0400
Received: (qmail 21957 invoked by uid 111); 25 Oct 2007 15:57:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 25 Oct 2007 11:57:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2007 11:57:12 -0400
Content-Disposition: inline
In-Reply-To: <86fxzz6vfh.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62328>

On Thu, Oct 25, 2007 at 08:55:14AM -0700, Randal L. Schwartz wrote:

> It's probably due to this:
> 
> [remote "origin"]
>         url = [obscured]
>         fetch = +refs/heads/*:refs/remotes/origin/*
> 
> fetch wants to sync my heads with the origin heads.  But yes, it's
> definitely the fetch that fails under today's version, and not
> under yesterday's version.

So that should take the remote's refs/heads/* and put them in your
refs/remotes/origin/*. I don't see how that would have anything to do
with your 'refs/heads/upstream' branch.

-Peff
