From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: make all test files executable
Date: Fri, 2 Oct 2009 04:01:34 -0400
Message-ID: <20091002080134.GD27664@coredump.intra.peff.net>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtd5R-0001P0-KT
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbZJBIBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZJBIBi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:01:38 -0400
Received: from peff.net ([208.65.91.99]:38858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbZJBIBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:01:37 -0400
Received: (qmail 26438 invoked by uid 107); 2 Oct 2009 08:05:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 04:05:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 04:01:34 -0400
Content-Disposition: inline
In-Reply-To: <4AC55E78.7010109@mailservices.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129428>

On Thu, Oct 01, 2009 at 09:59:20PM -0400, Mark Rada wrote:

> For consistency with the rest of the test files.

Thanks. Interestingly, though, I think this may be triggering a bug in
git-am:

>  0 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 t/t5531-deep-submodule-push.sh
>  mode change 100644 => 100755 t/t9501-gitweb-standalone-http-status.sh
> 
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> old mode 100644
> new mode 100755
> diff --git a/t/t9501-gitweb-standalone-http-status.sh
> b/t/t9501-gitweb-standalone-http-status.sh
> old mode 100644
> new mode 100755

When applying via "am", I only got the first change in my tree. I'll see
if I can confirm and make a test case.

-Peff
