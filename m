From: Jeff King <peff@peff.net>
Subject: Re: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 10:09:29 -0400
Message-ID: <20071030140929.GA22101@coredump.intra.peff.net>
References: <20071030095338.GZ6372@mea-ext.zmailer.org> <20071030140630.GC21342@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imrn2-000139-H1
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 15:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbXJ3OJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXJ3OJc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 10:09:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3772 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbXJ3OJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 10:09:32 -0400
Received: (qmail 924 invoked by uid 111); 30 Oct 2007 14:09:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 10:09:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 10:09:29 -0400
Content-Disposition: inline
In-Reply-To: <20071030140630.GC21342@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2007 at 10:06:30AM -0400, Jeff King wrote:

> > What would be a problem ?   Some of us have names that are encoded
> > in 8-bit form,  and some receiving systems get all mighty upset when
> > they receive unlabelled email carry 8-bit encoded texts.
> > (Thanks to chinese and russian spammers..)
> 
> Then git-send-email should be generating the MIME headers if there are
> 8-bit characters. Can you produce a test case where the most recent
> version of git-send-email it does not?

Actually, btw, the code in question is from git-format-patch (it's just
that git-send-email doesn't add _any_ mime headers, as it assumes
git-format-patch either did it already, or none are needed).

-Peff
