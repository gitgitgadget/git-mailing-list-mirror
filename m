From: Jeff King <peff@peff.net>
Subject: Re: Using grafts file to rewrite history
Date: Wed, 25 Feb 2009 01:10:19 -0500
Message-ID: <20090225061018.GA6211@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0902250626300.9572@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcCzn-0005mk-3d
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZBYGKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZBYGKX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:10:23 -0500
Received: from peff.net ([208.65.91.99]:32908 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbZBYGKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:10:22 -0500
Received: (qmail 21685 invoked by uid 107); 25 Feb 2009 06:10:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 01:10:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 01:10:19 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0902250626300.9572@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111373>

On Wed, Feb 25, 2009 at 06:29:46AM +0100, Peter Krefting wrote:

> Given an (unpublished) Git repository and a "grafts" file that slightly
> re-orders commits, how do I reprocess this repository (using
> git-filter-branch, probably) to have a true history according to the
> "grafts" file?

Running filter-branch at all will glue the grafts together. It is even
one of the examples given in the git-filter-branch(1) manpage.

-Peff
