From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] add lame win32 credential-helper
Date: Thu, 15 Sep 2011 17:40:26 -0400
Message-ID: <20110915214026.GA18623@sigill.intra.peff.net>
References: <1316118324-6164-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jaysoffian@gmail.com, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Jfd-0001Xl-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935087Ab1IOVk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:40:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57204
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935035Ab1IOVk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:40:29 -0400
Received: (qmail 26561 invoked by uid 107); 15 Sep 2011 21:41:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 17:41:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 17:40:26 -0400
Content-Disposition: inline
In-Reply-To: <1316118324-6164-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181520>

On Thu, Sep 15, 2011 at 10:25:24PM +0200, Erik Faye-Lund wrote:

> Not that it's useful yet, since the core-git code for the
> credential-helper support doesn't compile on Windows. So
> it's not fully tested, I've only read the interface
> documentation and experimented with it from the command
> line.

Which parts of the credential-helper code don't compile? I wouldn't be
surprised if the cache helper doesn't work (because it uses unix domain
sockets for communication). If it's too hard to adapt it to whatever IPC
mechanism would be appropriate on Windows, we can just leave it out on
that platform.

But the core code in git itself should be pretty straight forward. Let
me know what I can do to help.

-Peff
