From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Colorize 'commit' lines in log ui
Date: Sun, 23 Jul 2006 18:01:33 -0400
Message-ID: <20060723220133.GA26390@coredump.intra.peff.net>
References: <20060723092417.GA7547@coredump.intra.peff.net> <20060723112422.GB27825@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 24 00:01:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4m17-0001Q1-30
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 00:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGWWBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWGWWBf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 18:01:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:59350 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750719AbWGWWBf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 18:01:35 -0400
Received: (qmail 18648 invoked from network); 23 Jul 2006 18:01:09 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jul 2006 18:01:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jul 2006 18:01:33 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060723112422.GB27825@lug-owl.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24110>

On Sun, Jul 23, 2006 at 01:24:22PM +0200, Jan-Benedict Glaw wrote:

> If people only were used to *always* place a comma behind the last
> array element, the diff would be shorter by one line each time...

I agree that it's much more convenient; I left it off because it wasn't
there before and I thought there were some standardization issues.

As it turns out, the situation is quite ridiculous. C89 allowed trailing
commas in initialization lists but not in enums. Most compilers (gcc,
sun) accepted it anyway, but some (aix xlc) did not.

Do we care? I think probably not, since the color_diff enum already had
a trailing comma. It seems like the primary non-gcc compiler that has
been mentioned is sun cc. I don't know what other compilers are being
used to compile git.

-Peff
