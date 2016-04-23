From: Jeff King <peff@peff.net>
Subject: Re: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Sat, 23 Apr 2016 01:11:16 -0400
Message-ID: <20160423051116.GA21390@sigill.intra.peff.net>
References: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
 <20160422231452.GA10905@sigill.intra.peff.net>
 <CA+UAp06YMrVY8rK3jzWtLB=Zo8F=GTLQByYD-xR8+Lj=3=_hqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gennaro Torre <gtorre@tumblr.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 07:12:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atprZ-0001Jv-Mm
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 07:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbcDWFMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 01:12:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:54726 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750737AbcDWFME (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 01:12:04 -0400
Received: (qmail 20886 invoked by uid 102); 23 Apr 2016 05:11:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 23 Apr 2016 01:11:19 -0400
Received: (qmail 15176 invoked by uid 107); 23 Apr 2016 05:11:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 23 Apr 2016 01:11:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Apr 2016 01:11:16 -0400
Content-Disposition: inline
In-Reply-To: <CA+UAp06YMrVY8rK3jzWtLB=Zo8F=GTLQByYD-xR8+Lj=3=_hqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292299>

On Sat, Apr 23, 2016 at 01:01:06AM -0400, Gennaro Torre wrote:

> @Jeff King nope nothing interesting, it just hangs:
> 
> [gtorre@host1 A:DEVEL tumblr.old]$ git fetch -vv
> Looking up <cache> ... done.
> Connecting to <cache> (port 9418) ... <ip> done.
> Server supports multi_ack_detailed
> Server supports side-band-64k
> Server supports ofs-delta
> Server version is git/2.8.0

Hmm.  If you run with GIT_TRACE_PACKET=1, that may give an indication of
why it is hanging. Or perhaps tracing via gdb to see where we are when
it hangs.

-Peff
