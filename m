From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 16:04:28 -0400
Message-ID: <20090319200428.GC17028@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net> <49C1F232.2090009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOVz-00019D-9r
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760544AbZCSUEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZCSUEm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:04:42 -0400
Received: from peff.net ([208.65.91.99]:59430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760815AbZCSUEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:04:38 -0400
Received: (qmail 3180 invoked by uid 107); 19 Mar 2009 20:04:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 16:04:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 16:04:28 -0400
Content-Disposition: inline
In-Reply-To: <49C1F232.2090009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113819>

On Thu, Mar 19, 2009 at 08:20:18AM +0100, Johannes Sixt wrote:

> Your patch fixes it. The following change to the test case would be a good
> addition; it protects later tests from failures in earlier tests.

I'll clean up and re-submit my patch, then (once we figure out the right
API ;) ).  Your patch seems reasonable, but it should be a separate
patch, I think.

-Peff
