From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] rev-list: add an option to mark fewer edges as
 uninteresting
Date: Tue, 23 Dec 2014 13:51:42 -0500
Message-ID: <20141223185142.GA27954@peff.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
 <1419336082-283091-3-git-send-email-sandals@crustytoothpaste.net>
 <CAO2U3Qjbmz+fP-SLSeq1S+BDi4PSTSLf_TdqW-ik8GLV7=nUmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UYd-0002H6-FF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507AbaLWSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:51:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:56740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752438AbaLWSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:51:43 -0500
Received: (qmail 6923 invoked by uid 102); 23 Dec 2014 18:51:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 12:51:42 -0600
Received: (qmail 23054 invoked by uid 107); 23 Dec 2014 18:51:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 13:51:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 13:51:42 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3Qjbmz+fP-SLSeq1S+BDi4PSTSLf_TdqW-ik8GLV7=nUmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261764>

On Tue, Dec 23, 2014 at 12:55:48PM -0500, Michael Blume wrote:

> This patch causes an error on my mac, test 5500 fetch-pack errors on
> part 44 - fetch creating new shallow root. It looks for "remote: Total
> 1" in the fetch output and gets 3 instead.

It fails for me on Linux, too. Interestingly the tip of the series
passes. I didn't investigate further.

-Peff
