From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: Produce better output with --inline or
	--attach
Date: Thu, 31 Jul 2008 01:52:29 -0400
Message-ID: <20080731055229.GB17652@sigill.intra.peff.net>
References: <20080730052401.GC4034@sigill.intra.peff.net> <1217396973-82246-1-git-send-email-kevin@sb.org> <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de> <B805BDA1-6C22-4488-B5F5-6DA8CC729C06@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 07:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOR6R-0001jy-Mj
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 07:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYGaFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 01:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYGaFwb
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 01:52:31 -0400
Received: from peff.net ([208.65.91.99]:1625 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbYGaFwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 01:52:30 -0400
Received: (qmail 17464 invoked by uid 111); 31 Jul 2008 05:52:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 01:52:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 01:52:29 -0400
Content-Disposition: inline
In-Reply-To: <B805BDA1-6C22-4488-B5F5-6DA8CC729C06@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90893>

On Wed, Jul 30, 2008 at 11:30:32AM -0700, Kevin Ballard wrote:

>>> The second change is to always write the line termination character
>>> (default: newline) even when using --inline or --attach. This is  
>> It appears that your patch has one uncontroversial and one  
>> controversial
>> part, then.
> Is this controversial? Nobody's objected so far. My goal with this change 
> is to make the --inline output render exactly the same as the default 
> output in a mail client. I can't think of any downside.

No. I didn't comment on it in my earlier response because I don't really
care. But I certainly have no problem with it, and it is probably an
improvement.

-Peff
