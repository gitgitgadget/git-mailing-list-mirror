From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 11:24:58 -0400
Message-ID: <20070515152457.GC6794@fieldses.org>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org> <20070515050808.GA11745@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 17:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnyty-0004B2-Jx
	for gcvg-git@gmane.org; Tue, 15 May 2007 17:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbXEOPZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 11:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756525AbXEOPZB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 11:25:01 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47265 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925AbXEOPZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 11:25:00 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HnytW-0002HS-1t; Tue, 15 May 2007 11:24:58 -0400
Content-Disposition: inline
In-Reply-To: <20070515050808.GA11745@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47348>

On Tue, May 15, 2007 at 01:08:08AM -0400, Jeff King wrote:
> However, the content-type is already specified, so it shouldn't need to
> rewrite. However, I notice that your original message is missing a
> MIME-Version: 1.0 header. My guess is that vger's logic is that without
> that header, it can't trust the Content-Type you have provided (and
> indeed, not including MIME-Version violates the MIME RFCs, I believe).
> 
> I assumed this was a bug in git-send-email, but looking closer, it
> doesn't put in any mime information at all! So your sending smtp server
> is adding in the content-type header,

Nope...

> but it's failing to add the
> MIME-Version header, which I think is a bug (I can dig up the RFC
> reference if you want).
> 
> Arguably, git should be generating the full MIME header-set, since it
> knows what actual encoding the message is in.

... Yes.  But actually, the Content-Type header is from
git-format-patch:

$ git format-patch --stdout 12806b^..12806b |head
From 12806b65b0d1faec249002c51b871775dc344a47 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Thu, 10 May 2007 12:36:15 +0200
Subject: [PATCH] Add a birdview-on-the-source-code section to the user
manual
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

In http://thread.gmane.org/gmane.comp.version-control.git/42479,
a birdview on the source code was requested.

So it's a git-format-patch bug?

--b.
