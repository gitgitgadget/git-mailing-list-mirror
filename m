From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] ls-remote: fall-back to default remotes when no
 remote specified
Date: Thu, 8 Apr 2010 15:19:06 -0400
Message-ID: <20100408191905.GB14066@sigill.intra.peff.net>
References: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
 <1270747273-1504-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzxFz-0005fD-Na
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197Ab0DHTTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 15:19:11 -0400
Received: from peff.net ([208.65.91.99]:48410 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933150Ab0DHTTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 15:19:09 -0400
Received: (qmail 24774 invoked by uid 107); 8 Apr 2010 19:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Apr 2010 15:19:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 15:19:06 -0400
Content-Disposition: inline
In-Reply-To: <1270747273-1504-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144372>

On Fri, Apr 09, 2010 at 01:21:13AM +0800, Tay Ray Chuan wrote:

> Instead of breaking execution when no remote (as specified in the
> variable dest) is specified when git-ls-remote is invoked, continue on
> and let remote_get() handle it.

This version looks OK to me. Thanks.

-Peff
