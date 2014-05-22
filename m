From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] tolower cleanups
Date: Thu, 22 May 2014 05:43:08 -0400
Message-ID: <20140522094251.GA14994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPX3-0006uX-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbaEVJnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:43:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:57267 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754138AbaEVJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:43:19 -0400
Received: (qmail 12855 invoked by uid 102); 22 May 2014 09:43:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:43:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:43:08 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249894>

These two patches were pulled from the http charset series I posted
nearby. The second iteration of that series did not need them, but they
may have value as cleanups.

  [1/2]: daemon/config: factor out duplicate xstrdup_tolower
  [2/2]: strbuf: add strbuf_tolower function

The first one is a real reduction of code. The second is just making
code public that _might_ get used later, so it's a bit less exciting.
Both are independent of each other, so we can take or leave them
separately.
