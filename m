From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Wed, 5 Nov 2008 17:44:51 -0500
Message-ID: <20081105224450.GA20440@coredump.intra.peff.net>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <20081104085630.GA22530@localhost> <20081105024932.GA20907@coredump.intra.peff.net> <20081105202849.GA9484@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:46:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxr8a-0004Vo-0M
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbYKEWox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYKEWox
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:44:53 -0500
Received: from peff.net ([208.65.91.99]:1728 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYKEWox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:44:53 -0500
Received: (qmail 17139 invoked by uid 111); 5 Nov 2008 22:44:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Nov 2008 17:44:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Nov 2008 17:44:51 -0500
Content-Disposition: inline
In-Reply-To: <20081105202849.GA9484@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100197>

On Wed, Nov 05, 2008 at 09:28:49PM +0100, Clemens Buchacher wrote:

> The reason it doesn't work is a bug in lock_ref_sha1_basic(). Dating back to
> pre-"pack-refs" times, this code forces a write if the ref file does not
> exist. I will resubmit the patch including your above testcase and a bugfix
> for lock_ref_sha1_basic().

OK, thanks for looking into it further. Both patches look sane to me.

-Peff
