From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix ls-files parseopt regression
Date: Sat, 7 Mar 2009 20:20:50 -0500
Message-ID: <20090308012049.GA18616@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:24:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7l6-0001mL-S2
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCHBVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZCHBVE
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:21:04 -0500
Received: from peff.net ([208.65.91.99]:53696 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbZCHBVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:21:03 -0500
Received: (qmail 18458 invoked by uid 107); 8 Mar 2009 01:21:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 20:21:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 20:20:50 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112603>

These patches are on top of the mv/parseopt-ls-files topic in next. The
first is a related cleanup, the second is the fix.

 1/2: t3000: use test_cmp instead of diff
 2/2: ls-files: fix broken --no-empty-directory

-Peff
