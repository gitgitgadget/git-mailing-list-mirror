From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 23:18:03 -0500
Message-ID: <20071115041801.GA9794@sigill.intra.peff.net>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <7vmythr8xf.fsf@gitster.siamese.dyndns.org> <20071114071929.GA2942@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWBP-0006QP-JU
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbXKOESL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbXKOESK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:18:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4393 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbXKOESJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:18:09 -0500
Received: (qmail 5843 invoked by uid 111); 15 Nov 2007 04:18:06 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 Nov 2007 23:18:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:18:03 -0500
Content-Disposition: inline
In-Reply-To: <20071114071929.GA2942@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65050>

On Wed, Nov 14, 2007 at 08:19:29AM +0100, Alex Riesen wrote:

> Well, it is kind of undefined. git push just updated some remote
> references and failed on the others. It has had some failures, so it
> returns non-0. And as I said, it really is not about the operation,
> but about if the tracking and remote branches are set as we want them.

My goal with the recent patches is that _any_ failure will cause a non-0
exit code (but you have to read the stderr output to find out which, if
any, refs were successful).

-Peff
