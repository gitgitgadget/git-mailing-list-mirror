From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Thu, 8 Nov 2007 22:31:36 -0500
Message-ID: <20071109033136.GB31760@sigill.intra.peff.net>
References: <4733AEA0.1060602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:32:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqKbC-0002a2-P9
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 04:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339AbXKIDbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 22:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757889AbXKIDbr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 22:31:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3308 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943AbXKIDbq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 22:31:46 -0500
Received: (qmail 20514 invoked by uid 111); 9 Nov 2007 03:31:43 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 22:31:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 22:31:36 -0500
Content-Disposition: inline
In-Reply-To: <4733AEA0.1060602@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64124>

On Fri, Nov 09, 2007 at 01:49:36AM +0100, Ren=E9 Scharfe wrote:

> As suggested by Pierre Habouzit, add strchrnul().  It's a useful GNU
> extension and can simplify string parser code.  There are several
> places in git that can be converted to strchrnul(); as a trivial
> example, this patch introduces its usage to builtin-fetch--tool.c.

Minor nit: a comment (in the code or even in the commit message)
describing the what the function does would be nice. On a GNU system,
one can look at the man page, but on others there is no indication of
what it does except for reading the code (and maybe the answer is "this
is a common library function, you idiot", but I am familiar with many
GNU extensions and didn't know this one).

-Peff
