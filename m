From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 6 Apr 2012 17:42:19 -0400
Message-ID: <20120406214219.GB5436@sigill.intra.peff.net>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <7v7gxs1ud4.fsf@alter.siamese.dyndns.org>
 <CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGvK-0001ur-KM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab2DFVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 17:42:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52770
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab2DFVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:42:21 -0400
Received: (qmail 11956 invoked by uid 107); 6 Apr 2012 21:42:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 17:42:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 17:42:19 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0xAvc9aTeBP81tXhX6Q67+7cQ-51C1AWrKPN7bc7=JXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194912>

On Sat, Apr 07, 2012 at 12:28:05AM +0300, Felipe Contreras wrote:

> On Fri, Apr 6, 2012 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
> >>
> >>> Something is better than nothing.
> >>
> >> Yes, but...
> >
> > ;-)
> >
> > This is a good example that sometimes something is worse than nothing,
> > unless watched carefully by a competent reviewer.
> 
> And this is a good example of why you shouldn't blindly trust what a
> 'competent reviewer' says, as I'm pretty sure the comment is wrong.
> 
> But hey, if you prefer nothing, fine, drop this patch; let's continue
> to blindly modify the completion and fix regressions as they come. I
> guess I should drop my other tests as well.

Sorry, but I think you are wrong, and this is a perfect example of why
you are sometimes frustrating to work with. Your patch is definitely a
move in the right direction, and we would love to have something like it
as part of git. And I'm sure it runs fine under _your_ setup. But the
git community is much larger than just your setup, and your patch is a
regression for other people, as it breaks "make test".

Did I say "let's throw away this patch"? No. I said "here is a problem
with your patch", and I even sketched out a fix.

And nor do I think Junio was saying "let's throw it out". I think he was
responding specifically to "something is better than nothing". It's
_not_ better if it regresses other cases. So the patch as-is is not
acceptable, but it could be made so.

But instead of taking the constructive criticism and iterating on your
patch, you are ready to withdraw your patch. That seems silly when you
have already done the hard part, and the fix to make the patch
acceptable is the easy part.

But maybe I am wrong. Maybe there is no problem at all with your patch,
and my analysis is wrong, and yours is right. I am willing to admit that
as a possibility. But let's discuss it in the other part of the thread
and find out, shall we?

-Peff
