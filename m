From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 16:33:57 -0500
Message-ID: <20150226213356.GA14464@peff.net>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
 <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
 <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
 <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
 <20150226030416.GA6121@peff.net>
 <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR64f-0007dg-70
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbbBZVeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:34:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:53795 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754539AbbBZVeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:34:00 -0500
Received: (qmail 17288 invoked by uid 102); 26 Feb 2015 21:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 15:34:00 -0600
Received: (qmail 27252 invoked by uid 107); 26 Feb 2015 21:34:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Feb 2015 16:34:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2015 16:33:57 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264466>

On Thu, Feb 26, 2015 at 12:59:56PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps it would be less risky to stick get_preferred_languages() into
> > gettext.c, like the patch below. Then we do not have to worry about
> > locale.h introducing other disruptive includes. The function is not
> > technically about gettext, but it seems reasonable to me to stuff all of
> > the i18n code together.
> 
> Yeah, I like that a lot better.  Thanks.

Are you just using it for inspiration, or did you want me to wrap it up
with a commit message?

-Peff
