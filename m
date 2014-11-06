From: Jeff King <peff@peff.net>
Subject: [PATCH] docs/credential-store: s/--store/--file/
Date: Thu, 6 Nov 2014 02:40:32 -0500
Message-ID: <20141106074032.GA25359@peff.net>
References: <E3D4929B4BF48B439B609986B0C719EA25896EBB@HDXDSP52.us.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Hopkins, Jesse" <jesse.hopkins@lmco.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 08:40:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmHgZ-0000wA-MV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 08:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbaKFHks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 02:40:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:37193 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbaKFHkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 02:40:47 -0500
Received: (qmail 29254 invoked by uid 102); 6 Nov 2014 07:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 01:40:33 -0600
Received: (qmail 435 invoked by uid 107); 6 Nov 2014 07:40:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 02:40:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2014 02:40:32 -0500
Content-Disposition: inline
In-Reply-To: <E3D4929B4BF48B439B609986B0C719EA25896EBB@HDXDSP52.us.lmco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 05:14:56PM +0000, Hopkins, Jesse wrote:

> The man page for git-credential-store at
> http://git-scm.com/docs/git-credential-store
> and
> https://www.kernel.org/pub/software/scm/git/docs/git-credential-store.html
> 
> incorrectly state that the option to change the credential storage
> path is '--store'.  The name of the option should be '--file'. I have
> noticed this running it 1.8.5.3

Thanks. Here's a fix.

-- >8 --
The option name "--store" was used early in development, but
never even made it into an applied patch, let alone a
released version of git. I forgot to update the matching
documentation at the time, though.

Noticed-by: Jesse Hopkins <jesse.hopkins@lmco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-credential-store.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 8481cae..bc97071 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -29,7 +29,7 @@ linkgit:gitcredentials[7] or `EXAMPLES` below.
 OPTIONS
 -------
 
---store=<path>::
+--file=<path>::
 
 	Use `<path>` to store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
-- 
2.1.2.596.g7379948
