From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] test send-email --compose
Date: Sun, 24 Feb 2008 15:57:21 -0500
Message-ID: <20080224205720.GA7085@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 21:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTNv7-0005bP-U9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 21:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbYBXU5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYBXU5Z
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 15:57:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3065 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbYBXU5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 15:57:24 -0500
Received: (qmail 1788 invoked by uid 111); 24 Feb 2008 20:57:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 15:57:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 15:57:21 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74960>

This is a respun version of some tests from the freeze period. The bug
they test for was fixed, but these weren't accepted because there was a
modification to git-send-email.perl (a --no-confirm-send option) that we
didn't want during the freeze.

Not only are we now out of freeze, but we recently added a
GIT_SEND_EMAIL_NOTTY flag which accomplishes a similar goal for testing.
This version is updated to use that flag and drops the --no-confirm-send
option entirely.

-Peff
