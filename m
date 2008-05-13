From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] freebsd portability fixes
Date: Tue, 13 May 2008 04:43:39 -0400
Message-ID: <20080513084338.GA23729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 10:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvq7c-0007F0-N6
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758764AbYEMInm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758720AbYEMInm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:43:42 -0400
Received: from peff.net ([208.65.91.99]:1097 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758203AbYEMInl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:43:41 -0400
Received: (qmail 19716 invoked by uid 111); 13 May 2008 08:43:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 04:43:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 04:43:39 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82000>

I've been setting up auto-builders for a few platforms to try to catch
portability problems early. Unfortunately, it was made harder by the
fact that the _current_ test scripts don't pass on all platforms.

With these patches, I can successfully run all test scripts from the
current 'master' on FreeBSD 6.1 (some of them probably affect OS X, too
-- I recall somebody complaining about the '! foo | bar' construct
recently).

-Peff
