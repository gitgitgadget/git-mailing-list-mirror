From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] silence clang-3.6 warnings
Date: Wed, 28 Jan 2015 12:53:14 -0500
Message-ID: <20150128175314.GA13362@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 21:40:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZPA-0003EG-R6
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbbA1UkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:40:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:42760 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757360AbbA1Uj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:39:58 -0500
Received: (qmail 32461 invoked by uid 102); 28 Jan 2015 17:53:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 11:53:17 -0600
Received: (qmail 10471 invoked by uid 107); 28 Jan 2015 17:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 12:53:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2015 12:53:14 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263113>

I was fooling around with clang-3.6 today (as opposed to 3.5, which is
the stock "clang" shipped with Debian), and noticed two new warnings.
The first one is a real bug, and the second is just a cleanup (though I
agree with clang on it).

  [1/2]: read_and_strip_branch: fix typo'd address-of operator
  [2/2]: do not check truth value of flex arrays

-Peff
