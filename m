From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Tue, 2 Jun 2009 09:57:52 -0400
Message-ID: <20090602135751.GA5594@coredump.intra.peff.net>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> <7v7i0btdwu.fsf@alter.siamese.dyndns.org> <20090521041812.GE8091@sigill.intra.peff.net> <4A159720.3020103@intra2net.com> <20090522075620.GC1409@coredump.intra.peff.net> <20090522080258.GD1409@coredump.intra.peff.net> <20090602195605.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Jarosch <thomas.jarosch@intra2net.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBUVD-0003L1-Hw
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 15:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbZFBN57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 09:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbZFBN56
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 09:57:58 -0400
Received: from peff.net ([208.65.91.99]:50662 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbZFBN55 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 09:57:57 -0400
Received: (qmail 13802 invoked by uid 107); 2 Jun 2009 13:58:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 02 Jun 2009 09:58:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2009 09:57:52 -0400
Content-Disposition: inline
In-Reply-To: <20090602195605.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120512>

On Tue, Jun 02, 2009 at 07:56:05PM +0900, Nanako Shiraishi wrote:

> > And here is the strbuf_readlink version, which actually does make the
> > source shorter and easier to read.
> 
> Junio, may I ask what happened to this patch?

I think it's now 3cd7388.

-Peff
