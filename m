From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/6] Add Travis CI support
Date: Mon, 23 Nov 2015 13:59:43 -0500
Message-ID: <20151123185943.GE2597@sigill.intra.peff.net>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
 <20151119141409.GB9353@sigill.intra.peff.net>
 <46C55D27-0B59-41AA-84AD-FED095EBDEE4@gmail.com>
 <CAE5ih7-q9JpiAW3pU6XWk+z0sGY8ej+UKEaR0bGuBnR0D9+P5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0wL7-0006Jg-7A
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 19:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbKWS7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 13:59:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:32936 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752862AbbKWS7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 13:59:46 -0500
Received: (qmail 18385 invoked by uid 102); 23 Nov 2015 18:59:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 12:59:45 -0600
Received: (qmail 4909 invoked by uid 107); 23 Nov 2015 19:00:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Nov 2015 14:00:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2015 13:59:43 -0500
Content-Disposition: inline
In-Reply-To: <CAE5ih7-q9JpiAW3pU6XWk+z0sGY8ej+UKEaR0bGuBnR0D9+P5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281593>

On Fri, Nov 20, 2015 at 12:56:04PM +0000, Luke Diamand wrote:

> >>>  git-p4: retry kill/cleanup operations in tests with timeout
> >>>  git-p4: add p4d timeout in tests
> >>>  git-p4: add trap to kill p4d on test exit
> >>
> >> These are all fairly gross, and I don't have p4d to test with myself.
> >> But if we assume they're all necessary, I suppose it's the best we can
> >> do.
> >
> > Unfortunately I think they are necessary. However, if someone finds a better way for stable p4d tests then I would be happy to see them go away, again.
> 
> I think that's just how p4d is I'm afraid. It doesn't like being
> stopped and started quickly (I guess it's not a normal use-case for
> most p4 users). I've made various unsuccessful attempts in the past to
> make these tests work reliably, and Lars' changes are far better than
> anything I ever managed.

Thanks for the extra context. I hope I didn't sound too negative in my
initial assessment. It was meant to be "this is lamentable but probably
necessary".

-Peff
