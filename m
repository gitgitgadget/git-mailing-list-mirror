From: Jeff King <peff@peff.net>
Subject: Re: Git log three-dot notation: include merge base
Date: Sat, 14 May 2016 19:22:11 -0400
Message-ID: <20160514232211.GA26038@sigill.intra.peff.net>
References: <CAHd499A_AN0U7gj8Yp0pBGGZ6deNrDJ4F4npAKy6a2U0+uTsxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 01:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1it7-0001FR-9m
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 01:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbcENXWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 19:22:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:39712 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753866AbcENXWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 19:22:14 -0400
Received: (qmail 29475 invoked by uid 102); 14 May 2016 23:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 May 2016 19:22:14 -0400
Received: (qmail 29110 invoked by uid 107); 14 May 2016 23:22:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 May 2016 19:22:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 May 2016 19:22:11 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499A_AN0U7gj8Yp0pBGGZ6deNrDJ4F4npAKy6a2U0+uTsxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294630>

On Sat, May 14, 2016 at 06:09:21PM -0500, Robert Dailey wrote:

> Using A...B notation, I get this:
> 
> $ git log --oneline --decorate --graph A...B
> * eb28ae4 (HEAD -> B) Commit 6
> * 7173fa1 Commit 5
> * b5fe27b Commit 4
> * 37a8ca8 (A) Commit 3
> * 72745a7 Commit 2
> 
> The graph no longer makes any sense, and isn't helpful to me at all.
> This is because the merge base commit isn't shown. I understand this
> is "by-design", but is there a way to include it? It's necessary to
> have it, for this graph to make sense.

Try "--boundary".

-Peff
