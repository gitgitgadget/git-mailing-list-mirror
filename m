From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: remove redundant check for freeing memory
Date: Tue, 20 Aug 2013 10:28:42 -0400
Message-ID: <20130820142842.GB839@sigill.intra.peff.net>
References: <52137A63.3010609@googlemail.com>
 <1377008280-17230-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@inf.ethz.ch
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmvS-0007xg-DI
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab3HTO2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:28:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:37760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab3HTO2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:28:46 -0400
Received: (qmail 21953 invoked by uid 102); 20 Aug 2013 14:28:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 09:28:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 10:28:42 -0400
Content-Disposition: inline
In-Reply-To: <1377008280-17230-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232605>

On Tue, Aug 20, 2013 at 04:18:00PM +0200, Stefan Beller wrote:

> The condition as it is written in that line has already been checked
> in the beginning of the function, which was introduced in
> 8503ee4 (2007-05-01, Fix read_mailmap to handle a caller uninterested
> in repo abbreviation)
> 
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---

This version looks good to me.  Thanks.

-Peff
