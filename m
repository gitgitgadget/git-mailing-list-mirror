From: Jeff King <peff@peff.net>
Subject: [PATCH v3 0/14] implement @{push} shorthand
Date: Thu, 21 May 2015 00:44:29 -0400
Message-ID: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvILU-0007tT-U4
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbbEUEoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:44:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:33658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751111AbbEUEoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:44:32 -0400
Received: (qmail 2222 invoked by uid 102); 21 May 2015 04:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:44:32 -0500
Received: (qmail 31094 invoked by uid 107); 21 May 2015 04:44:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:44:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:44:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269541>

This is a re-roll of the series at:

  http://thread.gmane.org/gmane.comp.version-control.git/268185

The only changes here are the addition of patches 2 and 6, which are
both cleanups that help make the other patches more readable/sensible.
They are the same as what was posted during review of the thread linked
above.  So there's nothing new here, but of course fresh reviews are
welcome.

  [01/14]: remote.c: drop default_remote_name variable
  [02/14]: remote.c: refactor setup of branch->merge list
  [03/14]: remote.c: drop "remote" pointer from "struct branch"
  [04/14]: remote.c: hoist branch.*.remote lookup out of remote_get_1
  [05/14]: remote.c: provide per-branch pushremote name
  [06/14]: remote.c: hoist read_config into remote_get_1
  [07/14]: remote.c: introduce branch_get_upstream helper
  [08/14]: remote.c: report specific errors from branch_get_upstream
  [09/14]: remote.c: add branch_get_push
  [10/14]: sha1_name: refactor upstream_mark
  [11/14]: sha1_name: refactor interpret_upstream_mark
  [12/14]: sha1_name: implement @{push} shorthand
  [13/14]: for-each-ref: use skip_prefix instead of starts_with
  [14/14]: for-each-ref: accept "%(push)" format

-Peff
