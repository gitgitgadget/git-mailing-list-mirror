From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5528: do not fail with FreeBSD shell
Date: Mon, 9 Mar 2015 02:04:04 -0400
Message-ID: <20150309060403.GA27128@peff.net>
References: <e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c>
 <20150308175624.GA30399@peff.net>
 <211E8F7E-5588-45B1-ACF6-BB7DFB798ABB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 07:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUqnU-0001a3-TT
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 07:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbbCIGEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 02:04:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59017 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751117AbbCIGEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 02:04:07 -0400
Received: (qmail 4824 invoked by uid 102); 9 Mar 2015 06:04:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 01:04:07 -0500
Received: (qmail 3962 invoked by uid 107); 9 Mar 2015 06:04:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:04:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 02:04:04 -0400
Content-Disposition: inline
In-Reply-To: <211E8F7E-5588-45B1-ACF6-BB7DFB798ABB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265127>

On Sun, Mar 08, 2015 at 10:19:20PM -0700, Kyle J. McKay wrote:

> >I am not convinced this isn't a violation of POSIX (which specifies that
> >field splitting is done on the results of parameter expansions outside
> >of double-quotes). But whether it is or not, we have to live with it.
> 
> That's not the only problem the shell has, t5560 had an issue, rebase had
> issues.  They've have been worked around.  It probably also affects related
> BSDs' shells as well (at least older versions that didn't change the shell).

Yeah, I hope that didn't come across as "bleh, this shell is not worth
supporting". It was "whether I think it is a bug or not, it is a real
problem and we must work around it".

> >For my own curiosity, what does:
> [...]

Thanks. Weird behavior, certainly, but I think the solution in your
patch is the right thing to do.

-Peff
