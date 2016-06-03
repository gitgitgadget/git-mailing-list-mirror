From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] git-fetch.txt: document fetch output
Date: Fri, 3 Jun 2016 12:55:03 -0400
Message-ID: <20160603165502.GA1733@sigill.intra.peff.net>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:02:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sNT-0008Io-Je
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 18:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbcFCQzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 12:55:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:48615 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932673AbcFCQzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 12:55:06 -0400
Received: (qmail 22969 invoked by uid 102); 3 Jun 2016 16:55:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 12:55:05 -0400
Received: (qmail 23659 invoked by uid 107); 3 Jun 2016 16:55:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 12:55:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 12:55:03 -0400
Content-Disposition: inline
In-Reply-To: <20160603110843.15434-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296346>

On Fri, Jun 03, 2016 at 06:08:41PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This patch is a copy from git-push.txt, modified a bit because the
> flag '-' means different things in push (delete) and fetch (tag
> update). We probably should unify the documents at some point in
> future.

This is stderr output from a porcelain. I don't think we make any
promises about the format, and since we're changing other bits, perhaps
now is a good time to unify the "-" handling.

> +The status of the push is output in tabular form, with each line
> +representing the status of a single ref. Each line is of the form:

Like Marc, I wondered what this means. :) I know that there have been
different status outputs from transport.c and fetch.c in the past, but =
I
thought we had unified a lot of that. If we haven't, it seems like a
good time to do so (and I'd prefer fixing to documenting quirks, when
it's something that isn't plumbing).

-Peff
