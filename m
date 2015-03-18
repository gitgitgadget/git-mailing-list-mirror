From: Jeff King <peff@peff.net>
Subject: Re:
Date: Wed, 18 Mar 2015 17:17:16 -0400
Message-ID: <20150318211716.GC3376@peff.net>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
 <CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
 <CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alessandro Zanardi <pensierinmusica@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:17:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLL9-0003jI-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbbCRVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:17:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:34867 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754685AbbCRVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:17:19 -0400
Received: (qmail 1191 invoked by uid 102); 18 Mar 2015 21:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 16:17:19 -0500
Received: (qmail 7173 invoked by uid 107); 18 Mar 2015 21:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 17:17:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 17:17:16 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265760>

On Wed, Mar 18, 2015 at 02:06:22PM -0700, Stefan Beller wrote:

> > Where did you get that file from? We need to find whoever is
> > responsible and notify them so that these users who are having
> > the issue will be helped.
> 
> Given that this is part of https://github.com/github/gitignore
> which is the official collection of .gitignore files from Github,
> the company, we could ask Jeff or Michael if it is urgent.
> The actual fix being merged 3 years ago makes me belief
> it is not urgent though.

It looks like the fix they have in that repo does the right thing[1],
but for reference, you are much more likely to get results by creating
an issue or PR on that repository, rather than asking me.

-Peff

[1] The double-CR fix works because we strip a single CR from the end of
    the line (as a convenience for CRLF systems), and then the remaining
    CR is syntactically significant. But I am surprised that quoting
    like:

      printf '"Icon\r"' >.gitignore

    does not seem to work.
