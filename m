From: Jeff King <peff@peff.net>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 08:04:46 -0500
Message-ID: <20071121130446.GA18414@sigill.intra.peff.net>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net> <1A9343EE-BB45-4CF8-9F17-E6A73C5F0B83@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Toby White <tow21@cam.ac.uk>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupGO-00049o-08
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbXKUNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbXKUNEu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:04:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbXKUNEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:04:50 -0500
Received: (qmail 7347 invoked by uid 111); 21 Nov 2007 13:04:49 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 08:04:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 08:04:46 -0500
Content-Disposition: inline
In-Reply-To: <1A9343EE-BB45-4CF8-9F17-E6A73C5F0B83@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65643>

On Wed, Nov 21, 2007 at 01:59:37PM +0100, Wincent Colaiuta wrote:

> So here's a less-broken version of your suggestion, but it's still broken; a 
> relatively complex wrapper is required to do this right:

Thanks. My "something like" should more accurately have been "I really
didn't think about this at all." But I do think a GIT_EXTERNAL_DIFF-type
approach (and if GIT_EXTERNAL_DIFF isn't powerful enough, considering
some alternate interface) is nicer than trying to wrap git-diff.

> $ cat >merge.sh <<EOF
> #!/bin/sh
> [ \$# -eq 7 ] && opendiff "\$2" "\$5"
> EOF

This is probably easier to read using <<'EOF' to quote (but I failed to
do even that in my example).

-Peff
