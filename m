From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 17:17:19 -0500
Message-ID: <20140107221719.GE28102@sigill.intra.peff.net>
References: <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
 <20140107205618.GA28102@sigill.intra.peff.net>
 <xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
 <20140107212432.GD28102@sigill.intra.peff.net>
 <xmqqr48jbg6j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0exi-0003ui-98
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaAGWRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:17:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:56774 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752045AbaAGWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:17:21 -0500
Received: (qmail 28167 invoked by uid 102); 7 Jan 2014 22:17:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 16:17:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 17:17:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr48jbg6j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240173>

On Tue, Jan 07, 2014 at 02:06:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that is sensible, and only heightens my sense of the "upstream"
> > push.default as useless. :)
> 
> Yes, it only is good for centralized world (it was designed back in
> the centralized days after all, wasn't it?).

I do not think there is any "centralized days". From day one, Linus
advocated a triangular workflow, and that is how git and kernel develop
has always been done. And that is why the default of "matching" was
there.

There were people who came later, and who still exist today, who use git
in an SVN-like centralized way. So if there were centralized days, we
are in them now. :)

I just do not see any real advantage even in a centralized world for
"upstream" versus "current". Before remote.pushdefault, I can
potentially see some use (if you want to abuse @{upstream}), but now I
do not see any point.

And even in a centralized workflow, I see "upstream" creating problems.
E.g., you fork a feature branch in the centralized repo; it should not
get pushed straight back to "master"! And that is why we invented
"simple", to prevent such things.

I dunno. I have not gone back and read all of the arguments around
push.default from last year. It is entirely possible everything I just
said was refuted back then, and I am needlessly rehashing old arguments.
I remember that Matthieu was one of the main advocates of "upstream". I
am cc-ing him here to bring his attention (not just to this message, but
to the whole thread).

-Peff
