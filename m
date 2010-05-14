From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] All is too much
Date: Fri, 14 May 2010 02:06:12 -0400
Message-ID: <20100514060612.GA19652@coredump.intra.peff.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
 <cover.1273760226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 14 08:06:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCo2P-0008LY-IY
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 08:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab0ENGGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 02:06:16 -0400
Received: from peff.net ([208.65.91.99]:41933 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab0ENGGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 02:06:15 -0400
Received: (qmail 28905 invoked by uid 107); 14 May 2010 06:06:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 02:06:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 02:06:12 -0400
Content-Disposition: inline
In-Reply-To: <cover.1273760226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147052>

On Thu, May 13, 2010 at 04:24:34PM +0200, Michael J Gruber wrote:

> This series introduces --lrbranches and --locals as abbreviations
> for "HEAD --branches --remotes" (local and remote branches) resp.
> "HEAD --branches --tags" (local refs).

Thanks. --lrbranches is still a little ugly to me, but it does address
my concern with --heads, and I don't have a better suggestion.

Patch 4/4 itself looks OK. Did you test each part of the series
independently, though? It looks like 3/4 tests --lrbranches, which isn't
introduced until 4/4.

-Peff
