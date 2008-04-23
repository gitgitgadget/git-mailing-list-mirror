From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3 v2] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 17:55:01 -0400
Message-ID: <20080423215501.GB30057@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness> <1208981890-758-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:56:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jomwh-0005LJ-Pd
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 23:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYDWVy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYDWVy7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 17:54:59 -0400
Received: from peff.net ([208.65.91.99]:3560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbYDWVy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 17:54:59 -0400
Received: (qmail 30618 invoked by uid 111); 23 Apr 2008 21:54:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 17:54:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 17:55:01 -0400
Content-Disposition: inline
In-Reply-To: <1208981890-758-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80263>

On Wed, Apr 23, 2008 at 04:18:10PM -0400, Avery Pennarun wrote:

> From: Jeff King <peff@peff.net>
> 
> This patch allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'

The commit message munging you did is fine.

However, I think Johannes Sixt's question about providing the pathname
needs to be resolved. As it is now, the blob-filter is impossible to use
in a mixed binary/text repository, short of the undocumented $path magic
that you described. And I am a little uncomfortable just adding the
$path as he suggested because of the subtle bug it introduces.

-Peff
