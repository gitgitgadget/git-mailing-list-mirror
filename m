From: Jeff King <peff@peff.net>
Subject: Re: Documentation for "git log --all" incorrect
Date: Wed, 29 Oct 2014 15:54:45 -0400
Message-ID: <20141029195445.GA27413@peff.net>
References: <20141029115134.GA33348@bat.dot-bit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Francis Irving <francis@scraperwiki.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:54:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZKW-00028O-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbaJ2Tyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:54:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:34971 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756185AbaJ2Tys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:54:48 -0400
Received: (qmail 601 invoked by uid 102); 29 Oct 2014 19:54:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 14:54:48 -0500
Received: (qmail 2532 invoked by uid 107); 29 Oct 2014 19:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 15:54:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2014 15:54:45 -0400
Content-Disposition: inline
In-Reply-To: <20141029115134.GA33348@bat.dot-bit.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 11:51:34AM +0000, Francis Irving wrote:

> The help for "git log --all" says:
> 
>        --all
>                   Pretend as if all the refs in refs/ are listed on
>                   the command line as <commit>.
> 
> This makes no sense, as <commit> is not a documented valid command line
> parameter. These are the documented parameters:
> 
>         SYNOPSIS
>                git log [<options>] [<revision range>] [[--] <path>...]
> 
> Even if it means <revision range>, which is my best guess, it still
> makes no sense as <revision range> cannot be a list of many refs.

The text for "--all" comes from rev-list-options.txt, which is included
in git-rev-list.txt and git-log.txt. It makes sense in the former but
not the latter. One fix would be to use "<commit>" in the synopsis for
git-log. But I think it would probably be OK to just drop the "as
<commit>" part of the --all text (and other related options need this,
too). It seems pretty clear to me without it.

Do you want to try your hand at a patch?

-Peff
