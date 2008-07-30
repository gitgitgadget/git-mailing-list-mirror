From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 01:07:16 -0400
Message-ID: <20080730050715.GA4034@sigill.intra.peff.net>
References: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk> <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3vL-0006rz-5J
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYG3FHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYG3FHT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:07:19 -0400
Received: from peff.net ([208.65.91.99]:1455 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbYG3FHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:07:18 -0400
Received: (qmail 5143 invoked by uid 111); 30 Jul 2008 05:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 01:07:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 01:07:16 -0400
Content-Disposition: inline
In-Reply-To: <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90740>

On Tue, Jul 29, 2008 at 10:12:22PM +0200, Anders Melchiorsen wrote:

>  			"# Please enter the commit message for your changes.\n"
> +			"# To abort the commit, use an empty commit message.\n"
>  			"# (Comment lines starting with '#' will ");

I think this is a good thing to mention, but this text has been getting
longer lately. Maybe we can compact it like this:

  # Please enter the commit message for your changes. Lines starting
  # with '#' will be ignored, and an empty message aborts the commit.

?

> -		die("no commit message?  aborting commit.");
> +		die("no commit message.  aborting commit.");

I don't think the change of punctuation makes a big difference here,
but this could probably stand to be reworded. Maybe:

  Aborting commit due to empty commit message.

-Peff
