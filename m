From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] config: support values longer than 1023 bytes
Date: Sun, 10 Apr 2011 16:58:52 -0400
Message-ID: <20110410205851.GB2069@sigill.intra.peff.net>
References: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
 <1302468858-7376-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 22:59:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q91io-0004t8-0w
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 22:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1DJU64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 16:58:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36563
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475Ab1DJU6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 16:58:55 -0400
Received: (qmail 26477 invoked by uid 107); 10 Apr 2011 20:59:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.197.88.253)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Apr 2011 16:59:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Apr 2011 16:58:52 -0400
Content-Disposition: inline
In-Reply-To: <1302468858-7376-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171289>

On Sun, Apr 10, 2011 at 10:54:18PM +0200, Erik Faye-Lund wrote:

> parse_value in config.c has a static buffer of 1024 bytes that it
> parse the value into. This can sometimes be a problem when a
> config file contains very long values.
> 
> It's particularly amusing that git-config already is able to write
> such files, so it should probably be able to read them as well.
> 
> Fix this by using a strbuf instead of a fixed-size buffer.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

Looks fine to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
