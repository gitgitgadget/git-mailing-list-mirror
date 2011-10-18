From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] stupid git tricks
Date: Tue, 18 Oct 2011 00:49:55 -0400
Message-ID: <20111018044955.GA8976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 06:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG1cr-0001gw-IT
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 06:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab1JREt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 00:49:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34185
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab1JREt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 00:49:58 -0400
Received: (qmail 16056 invoked by uid 107); 18 Oct 2011 04:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Oct 2011 00:50:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2011 00:49:55 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183850>

Here are a few contrib tidbits that I find invaluable when working with
git. They're pretty simple ideas, but I've been using them all for
at least a year[1], and they've made my life more pleasant and
productive. So I thought I'd share.

  [1/3]: contrib: add diff highlight script
  [2/3]: contrib: add git-jump script
  [3/3]: completion: match ctags symbol names in grep patterns

-Peff

[1] Actually, they all needed significant cleanup for me not to be
    embarrassed to share them, which I just did recently. Undoubtedly I
    introduced scores of new bugs during the cleanup, so take my "at
    least a year" with a grain of salt. The _concepts_ have been proven,
    at least. :)
