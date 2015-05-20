From: Jeff King <peff@peff.net>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 23:01:18 -0400
Message-ID: <20150520030118.GA7223@peff.net>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
 <20150519172254.GA27174@peff.net>
 <CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
 <CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
 <CAGZ79kbYUNjD79T+1LqgLNf=_ym-keq57FoQhby_aqn_sPFYSg@mail.gmail.com>
 <CAGZ79ka7iNP0VJbLmzpUmFkkdtBhgHrbseKtfOq-PX4FCiBuaA@mail.gmail.com>
 <CAGZ79kbHVeNPQr_A3izp41WLRcaroHfN6NJObWcURQk4B=NYWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 05:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuuGG-0007F3-55
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 05:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbbETDBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 23:01:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:32986 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752177AbbETDBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 23:01:21 -0400
Received: (qmail 2690 invoked by uid 102); 20 May 2015 03:01:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 22:01:21 -0500
Received: (qmail 19877 invoked by uid 107); 20 May 2015 03:01:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 23:01:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 23:01:18 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbHVeNPQr_A3izp41WLRcaroHfN6NJObWcURQk4B=NYWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269435>

On Tue, May 19, 2015 at 12:16:57PM -0700, Stefan Beller wrote:

> I did have a special flag set, which is
> CC = /usr/lib/gcc-snapshot/bin/gcc
> which is using the latest snapshot of the gcc compiler
> gcc (Ubuntu 20140405-0ubuntu1) 4.9.0 20140405
> (experimental) [trunk revision 209146]

I'm not sure 2014 counts as the "latest". :) My stock compiler is 4.9.2,
and gcc-snapshot on Debian unstable is:

  gcc (Debian 20150516-1) 6.0.0 20150516 (experimental)
  [trunk revision 223239]

> Could somebody try to reproduce the failing test using the latest gcc
> snapshot compiler?

Both versions I listed above seem to work fine for me. Of course we
can't definitively rule out git provoking undefined behavior in certain
compiler versions, but short of more data, I'd say it's probably a gcc
bug in 4.9.0 which has since been fixed.

-Peff
