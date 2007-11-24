From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add config_int() method to the Git perl module
Date: Sat, 24 Nov 2007 06:48:40 -0500
Message-ID: <20071124114839.GC17861@sigill.intra.peff.net>
References: <200711231904.53551.jnareb@gmail.com> <7vabp4u40y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Dan Zwell <dzwell@zwell.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 12:49:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvtVR-0000Nd-G8
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 12:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbXKXLsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 06:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbXKXLsp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 06:48:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2621 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbXKXLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 06:48:45 -0500
Received: (qmail 7967 invoked by uid 111); 24 Nov 2007 11:48:41 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 24 Nov 2007 06:48:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2007 06:48:40 -0500
Content-Disposition: inline
In-Reply-To: <7vabp4u40y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65945>

On Fri, Nov 23, 2007 at 11:59:25AM -0800, Junio C Hamano wrote:

> Maybe in a similar way, we might want to add --color to "git
> config" to return ANSI sequence, so that Git::config_color() can
> work without even loading Term::ANSIColor?

We would also need a way of parsing the 'default' values, so git-config
would need a way of saying "turn this value into its internal
representation" (or the perl script would have to specify its defaults
as raw ANSI codes, which is a bit ugly, but is that the C programs do).

-Peff
