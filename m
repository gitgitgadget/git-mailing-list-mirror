From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 07:28:42 -0500
Message-ID: <20080207122842.GA17184@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207110601.GA8488@coredump.intra.peff.net> <20080207121042.GA10210@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 13:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN5sV-0007aa-Op
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbYBGM2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769AbYBGM2q
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:28:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3191 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbYBGM2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:28:46 -0500
Received: (qmail 13130 invoked by uid 111); 7 Feb 2008 12:28:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 07 Feb 2008 07:28:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 07:28:42 -0500
Content-Disposition: inline
In-Reply-To: <20080207121042.GA10210@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72926>

On Thu, Feb 07, 2008 at 01:10:43PM +0100, Mike Hommey wrote:

> > It would be nice if we could generate a minimal test case that
> > demonstrates the problem, but I can't seem to reproduce it with a
> > smaller program. If we could, then we could probably get advice from
> > curl and/or gnutls people.
> 
> Did you try to run with the GIT_SSL_NO_VERIFY environment variable set ?

Yes (I even suggested this earlier in the thread). It returns a
different error from gnutls (see Anand's earlier response).

-Peff
