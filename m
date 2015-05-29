From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] config: add options to list only variable names
Date: Fri, 29 May 2015 07:39:43 -0400
Message-ID: <20150529113942.GA30503@peff.net>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
 <1432816175-18988-1-git-send-email-szeder@ira.uka.de>
 <1432816175-18988-2-git-send-email-szeder@ira.uka.de>
 <xmqqbnh4h5k4.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2Zhomk+ryRfZFWAVs0yZeXUfpBXTo51Cm=Lj1QbkRbmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 13:39:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIdj-0000OP-K0
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbbE2Ljs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:39:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:37578 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752099AbbE2Ljq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:39:46 -0400
Received: (qmail 5985 invoked by uid 102); 29 May 2015 11:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 06:39:45 -0500
Received: (qmail 3941 invoked by uid 107); 29 May 2015 11:39:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 07:39:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 07:39:43 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD2Zhomk+ryRfZFWAVs0yZeXUfpBXTo51Cm=Lj1QbkRbmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270227>

On Fri, May 29, 2015 at 01:34:50PM +0200, Christian Couder wrote:

> >> +--get-name-regexp::
> >> +     Like --get-regexp, but shows only matching variable names, not its
> >> +     values.
> >
> > which makes it clear why it is needed.  The distinction is purely
> > about the output, i.e. the values are omitted.
> 
> If the distinction is purely about the output, then it seems logical
> to add only an output related option, like the --name-only option I
> suggested, and not 2 new modes (--get-name-regexp and --list-names).
> 
> Doesn't it look like git config already has too many modes?

Yeah, I'd agree that is a simpler way to look at it, and avoiding extra
modes is probably a good thing.

-Peff
