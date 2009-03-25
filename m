From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git
	repository
Date: Wed, 25 Mar 2009 00:23:43 -0400
Message-ID: <20090325042343.GA15498@coredump.intra.peff.net>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302> <49C8E074.4030808@gmail.com> <20090324135906.GA10644@coredump.intra.peff.net> <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com> <d9c1caea0903240933n6dea7ddcl90a5e105c2a45b52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Roel Kluin <roel.kluin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKg9-0006MQ-96
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbZCYEXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZCYEXx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:23:53 -0400
Received: from peff.net ([208.65.91.99]:45731 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZCYEXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:23:53 -0400
Received: (qmail 3127 invoked by uid 107); 25 Mar 2009 04:24:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 00:24:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 00:23:43 -0400
Content-Disposition: inline
In-Reply-To: <d9c1caea0903240933n6dea7ddcl90a5e105c2a45b52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114559>

On Tue, Mar 24, 2009 at 04:33:13PM +0000, Steven Tweed wrote:

> Speaking of wanting things to work with the actual repository , one
> thing that I've been meaning to continue work on if I get the time is
> basically a 'show me any commit diff's that involve string s' (ie, the
> locations in which a change involving s occurs rather than just
> 'current file contains s (in exactly the same ways the previous
> version did). I'm extremely unlikely to actually produce anything

How about "git log -S", or does that somehow not meet your needs (and if
not, how)?

-Peff
