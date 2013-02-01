From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 1 Feb 2013 14:00:08 -0500
Message-ID: <20130201190007.GB22919@sigill.intra.peff.net>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
 <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
 <20130201073352.GB970@sigill.intra.peff.net>
 <7vr4kzamt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Lql-00071v-4w
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150Ab3BATAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:00:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab3BATAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:00:11 -0500
Received: (qmail 31037 invoked by uid 107); 1 Feb 2013 19:01:35 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 14:01:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 14:00:08 -0500
Content-Disposition: inline
In-Reply-To: <7vr4kzamt7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215252>

On Fri, Feb 01, 2013 at 10:52:52AM -0800, Junio C Hamano wrote:

> >   4. Replace the rename "gitfoo" above with a "see git-foo..." pointer.
> >      Users of "git help foo" would not ever see this, but people who
> >      have trained their fingers to type "man gitfoo" would, along with
> >      anybody following an outdated HTML link.
> >
> >   5. Update internal references to "linkgit:gitfoo" to point to
> >      "git-foo".
> >
> > Hmm. That really does not seem so bad. The biggest downside is the
> > people who have to see the redirect made in step 4.
> 
> Yeah, I see that a show-stopper in the whole sequence.
> 
> This is one of the "if we had perfect knowledge we would have
> designed it this way, and we could still migrate our current system
> to that ideal, but it is dubious the difference between the current
> system and the ideal will outweigh the cost of migration" moment,
> isn't it?

Yeah, perhaps. I did the patch series just to see what the effort would
be like. But at this point I am fine if we drop it (it sounded like
Jonathan was in favor of this direction, so maybe he wants to make a
final argument).

-Peff
