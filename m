From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Mon, 23 Mar 2009 10:03:02 -0400
Message-ID: <20090323140302.GA11005@coredump.intra.peff.net>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca> <20090323065710.GA7048@coredump.intra.peff.net> <1237812904-sup-3864@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llkms-0004ra-2o
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635AbZCWODL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757352AbZCWODK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:03:10 -0400
Received: from peff.net ([208.65.91.99]:54880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbZCWODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:03:09 -0400
Received: (qmail 21389 invoked by uid 107); 23 Mar 2009 14:03:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 10:03:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 10:03:02 -0400
Content-Disposition: inline
In-Reply-To: <1237812904-sup-3864@ntdws12.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114305>

On Mon, Mar 23, 2009 at 08:57:27AM -0400, Ben Walton wrote:

> That's a fair point.  I've been lugging this around for a bit in the
> build tree I use, so I don't recall specifically what was breaking.
> The sh in question is the one found in solaris 8.  When I get a few
> mintues, I'll build without the patch to see what the problem was...

I wouldn't worry about it. The /bin/sh on Solaris 8 is pretty hopelessly
broken for our use. At the very least it doesn't understand $()
subsititution.

-Peff
