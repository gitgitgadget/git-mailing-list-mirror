From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Tue, 2 Dec 2014 00:42:26 -0500
Message-ID: <20141202054226.GA1948@peff.net>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvgEI-0001tv-7P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaLBFm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 00:42:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:46966 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751060AbaLBFmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:42:25 -0500
Received: (qmail 19762 invoked by uid 102); 2 Dec 2014 05:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Dec 2014 23:42:25 -0600
Received: (qmail 13105 invoked by uid 107); 2 Dec 2014 05:42:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 00:42:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 00:42:26 -0500
Content-Disposition: inline
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260538>

On Sun, Nov 30, 2014 at 03:55:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is something else that's been sitting in my tree for a while now=
=2E
> It adds "git list-files", intended to be aliased as "ls" with your
> favourite display options.

When I read the subject, I thought "why isn't this called git-ls?". The=
n
when I read this paragraph, I thought "if the point is for everybody to
make their own ls alias, why do we need list-files at all, instead of
just adding options to ls-files"?

I'll let you decide which (if any) you'd like to answer. :)

My guesses:

  1. If it were "git-ls", it would stomp on existing aliases people hav=
e
     constructed.

  2. If it is a wrapper around ls-files, then the options may be
     constrained; ls-files already squats on useful options like "-d"
     (which, if we are matching traditional ls, is more like our "-t").

I somewhat feel like (1) can be mitigated by the fact that your command
is what people were probably trying to approximate with their aliases,
and that as porcelain it should be very configurable (so they should be
able to accomplish the same things as their aliases). But I dunno. I do
not have an "ls" alias, so I am biased. :)

As a side note, I wonder if it would be sensible to whitelist some
commands as porcelain, and allow aliases to override them (either
entirely, or just to add-in some options).

-Peff
