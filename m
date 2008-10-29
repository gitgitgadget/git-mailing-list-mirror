From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 20:39:32 -0400
Message-ID: <20081029003931.GA7291@sigill.intra.peff.net>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com> <1225238368-98594-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:40:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuz7D-0000mT-8c
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbYJ2Aji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbYJ2Aji
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:39:38 -0400
Received: from peff.net ([208.65.91.99]:3212 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYJ2Aji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:39:38 -0400
Received: (qmail 24726 invoked by uid 111); 29 Oct 2008 00:39:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 20:39:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 20:39:32 -0400
Content-Disposition: inline
In-Reply-To: <1225238368-98594-1-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99338>

On Tue, Oct 28, 2008 at 04:59:28PM -0700, David Symonds wrote:

> --- /dev/null
> +++ b/git-staged.sh
> @@ -0,0 +1,2 @@
> +#!/bin/sh
> +exec git diff --cached $*

This is broken for arguments with spaces. Use "$@" instead.

But I think this isn't a serious patch anyway, so we are probably
wasting too much time on it. ;P

-Peff
