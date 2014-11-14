From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Fri, 14 Nov 2014 03:47:25 -0500
Message-ID: <20141114084725.GA16030@peff.net>
References: <20141113110325.GD8329@peff.net>
 <20141113110722.GB4386@peff.net>
 <CA+EOSBn0-ZFOPaeU92a0YWPW_S9kenoRUjJMp-Nhm-azftrEfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Colin Smith <colin.webdev@gmail.com>, git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 09:47:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpCXU-000206-IF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 09:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbaKNIr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 03:47:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:40270 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754631AbaKNIr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 03:47:28 -0500
Received: (qmail 13114 invoked by uid 102); 14 Nov 2014 08:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 02:47:28 -0600
Received: (qmail 7066 invoked by uid 107); 14 Nov 2014 08:47:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 03:47:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 03:47:25 -0500
Content-Disposition: inline
In-Reply-To: <CA+EOSBn0-ZFOPaeU92a0YWPW_S9kenoRUjJMp-Nhm-azftrEfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 06:46:19AM +0100, Elia Pinto wrote:

> > [1] http://en.wikipedia.org/wiki/Date_and_time_representation_by_country
> > [2] http://en.wikipedia.org/wiki/Calendar_date
> 
> Isn't not so good to refer to external resources  in a commit message ?

It is not good to omit any explanation and just include a link, like:

  Fixes the bug reported in http://...

because people who are reading "git log" have to follow that link to
even see what you are talking about (and the link might go away, or they
might not have access at the time).

It is fine, and even desirable, to summarize the relevant content of a
resource and provide a link for people who want to dig further. In this
case, I am saying "Wikipedia claims that nobody uses this format" and
backing it up with a link to indicate which pages I checked. You do not
have to follow the link to know what I am saying, but if you want to
dig deeper, you at least know where I left off my research.

Does that make sense?

-Peff
