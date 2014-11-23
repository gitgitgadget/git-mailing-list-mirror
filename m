From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sun, 23 Nov 2014 14:46:25 -0500
Message-ID: <20141123194624.GB16605@peff.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
 <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
 <20141121180105.GB26650@peff.net>
 <5470A4C0.3070501@web.de>
 <20141122191932.GA13340@peff.net>
 <xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsd78-00028u-It
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbaKWTq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:46:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:43731 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751504AbaKWTq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:46:26 -0500
Received: (qmail 10390 invoked by uid 102); 23 Nov 2014 19:46:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 13:46:26 -0600
Received: (qmail 9341 invoked by uid 107); 23 Nov 2014 19:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 14:46:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Nov 2014 14:46:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260102>

On Sun, Nov 23, 2014 at 10:10:47AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... Possibly because I do not know that those instructions
> > are written down anywhere. We usually catch such things in review these
> > days, but there are many inconsistent spots in the existing suite.
> 
> t/README has this
> 
>     Don't:
> 
>      - use '! git cmd' when you want to make sure the git command exits
>        with failure in a controlled way by calling "die()".  Instead,
>        use 'test_must_fail git cmd'.  This will signal a failure if git
>        dies in an unexpected way (e.g. segfault).
> 
>        On the other hand, don't use test_must_fail for running regular
>        platform commands; just use '! cmd'.

Thanks, I did not actually look and relied on my memory, which was
obviously wrong. I agree that the instructions there are sufficient.

> Do we refer to t/README from CodingGuidelines where we tell the
> developers to always write tests to prevent other people from
> breaking tomorrow what you did today?  If not, perhaps that is what
> needs to be added.

That might make sense. It might also be that Torsten simply overlooked
it when asking his question (i.e., there is nothing to fix,
documentation is not always read completely, and we can move on).

-Peff
