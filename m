From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/4] commit test: Use write_script
Date: Fri, 13 Jun 2014 19:28:42 -0400
Message-ID: <20140613232841.GC23078@sigill>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-3-git-send-email-caleb@calebthompson.io>
 <20140613065037.GA7908@sigill.intra.peff.net>
 <20140613162607.GA85151@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:28:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvatu-0000xe-9e
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 01:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbaFMX2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 19:28:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:43888 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754052AbaFMX2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 19:28:46 -0400
Received: (qmail 1454 invoked by uid 102); 13 Jun 2014 23:28:46 -0000
Received: from mobile-166-198-031-023.mycingular.net (HELO sigill.intra.peff.net) (166.198.31.23)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 18:28:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:28:42 -0400
Content-Disposition: inline
In-Reply-To: <20140613162607.GA85151@sirius.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251651>

On Fri, Jun 13, 2014 at 11:26:07AM -0500, Caleb Thompson wrote:

> You're very right - I may have confused this commit message and the one
> to switch to test_set_editor. I'll rewrite this commit message.
> 
> What do you think of something like this for the description:
> 
>     Use write_script from t/test-lib-functions.sh instead of cat,
>     shebang, and chmod. This aids in readability for creating the script
>     by using the named function and allows us to turn off interpolation
>     in the heredoc of the script body to avoid extra escaping, since
>     $SHELL_PATH is handled for us.

That looks fine to me. Thanks.

-Peff
