From: Jeff King <peff@peff.net>
Subject: Re: Problems with format-patch UTF-8 and a missing second empty line
Date: Thu, 15 Sep 2011 11:17:34 -0400
Message-ID: <20110915151734.GA18305@sigill.intra.peff.net>
References: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Ruhnke <grumbel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:17:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Dh8-0005eP-C7
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933985Ab1IOPRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 11:17:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab1IOPRh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 11:17:37 -0400
Received: (qmail 22096 invoked by uid 107); 15 Sep 2011 15:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 11:18:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 11:17:34 -0400
Content-Disposition: inline
In-Reply-To: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181471>

On Thu, Sep 15, 2011 at 11:45:15AM +0200, Ingo Ruhnke wrote:

> Creating a patch of a commit including UTF-8 and no empty second line,
> like this:
> [...]
> Results in this:
> [...]
> Subject: [PATCH] =?UTF-8?q?=C3=84=C3=96=C3=9C
> =20=C3=84=C3=96=C3=9C?=
>[....]
> The problems happen with git version 1.7.4.1 (4b5eac7f0) on Ubuntu 11.04.

I'm pretty sure I fixed this in a1f6baa, which is in v1.7.4.4 and later.

-Peff
