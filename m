From: Jeff King <peff@peff.net>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 22:41:51 -0400
Message-ID: <20160510024151.GB16965@sigill.intra.peff.net>
References: <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
 <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
 <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
 <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
 <CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
 <20160509083323.GB14299@sigill.intra.peff.net>
 <CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
 <20160509161226.GB11861@sigill.intra.peff.net>
 <xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com>
 <xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	demerphq <demerphq@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 04:42:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azxcV-0000S0-HS
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 04:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbcEJClz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 22:41:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36749 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbcEJCly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 22:41:54 -0400
Received: (qmail 22704 invoked by uid 102); 10 May 2016 02:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 22:41:54 -0400
Received: (qmail 25969 invoked by uid 107); 10 May 2016 02:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 22:42:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 22:41:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294085>

On Mon, May 09, 2016 at 11:36:09AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yes, I think the comment should just go.  Nobody used that alphabet
> > form since it was written in d17cf5f3 (tests: Introduce test_seq,
> > 2012-08-04).
> >
> >> I don't really care either way whether it is replaced or not (at one
> >> point there were some people really interested in NO_PERL not even using
> >> one-liners in the test suite, but I am not one of them).
> >
> > Neither am I, but I think it is prudent to drop that "letters".  The
> > comment even says the letter form is not portable already, so the
> > mention of GNU seq(1) is not helping at all.
> 
> -- >8 --
> Subject: test-lib-functions.sh: remove misleading comment on test_seq

Thanks, this (and the actual implementation change) both look good to
me, and I'm happy with either or both being applied.

-Peff
