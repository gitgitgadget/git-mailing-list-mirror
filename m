From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 03:22:03 -0400
Message-ID: <20080329072203.GA17625@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <20080328212900.GB9656@coredump.intra.peff.net> <200803290819.07280.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 08:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfVOt-0004y0-AA
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 08:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbYC2HWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYC2HWI
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 03:22:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1742 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbYC2HWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 03:22:07 -0400
Received: (qmail 14100 invoked by uid 111); 29 Mar 2008 07:22:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 03:22:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 03:22:03 -0400
Content-Disposition: inline
In-Reply-To: <200803290819.07280.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78450>

On Sat, Mar 29, 2008 at 08:19:07AM +0100, Robin Rosenberg wrote:

> Den Friday 28 March 2008 22.29.01 skrev Jeff King:
> > We always use 'utf-8' as the encoding, since we currently
> > have no way of getting the information from the user.
> 
> Don't set encoding to UTF-8 unless it actually looks like UTF-8.

OK. Do you have an example function that guesses with high probability
whether a string is utf-8? If there are non-ascii characters but we
_don't_ guess utf-8, what should we do?

-Peff
