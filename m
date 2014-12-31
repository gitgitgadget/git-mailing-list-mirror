From: Jeff King <peff@peff.net>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 20:26:16 -0500
Message-ID: <20141231012615.GA8852@peff.net>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
 <54A310AB.7050701@alum.mit.edu>
 <xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
 <CAHd499Bt6_SOkj9Pp+GcLGnwDUR-pgr_YKt4yqZBAHjX+vkM8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 02:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y683N-0004L3-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 02:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaLaB0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 20:26:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:58071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752435AbaLaB0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 20:26:18 -0500
Received: (qmail 16161 invoked by uid 102); 31 Dec 2014 01:26:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 19:26:17 -0600
Received: (qmail 9312 invoked by uid 107); 31 Dec 2014 01:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Dec 2014 20:26:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Dec 2014 20:26:16 -0500
Content-Disposition: inline
In-Reply-To: <CAHd499Bt6_SOkj9Pp+GcLGnwDUR-pgr_YKt4yqZBAHjX+vkM8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261964>

On Tue, Dec 30, 2014 at 03:39:53PM -0600, Robert Dailey wrote:

> It also feels like there should be a
> shorthand for the `git log` usage in conjunction with `git show`... I
> could probably make an alias for it.

One thing I didn't see mentioned in this thread is that the question
"show me the commit closest to time X" does not have a single answer.
When there are branches, there may be many such answers, one for each
line of simultaneous development.

So people tend not to ask that question[1], and therefore nobody
bothered to make a convenient shorthand for it.

-Peff

[1] What do they ask instead? I find most of my older queries for
    commits are satisfied following parent links from well-known points.
    E.g., finding where topic X was merged, and then walking backwards
    using "^2" to see the tip of the original topic.

    If I am looking for information about a particular file about a year
    ago, I often turn to "-S" or git-blame (actually, "tig blame" in my
    case, which lets you walk backwards interactively).

    But of course the exact query will depend on just what it is you
    want to know. :)
