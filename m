From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] pack-bitmap progress meters
Date: Fri, 14 Mar 2014 22:25:51 -0400
Message-ID: <20140315022550.GA875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 03:26:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOeIQ-00059c-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 03:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbaCOCZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 22:25:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:39837 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754352AbaCOCZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 22:25:53 -0400
Received: (qmail 3824 invoked by uid 102); 15 Mar 2014 02:25:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 21:25:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 22:25:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244134>

Here are patches to make the pack-objects progress meters behave the
same both with and without pack reuse. The first one is basically the
patch I posted earlier.

The second one drops the "Reusing existing pack", and just rolls those
numbers into "Counting objects". I have mixed feelings on it. _I_ find
it interesting to know whether the pack was reused. But then I am often
debugging bitmaps and packfiles. :) From a regular user's perspective,
it is an implementation detail that may not be so interesting (git
should just magically be faster, and they do not have to care why).

So I dunno. Opinions welcome.

  [1/2]: pack-objects: show progress for reused packfiles
  [2/2]: pack-objects: show reused packfile objects in "Counting objects"

-Peff
