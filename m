From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 12:07:34 -0500
Message-ID: <20101213170734.GA24736@sigill.intra.peff.net>
References: <4D05F1EA.9000403@viscovery.net>
 <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 18:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBsE-0005qz-E4
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 18:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab0LMRHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 12:07:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab0LMRHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 12:07:37 -0500
Received: (qmail 8981 invoked by uid 111); 13 Dec 2010 17:07:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 13 Dec 2010 17:07:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Dec 2010 12:07:34 -0500
Content-Disposition: inline
In-Reply-To: <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163567>

On Mon, Dec 13, 2010 at 05:12:29PM +0100, Michael J Gruber wrote:

> On a related note to J6t's patch, how's the stance on unique titles?
> Unique numbers are important for partial test runs, of course,
> but unique titles help finding you way through the test.
> There are more than the blame.sh ones.

I don't think it is a big deal, but I did just 5 minutes ago get annoyed
at:

  t7500-commit.sh
  t7501-commit.sh
  t7502-commit.sh
  t7509-commit.sh

Speaking of minor test issues, we should probably also do this:

-- >8 --
Subject: [PATCH] tests: flip executable bit on t9158

All tests are supposed to be executable.

Signed-off-by: Jeff King <peff@peff.net>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t9158-git-svn-mergeinfo.sh

diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
old mode 100644
new mode 100755
-- 
1.7.3.3.784.gccc31.dirty
