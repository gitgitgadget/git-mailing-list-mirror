From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] config --bool-or-int fixes
Date: Sat,  7 Mar 2009 12:14:03 -0500
Message-ID: <1236446046-18319-1-git-send-email-peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg081-0002Wv-PM
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbZCGROd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZCGROd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:14:33 -0500
Received: from peff.net ([208.65.91.99]:47626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbZCGROc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:14:32 -0500
Received: (qmail 15938 invoked by uid 107); 7 Mar 2009 17:14:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 12:14:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 12:14:21 -0500
X-Mailer: git-send-email 1.6.2.195.g44251.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112550>

The interesting one is 2/3, which fixes a bogus usage message due to the
recent parseopt conversion. The others are cleanups that I noticed while
fixing it.

[PATCH 1/3] t1300: use test_must_fail as appropriate
[PATCH 2/3] config: set help text for --bool-or-int
[PATCH 3/3] document config --bool-or-int
