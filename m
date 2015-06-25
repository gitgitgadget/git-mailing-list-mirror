From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] localized date format
Date: Thu, 25 Jun 2015 12:53:41 -0400
Message-ID: <20150625165341.GA21949@peff.net>
References: <20150625131901.5b962336@pc09.procura.nl>
 <20150625124445.GA18395@peff.net>
 <20150625145659.09285538@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:53:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8APM-0001QU-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbFYQxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:53:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:51758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752467AbbFYQxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:53:43 -0400
Received: (qmail 19798 invoked by uid 102); 25 Jun 2015 16:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 11:53:43 -0500
Received: (qmail 8111 invoked by uid 107); 25 Jun 2015 16:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 12:53:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 12:53:41 -0400
Content-Disposition: inline
In-Reply-To: <20150625145659.09285538@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272695>

On Thu, Jun 25, 2015 at 02:56:59PM +0200, H.Merijn Brand wrote:

> > That being said, I do not think it would be wrong to have a date-mode
> > that just showed strftime("%c"), or some other arbitrary strftime
> > string.  You could then set log.date as appropriate for human
> > consumption.
> 
> Yes please :)
> 
>  --date=lc
>  --date=lc_time
>  --date=locale
> 
> all spring to mind as valid options

Here's a patch series that allows `--date=format:%c`, which is the same
thing. We could possibly do `--date=locale` as syntactic sugar, I guess.

  [1/3]: show-branch: use DATE_RELATIVE instead of magic number
  [2/3]: convert "enum date_mode" into a struct
  [3/3]: introduce "format" date-mode

-Peff
