From: Jeff King <peff@peff.net>
Subject: Re: Broken t9001 tests
Date: Thu, 2 Apr 2009 09:40:19 -0400
Message-ID: <20090402134019.GA26699@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0904021520200.7464@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 15:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNBF-0003Y4-Pg
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 15:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZDBNke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 09:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZDBNke
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 09:40:34 -0400
Received: from peff.net ([208.65.91.99]:48600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZDBNkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 09:40:33 -0400
Received: (qmail 26241 invoked by uid 107); 2 Apr 2009 13:40:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 02 Apr 2009 09:40:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2009 09:40:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904021520200.7464@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115465>

On Thu, Apr 02, 2009 at 03:22:33PM +0200, Johannes Schindelin wrote:

> only when I revert both dc1460a(send-email: ask_default should apply to 
> all emails, not just the first) and c18f75a(send-email: add tests for 
> refactored prompting) does my test suite pass without asking me 
> _interactively_ (twice, even) if I want to
> 
> 	Send this email? ([y]es|[n]o|[q]uit|[a]ll):
> 
> Please fix.

Try

  http://article.gmane.org/gmane.comp.version-control.git/115280

Junio seems to have picked up the first part of the series, but not this
fix. I'm not sure why.

-Peff
