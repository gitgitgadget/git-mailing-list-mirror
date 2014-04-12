From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Sat, 12 Apr 2014 07:23:44 -0400
Message-ID: <20140412112344.GA14820@sigill.intra.peff.net>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <20140411134801.GB5871@nysa.casa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 13:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYw2p-0001Fp-Nl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 13:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbaDLLXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 07:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:58493 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754319AbaDLLXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 07:23:48 -0400
Received: (qmail 25863 invoked by uid 102); 12 Apr 2014 11:23:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Apr 2014 06:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Apr 2014 07:23:44 -0400
Content-Disposition: inline
In-Reply-To: <20140411134801.GB5871@nysa.casa.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246166>

On Fri, Apr 11, 2014 at 08:48:01AM -0500, Felipe Contreras wrote:

> I think of @{publish} as "the branch the user has configured to push
> to"; it overrides all other configurations (push.default and push
> refspecs). I wouldn't mind having a @{push} *in addition* to @{publish}
> that would have the behavior you mention, but for @{publish} I'm pretty
> certain the behavior I want is that it maps *directly* to what the user
> has configured.

I guess I don't understand why we need "branch.*.push" when we already
have push refspecs that do the same thing (and are more powerful, as
they can glob).

The behavior you describe is not useful to me, as it would mean having
to manage branch.*.push as a duplicate of the information that is
already found in "remote.$(git config remote.pushdefault).push".  I do
not mind if the two co-exist, but please do not take the short @{p} as
your series does (not only because of @{push}, but also because @{pull}
has been mentioned elsewhere as a possible other name for @{upstream}).

-Peff
