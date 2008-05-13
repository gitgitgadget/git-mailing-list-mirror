From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] freebsd portability fixes
Date: Tue, 13 May 2008 05:04:24 -0400
Message-ID: <20080513090424.GA26181@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 11:06:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvqRh-0005VG-BS
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbYEMJE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbYEMJE1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:04:27 -0400
Received: from peff.net ([208.65.91.99]:2809 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338AbYEMJE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:04:26 -0400
Received: (qmail 21103 invoked by uid 111); 13 May 2008 09:04:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 05:04:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 05:04:24 -0400
Content-Disposition: inline
In-Reply-To: <20080513084338.GA23729@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82005>

On Tue, May 13, 2008 at 04:43:39AM -0400, Jeff King wrote:

> With these patches, I can successfully run all test scripts from the
> current 'master' on FreeBSD 6.1 (some of them probably affect OS X, too
> -- I recall somebody complaining about the '! foo | bar' construct
> recently).

Ah, nevermind about OS X. It was 97ad535b from Alex, and he specifically
mentioned FreeBSD 4.

Alex, you might want to try re-running the tests with these patches.

-Peff
