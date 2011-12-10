From: Jeff King <peff@peff.net>
Subject: [PATCHv3 0/13] credential helpers
Date: Sat, 10 Dec 2011 05:28:28 -0500
Message-ID: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKAs-000558-7u
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1LJK2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:28:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46994
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab1LJK2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:28:32 -0500
Received: (qmail 13770 invoked by uid 107); 10 Dec 2011 10:35:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:35:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:28:28 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186732>

Here's the latest re-roll of the credential helpers series. I think this
one is probably ready to go to 'next'.

It's rebased on the latest tip of 'master' (applying it to an older
commit will get you a minor textual conflict in strbuf.c). It
incorporates the erase-safety we discussed, fixes a few commit message
typos, and tweaks the test scripts to make testing the external OS X
helper a little easier.

  [01/13]: test-lib: add test_config_global variant
  [02/13]: t5550: fix typo
  [03/13]: introduce credentials API
  [04/13]: credential: add function for parsing url components
  [05/13]: http: use credential API to get passwords
  [06/13]: credential: apply helper config
  [07/13]: credential: add credential.*.username
  [08/13]: credential: make relevance of http path configurable
  [09/13]: docs: end-user documentation for the credential subsystem
  [10/13]: credentials: add "cache" helper
  [11/13]: strbuf: add strbuf_add*_urlencode
  [12/13]: credentials: add "store" helper
  [13/13]: t: add test harness for external credential helpers

-Peff
