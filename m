From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 17:51:27 -0400
Message-ID: <20090830215127.GA16303@coredump.intra.peff.net>
References: <20090830093642.GA30922@coredump.intra.peff.net>
 <20090830214309.GA16119@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhsJF-0005e0-P6
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbZH3Vv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZH3Vv2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:51:28 -0400
Received: from peff.net ([208.65.91.99]:50106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbZH3Vv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:51:28 -0400
Received: (qmail 19403 invoked by uid 107); 30 Aug 2009 21:51:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 17:51:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 17:51:27 -0400
Content-Disposition: inline
In-Reply-To: <20090830214309.GA16119@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127438>

On Sun, Aug 30, 2009 at 05:43:09PM -0400, Jeff King wrote:

> From: Alex Riesen <raa.lkml@gmail.com>
> 
> The main purpose is to allow predictable testing of the code.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Bleh. I just started working on a 4/3 that would test Linus' recent
approxidate changes, but then I realized that this massive date.c
refactoring conflicts with his changes.

I think the most sane thing is to rebase the whole series on top of
lt/approxidate. Let me see what I can do.

-Peff
