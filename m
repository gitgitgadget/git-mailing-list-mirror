From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve output of %p and %P format in git-rev-list --pretty=format:
Date: Wed, 28 Mar 2007 16:24:09 -0400
Message-ID: <20070328202409.GA32092@coredump.intra.peff.net>
References: <20070328000828.GA13273@coredump.intra.peff.net> <20070328201123.GB2588@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWegr-0004Y5-2H
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 22:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965774AbXC1UYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965775AbXC1UYO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 16:24:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1299 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965774AbXC1UYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 16:24:13 -0400
Received: (qmail 12913 invoked from network); 28 Mar 2007 20:24:42 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 20:24:42 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 16:24:09 -0400
Content-Disposition: inline
In-Reply-To: <20070328201123.GB2588@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43384>

On Wed, Mar 28, 2007 at 10:11:23PM +0200, Alex Riesen wrote:

> Remove the terminating space from the space-separated list of parents.
> Also fix the test t6006: it wrongly assumed that the initial commit
> has a parent and was not executable.

Argh, yes. As is probably obvious, I moved the actual output to be
'expected' after giving it a cursory check, but I was more focused on
the author/committer information, since that's where I was fixing bugs.
Good catch.

This is obviously fairly untested code.  I will follow up with a few
more tests for encoding/body to help make it more complete.

-Peff
