From: Jeff King <peff@peff.net>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 13:22:54 -0400
Message-ID: <20150519172254.GA27174@peff.net>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulEM-0004Qs-2r
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbESRW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:22:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:60876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751241AbbESRW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:22:57 -0400
Received: (qmail 3183 invoked by uid 102); 19 May 2015 17:22:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 12:22:57 -0500
Received: (qmail 14655 invoked by uid 107); 19 May 2015 17:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 13:22:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 13:22:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269376>

On Tue, May 19, 2015 at 10:20:04AM -0700, Stefan Beller wrote:

> so today I am running make test (no special flags I am aware of) on my
> ubuntu machine using
> git v2.4.1-168-g1ea28e1 and t5570-git-daemon.sh (not ok 8 - fetch
> notices corrupt idx) fails.
> 
> Any hints?

It works for me. :)

Is the problem reproducible, or intermittent? The daemon-oriented tests
sometimes can suffer from weird races. 

If it is reproducible, what does running it with "-v -i" (and maybe
"-x") say?

-Peff
