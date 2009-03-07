From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] config --bool-or-int fixes
Date: Sat, 7 Mar 2009 12:16:40 -0500
Message-ID: <20090307171640.GA18398@coredump.intra.peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg0AF-0003Iw-IM
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZCGRQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbZCGRQw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:16:52 -0500
Received: from peff.net ([208.65.91.99]:44130 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbZCGRQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:16:51 -0500
Received: (qmail 16075 invoked by uid 107); 7 Mar 2009 17:16:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 12:16:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 12:16:40 -0500
Content-Disposition: inline
In-Reply-To: <1236446046-18319-1-git-send-email-peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112554>

On Sat, Mar 07, 2009 at 12:14:03PM -0500, Jeff King wrote:

> The interesting one is 2/3, which fixes a bogus usage message due to the
> recent parseopt conversion. The others are cleanups that I noticed while
> fixing it.
> 
> [PATCH 1/3] t1300: use test_must_fail as appropriate
> [PATCH 2/3] config: set help text for --bool-or-int
> [PATCH 3/3] document config --bool-or-int

I failed to mention, but it may have been obvious: these should go on
top of the fc/parseopt-config topic in next.

-Peff
