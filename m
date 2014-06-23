From: Jeff King <peff@peff.net>
Subject: Re: How should git-config include.path option work in ~/.gitconfig
 file?
Date: Mon, 23 Jun 2014 13:29:13 -0400
Message-ID: <20140623172913.GE4838@sigill.intra.peff.net>
References: <CAK6hiNhumFhKd9tjr07SgtZe23LwW8RKSp3BbwVRh06-L0C8EA@mail.gmail.com>
 <20140621100803.GB16599@sigill.intra.peff.net>
 <CAK6hiNjxeQ6sy1Uk_ApTgKT41cPE-NB1D+ec2JqFvog_9HeFZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Cox, Michael" <mhcox@bluezoosoftware.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:29:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz83U-0003qR-75
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbaFWR3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:29:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:49755 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752977AbaFWR3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:29:15 -0400
Received: (qmail 2959 invoked by uid 102); 23 Jun 2014 17:29:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 12:29:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 13:29:13 -0400
Content-Disposition: inline
In-Reply-To: <CAK6hiNjxeQ6sy1Uk_ApTgKT41cPE-NB1D+ec2JqFvog_9HeFZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252357>

On Sun, Jun 22, 2014 at 01:00:53PM -0600, Cox, Michael wrote:

> I like the idea of recognizing environment variable syntax in config files,
> at least a feature that would allow *some* config variables to be specified
> as accepting environment variable syntax.  It adds a lot of flexibility,
> but I'm sure it might also introduce security issues that I am completely
> unaware of (like the  issue you made me aware of above).

I don't think there are any security issues; if you control the
environment, you can already execute arbitrary code with git.

Now we just need somebody to volunteer to implement it. :)

-Peff
