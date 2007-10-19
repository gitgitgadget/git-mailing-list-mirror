From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gc: improve wording of --auto notification
Date: Thu, 18 Oct 2007 21:26:08 -0400
Message-ID: <20071019012608.GA6403@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com> <47176AB9.7010409@midwinter.com> <20071019001648.GO14735@spearce.org> <20071019011211.GC3290@coredump.intra.peff.net> <20071019012430.GT14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iigd7-0000LG-HS
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763988AbXJSB0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763788AbXJSB0M
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:26:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4868 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763400AbXJSB0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:26:11 -0400
Received: (qmail 6134 invoked by uid 111); 19 Oct 2007 01:26:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 21:26:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 21:26:08 -0400
Content-Disposition: inline
In-Reply-To: <20071019012430.GT14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61592>

On Thu, Oct 18, 2007 at 09:24:30PM -0400, Shawn O. Pearce wrote:

> I think what you have is many times better.  It doesn't tell the
> user that they can prevent having this activate at the wrong time
> by just running git-gc every so often, but if the message (and
> the subsequent packing itself) is annoying they'll read the manual
> entry and hopefully figure that out on their own.

Yes, I tried many wordings of "this is annoying and you want to avoid
it," but explaining the situation takes way too much time for such a
commonly seen message. And I think some people will actually prefer it
that way.

BTW, the git-gc manpage needs some cleanup. Patches to follow.

-Peff
