From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase--interactive: Replace unportable 'tac' by a sed
	script.
Date: Mon, 28 Apr 2008 05:04:17 -0400
Message-ID: <20080428090417.GB16153@sigill.intra.peff.net>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <48158070.7090007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:09:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPIg-0007OH-Ei
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYD1JEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYD1JEV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:04:21 -0400
Received: from peff.net ([208.65.91.99]:1677 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629AbYD1JEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:04:20 -0400
Received: (qmail 2928 invoked by uid 111); 28 Apr 2008 09:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Apr 2008 05:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2008 05:04:17 -0400
Content-Disposition: inline
In-Reply-To: <48158070.7090007@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80510>

On Mon, Apr 28, 2008 at 09:44:48AM +0200, Johannes Sixt wrote:

>> +    perl -e 'print reverse <>' | \
> [...]
> +	sed -ne '1!G;$p;h' | \

Wow, and people complain about perl being unreadable. ;)

-Peff
