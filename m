From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/16] tr portability fixes
Date: Thu, 13 Mar 2008 09:06:25 -0400
Message-ID: <20080313130625.GH19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312212957.GB26286@coredump.intra.peff.net> <47D8D895.4030309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZn9s-00046P-4O
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439AbYCMNGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbYCMNG3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:06:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1459 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756629AbYCMNG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:06:28 -0400
Received: (qmail 30626 invoked by uid 111); 13 Mar 2008 13:06:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 09:06:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 09:06:25 -0400
Content-Disposition: inline
In-Reply-To: <47D8D895.4030309@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77076>

On Thu, Mar 13, 2008 at 08:32:37AM +0100, Johannes Sixt wrote:

> > However, this doesn't work with multiple sequences, like:
> > 
> >   # rot13
> >   tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'
> 
> Not that it matters a lot, but I wonder whether
> 
>    tr '[A-M][N-Z][a-m][n-z]' '[N-Z][A-M][n-z][a-m]'
> 
> would have done the trick.

For the record, it does on Solaris (and I really can't imagine it _not_
working anywhere else, but then I couldn't imagine my example not
working, either. ;) ).

-Peff
