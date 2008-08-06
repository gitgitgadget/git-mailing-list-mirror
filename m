From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't respect config: diff.renames=copies
Date: Wed, 6 Aug 2008 10:06:03 -0400
Message-ID: <20080806140602.GA20423@sigill.intra.peff.net>
References: <20080806114340.GA24552@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQjfX-0004qP-NQ
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbYHFOGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 10:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbYHFOGI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:06:08 -0400
Received: from peff.net ([208.65.91.99]:2789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbYHFOGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:06:07 -0400
Received: (qmail 31629 invoked by uid 111); 6 Aug 2008 14:06:04 -0000
Received: from lawn-128-61-21-105.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.21.105)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 06 Aug 2008 10:06:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2008 10:06:03 -0400
Content-Disposition: inline
In-Reply-To: <20080806114340.GA24552@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91512>

On Wed, Aug 06, 2008 at 01:43:40PM +0200, Stephen R. van den Berg wrote:

> What do I need to enter in /etc/gitconfig to get all commands that
> deal with diffs of some kind to honour renames=copies ?

$ git grep -A3 diff.renames
config.txt:diff.renames::
config.txt-     Tells git to detect renames.  If set to any boolean value, it
config.txt-     will enable basic rename detection.  If set to "copies" or
config.txt-     "copy", it will detect copies, as well.

-Peff
