From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Thu, 14 Feb 2008 09:03:29 -0500
Message-ID: <20080214140329.GA3549@coredump.intra.peff.net>
References: <20080214103256.GA17951@coredump.intra.peff.net> <alpine.LSU.1.00.0802141238140.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 15:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPehR-0005Sr-Aa
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 15:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYBNODq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYBNODq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 09:03:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4730 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbYBNODo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 09:03:44 -0500
Received: (qmail 6109 invoked by uid 111); 14 Feb 2008 14:03:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 09:03:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 09:03:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802141238140.30505@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73878>

On Thu, Feb 14, 2008 at 12:39:01PM +0000, Johannes Schindelin wrote:

> > We also hard-code the special ref '{}' as an alias for the empty tree. 
> > Users may refer to the empty tree by its sha1 or by '{}'.
> 
> Another idea just hit me: why not use "" (i.e. the empty string)?  It is 
> not a valid ref name, and not a valid filename either...
> 
> But maybe that would be _too_ cute,

IMHO, that is a bit too cute.

-Peff
