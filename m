From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 16:56:17 -0400
Message-ID: <20150514205617.GA14836@peff.net>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
 <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
 <20150514191637.GA9329@peff.net>
 <xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
 <20150514192052.GB9329@peff.net>
 <xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
 <20150514202207.GA13541@peff.net>
 <CAPt1q6dhZarACvYQM5HFTGg3xA=LjnhF7DP8B6K+Fa1=m2Of9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Coppens <alex@nativetouch.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0B7-0007gC-H0
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912AbbENU4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:56:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:58836 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933403AbbENU4U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:56:20 -0400
Received: (qmail 26105 invoked by uid 102); 14 May 2015 20:56:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 15:56:20 -0500
Received: (qmail 27745 invoked by uid 107); 14 May 2015 20:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 16:56:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 16:56:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPt1q6dhZarACvYQM5HFTGg3xA=LjnhF7DP8B6K+Fa1=m2Of9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269092>

On Thu, May 14, 2015 at 04:51:25PM -0400, Alex Coppens wrote:

> Here are the outputs I have:
> 
> $ ls -d .git/rr-cache
> ls: .git/rr-cache: No such file or directory
> 
> $ git config rerere.enabled
> $
> 
> My repository is a ruby on rails project, I am currently on the
> development branch. It's a private repository hosted on Github. Not
> sure what other information you want.

OK, so it looks like rerere is not enabled (and my patch will fix the
case you saw). But then I am puzzled why you were running "rerere
forget" in the first place. Just experimenting, or did you expect it to
do something?

-Peff
