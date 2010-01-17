From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse --namespace
Date: Sun, 17 Jan 2010 11:27:12 -0500
Message-ID: <20100117162712.GB7153@sigill.intra.peff.net>
References: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 17 17:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWXyD-0006uX-AI
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 17:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab0AQQ1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 11:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754060Ab0AQQ1P
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 11:27:15 -0500
Received: from peff.net ([208.65.91.99]:44975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab0AQQ1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 11:27:14 -0500
Received: (qmail 25754 invoked by uid 107); 17 Jan 2010 16:32:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 17 Jan 2010 11:32:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 11:27:12 -0500
Content-Disposition: inline
In-Reply-To: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137304>

On Sun, Jan 17, 2010 at 03:45:31PM +0200, Ilari Liusvaara wrote:

> Add --namespace=<namespace> option to rev-parse and everything that
> accepts its options. This option matches all refs in some subnamespace
> of refs hierarchy, and is useful for selecting everything reachable from
> one or few, but not all remotes (--namespace=remotes/foo).

If I understand it correctly, isn't the same as

  git for-each-ref refs/remotes/foo

?

-Peff
