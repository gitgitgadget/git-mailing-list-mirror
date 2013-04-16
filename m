From: Jeff King <peff@peff.net>
Subject: Re: Ensimag students projects, version 2013
Date: Tue, 16 Apr 2013 00:23:10 -0400
Message-ID: <20130416042310.GA15676@sigill.intra.peff.net>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
 <vpqvc7oqh8a.fsf@grenoble-inp.fr>
 <20130415140513.GA16154@sigill.intra.peff.net>
 <7v1uab26bn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:23:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxQS-0006NA-Es
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3DPEXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:23:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47513 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab3DPEXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:23:17 -0400
Received: (qmail 1134 invoked by uid 107); 16 Apr 2013 04:25:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 00:25:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 00:23:10 -0400
Content-Disposition: inline
In-Reply-To: <7v1uab26bn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221361>

On Mon, Apr 15, 2013 at 07:53:48AM -0700, Junio C Hamano wrote:

> > Yes. The concept isn't that hard, but the question was one of whether it
> > would break some obscure workflows. But I don't remember all of the
> > details; I think I gave some examples in past threads.
> 
> I think the one Thomas lists in $gmane/165758 is the one.

The one I was thinking of is:

  http://article.gmane.org/gmane.comp.version-control.git/127215

> The primary reason why I do not think this is relevant these days is
> because the original premise "remote tracking branches keep what the
> last 'git fetch' observed" has already been broken for a long time.
> The users are better off thinking that the remote tracking branches
> can be updated any time (not just the last 'git fetch') when Git
> observes (or could observe) the state of the remote without being
> told explicitly with today's "pretend as if we fetched immediately
> after we push" behaviour.

Yeah, that is certainly my mental model, and how "git push" works (and
how the patch I linked to above works). I actually don't care that much
either way, which is why I haven't polished up that patch. I'd be happy
if somebody worked on it, but I don't know if it is all that interesting
a student project. It is not much development, and mostly about digging
in the history of what tracking branches mean, and convincing everybody
it's a good change. Which is hard for any newcomer to the community to
do as a first project.

-Peff
