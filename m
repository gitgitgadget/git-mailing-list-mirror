From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t5570: Update for clone-progress-to-stderr branch
Date: Mon, 21 Oct 2013 14:41:54 -0400
Message-ID: <20131021184154.GA29681@sigill.intra.peff.net>
References: <1382378052-89929-1-git-send-email-brian@gernhardtsoftware.com>
 <1382378052-89929-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 20:42:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYKQV-0001Rd-CP
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 20:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab3JUSl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 14:41:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:53131 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751662Ab3JUSl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 14:41:59 -0400
Received: (qmail 26115 invoked by uid 102); 21 Oct 2013 18:41:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Oct 2013 13:41:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Oct 2013 14:41:54 -0400
Content-Disposition: inline
In-Reply-To: <1382378052-89929-2-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236441>

On Mon, Oct 21, 2013 at 01:54:12PM -0400, Brian Gernhardt wrote:

> git clone now reports its progress to standard error, which throws off
> t5570.  Using test_i18ngrep instead of test_cmp allows the test to be
> more flexible by only looking for the expected error and ignoring any
> other output from the program.

Thanks, this is due to my 68b939b. I dealt with the fallout elsewhere in
the test suite, but I did not run with GIT_TEST_GIT_DAEMON set (and I do
not think Junio does, either). I'll start doing so.

I already have GIT_TEST_HTTPD set, and after a quick grep I don't think
I am missing any others (I do skip the svn, cvs, and p4 tests, though,
as I do not have them installed).

-Peff
