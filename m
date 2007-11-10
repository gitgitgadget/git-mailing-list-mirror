From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 9 Nov 2007 19:49:33 -0500
Message-ID: <20071110004932.GB14992@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <Pine.LNX.4.64.0711100030090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeXs-0008T1-Bq
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbXKJAtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbXKJAtl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:49:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2458 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbXKJAtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:49:41 -0500
Received: (qmail 20671 invoked by uid 111); 10 Nov 2007 00:49:38 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 Nov 2007 19:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2007 19:49:33 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711100030090.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64290>

On Sat, Nov 10, 2007 at 12:31:41AM +0000, Johannes Schindelin wrote:

> If you keep going like that, "git log" will be slower than "git log 
> --pretty=format:bla" soon.

Maybe I am dreaming, but the code might be much simpler and more
readable if --pretty=* were implemented in terms of --pretty=format,
assuming the speeds are equivalent.

-Peff
