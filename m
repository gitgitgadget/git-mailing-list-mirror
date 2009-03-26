From: Jeff King <peff@peff.net>
Subject: Re: Question: Is it possible to host a writable git repo over both
	http and ssh?
Date: Thu, 26 Mar 2009 00:56:51 -0400
Message-ID: <20090326045650.GA13628@coredump.intra.peff.net>
References: <49CA6A17.6050903@gmail.com> <20090326021259.GA5835@coredump.intra.peff.net> <49CAF607.1020905@gmail.com> <20090326033623.GA8031@coredump.intra.peff.net> <49CB0AC1.2070006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfr-0003rO-6S
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZCZE5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZCZE5G
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:57:06 -0400
Received: from peff.net ([208.65.91.99]:53086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbZCZE5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:57:03 -0400
Received: (qmail 12164 invoked by uid 107); 26 Mar 2009 04:57:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 00:57:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 00:56:51 -0400
Content-Disposition: inline
In-Reply-To: <49CB0AC1.2070006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114734>

On Wed, Mar 25, 2009 at 11:55:29PM -0500, Mike Gaffney wrote:

> I'm actually trying to take what Sean did with gerrit and extract a
> full Java/MinaSSHD based server that doesn't require a real user
> account and is configurable by spring. So yes, I'm using JGit on the
> server.

Ah. In that case, I don't know whether JGit respects all hooks. You
should ask Shawn (Shawn, we are talking about a post-update to run
update-server-info). :)

-Peff
