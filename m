From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 12:59:37 -0400
Message-ID: <20130411165937.GA1255@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
 <20130411161845.GA665@sigill.intra.peff.net>
 <CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKqk-0004gZ-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880Ab3DKQ7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:59:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852Ab3DKQ7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:59:45 -0400
Received: (qmail 16709 invoked by uid 107); 11 Apr 2013 17:01:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 13:01:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 12:59:37 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220891>

On Thu, Apr 11, 2013 at 11:49:11AM -0500, Felipe Contreras wrote:

> > I am OK with adding the test for import as a separate patch. What I am
> > not OK with (and this goes for the rest of the commit message, too) is
> > failing to explain any back-story at all for why the change is done in
> > the way it is.
> >
> > _You_ may understand it _right now_, but that is not the primary
> > audience of the message. The primary audience is somebody else a year
> > from now who is wondering why this patch was done the way it was.
> 
> Who would be this person? Somebody who wonders why this test is using
> "feature done"? I doubt such a person would exist, as using this
> feature is standard, as can be seen below this chunk. *If* the test
> was *not* using this "feature done", *then* sure, an explanation would
> be needed.

If it was so obvious, why did your initial patch not use "feature done"?
If it was so obvious, why did our email discussion go back and forth so
many times before arriving at this patch?

It was certainly not obvious to me when this email thread started. So in
response to your question: *I* am that person. I was him two weeks ago,
and there is a good chance that I will be him a year from now. Much of
my work on git is spent tracking down bugs in older code, and those
commit messages are extremely valuable to me in understanding what
happened at the time.

But I give up on you. I find most of your commit messages lacking in
details and motivation, making assumptions that the reader is as
familiar with the code when reading the commit as you are when you wrote
it. I tried to help by suggesting in review that you elaborate. That
didn't work. So I tried to help by writing the text myself. But clearly
I am not going to convince you that it is valuable, even if it requires
no work at all from you, so I have nothing else to say on the matter.

-Peff
