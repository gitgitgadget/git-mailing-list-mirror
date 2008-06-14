From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] fix whitespace violations in test scripts
Date: Sat, 14 Jun 2008 03:01:30 -0400
Message-ID: <20080614070130.GA8968@sigill.intra.peff.net>
References: <20080614064857.GA8930@sigill.intra.peff.net> <20080614065119.GA9006@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7PmP-0001cJ-ED
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYFNHBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYFNHBe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:01:34 -0400
Received: from peff.net ([208.65.91.99]:4658 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYFNHBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:01:33 -0400
Received: (qmail 28586 invoked by uid 111); 14 Jun 2008 07:01:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 03:01:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 03:01:30 -0400
Content-Disposition: inline
In-Reply-To: <20080614065119.GA9006@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84970>

On Sat, Jun 14, 2008 at 02:51:19AM -0400, Jeff King wrote:

> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -5,7 +5,7 @@ test_description='test git rev-parse --parseopt'
>  
>  cat > expect.err <<EOF
>  usage: some-command [options] <args>...
> -    
> +
>      some-command does foo and bar!
>  
>      -h, --help            show the help

<sigh> I thought I had run all of the tests after this, but obviously I
screwed up. This is not a correct change.

I will send out a respun patch in a second.

-Peff
