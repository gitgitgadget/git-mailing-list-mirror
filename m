From: Jeff King <peff@peff.net>
Subject: Re: git-reflog infinite loop
Date: Tue, 10 Jun 2008 23:47:18 -0400
Message-ID: <20080611034718.GB7198@sigill.intra.peff.net>
References: <484EBD92.8040603@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 05:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6HJo-00088T-4D
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 05:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYFKDrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 23:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbYFKDrV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 23:47:21 -0400
Received: from peff.net ([208.65.91.99]:1253 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272AbYFKDrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 23:47:21 -0400
Received: (qmail 30018 invoked by uid 111); 11 Jun 2008 03:47:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 10 Jun 2008 23:47:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2008 23:47:18 -0400
Content-Disposition: inline
In-Reply-To: <484EBD92.8040603@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84585>

On Tue, Jun 10, 2008 at 07:44:50PM +0200, Pascal Obry wrote:

> In one of my repository, "git gc" will never terminate.
>
> I have traced to the underlying call git-reflog:
>
>    $ git-reflog expire --all
>
> It seems to heat a good amount of heap memory and will keep running using 
> 100% of CPU.
>
> Is that a known issue?

I can't reproduce here, so presumably it is some condition in your
repository; can you make a tarball of your .git directory available?

-Peff
