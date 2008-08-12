From: Jeff King <peff@peff.net>
Subject: Re: fastest way to check if dir is a workdir
Date: Tue, 12 Aug 2008 09:01:28 -0400
Message-ID: <20080812130128.GA28658@sigill.intra.peff.net>
References: <200808121334.57066.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Aug 12 15:03:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStWI-0006gy-Nr
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 15:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYHLNBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYHLNBf
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 09:01:35 -0400
Received: from peff.net ([208.65.91.99]:4435 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbYHLNBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 09:01:34 -0400
Received: (qmail 23299 invoked by uid 111); 12 Aug 2008 13:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 12 Aug 2008 09:01:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Aug 2008 09:01:28 -0400
Content-Disposition: inline
In-Reply-To: <200808121334.57066.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92095>

On Tue, Aug 12, 2008 at 01:34:56PM +0200, Thomas Koch wrote:

> I'm writing a little php-git-wrapper and would like to have a function
> which tells me, whether a given path is part of a git checkout or not.
> 
> What would be the fastest commandline to check, whether the current dir
> is part of a checkout? It may be assumed that the repository is at the
> standard position.

How about "git rev-parse --is-inside-work-tree"?

-Peff
