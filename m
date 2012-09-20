From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] smart http toggle switch fails"
Date: Thu, 20 Sep 2012 12:59:38 -0400
Message-ID: <20120920165938.GB18655@sigill.intra.peff.net>
References: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <1348120680-24788-1-git-send-email-spearce@spearce.org>
 <7vlig5cilt.fsf@alter.siamese.dyndns.org>
 <20120920162456.GA25418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:59:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEk6P-0000Up-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab2ITQ7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:59:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51561 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab2ITQ7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:59:40 -0400
Received: (qmail 17568 invoked by uid 107); 20 Sep 2012 17:00:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 13:00:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 12:59:38 -0400
Content-Disposition: inline
In-Reply-To: <20120920162456.GA25418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206057>

On Thu, Sep 20, 2012 at 12:24:56PM -0400, Jeff King wrote:

> I think Shawn's revert is the right thing to do. But it is not complete
> without the manual workaround. I'm putting that patch together now and
> should have it out in a few minutes.

And here it is. This goes on top of Shawn's revert patch (it might be
nice to mention the commit id of that in the commit message of the
second patch. I couldn't do so because it is not yet in your repo).

  [1/2]: remote-curl: rename is_http variable
  [2/2]: remote-curl: let users turn off smart http

-Peff
