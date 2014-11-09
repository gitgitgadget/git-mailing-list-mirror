From: Jeff King <peff@peff.net>
Subject: Re: Test failure
Date: Sat, 8 Nov 2014 20:43:54 -0500
Message-ID: <20141109014354.GA23883@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 02:44:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnHXv-0003MY-RV
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 02:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaKIBn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 20:43:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:38107 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750957AbaKIBn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 20:43:58 -0500
Received: (qmail 7345 invoked by uid 102); 9 Nov 2014 01:43:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 19:43:58 -0600
Received: (qmail 13281 invoked by uid 107); 9 Nov 2014 01:44:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 20:44:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 20:43:54 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 11:28:32AM -0800, Michael Blume wrote:

> When I build and run tests I get
> 
> [11:17][michael.blume@tcc-michael-4:~/workspace/git/t(master)]$
> ./t1410-reflog.sh

What does "./t1410-reflog.sh -v -i" report?

> A quick search seems to indicate the test is pretty new?
> http://www.mail-archive.com/git@vger.kernel.org/msg60495.html

Yes, it is new. In these cases there's often some silly little
platform incompatibility in the test script, but I don't see one. So
maybe the incompatibility is in the code itself; I'm wondering if
OS X returns something besides EISDIR when trying to open a directory.

Unfortunately I don't have an OS X install handy to test on.

-Peff
