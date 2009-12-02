From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Document date formats accepted by parse_date()
Date: Wed, 2 Dec 2009 17:42:06 -0500
Message-ID: <20091202224206.GC9691@coredump.intra.peff.net>
References: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
 <831fc8f48429d5a21e29d04760b46b2ddfcb7d80.1259791789.git.vmiklos@frugalware.org>
 <20091203073313.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:42:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxu3-0005M6-Nh
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbZLBWmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbZLBWl7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:41:59 -0500
Received: from peff.net ([208.65.91.99]:49648 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618AbZLBWl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:41:59 -0500
Received: (qmail 28423 invoked by uid 107); 2 Dec 2009 22:46:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 17:46:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 17:42:06 -0500
Content-Disposition: inline
In-Reply-To: <20091203073313.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134414>

On Thu, Dec 03, 2009 at 07:33:13AM +0900, Nanako Shiraishi wrote:

> Is there something wrong with 'show'?
> 
>   nana.git% ./test-date show '2005-04-07T22:13:13'
>   2005-04-07T22:13:13 -> 40 years ago

No. It doesn't call parse_date, but instead accepts a time_t-like
"seconds since epoch". I intentionally didn't use parse_date because I
didn't want bugs in parse_date to affect 'show' output, to keep testing
simple.

-Peff
