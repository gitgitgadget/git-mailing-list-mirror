From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 5/5] Speed up log -L... -M
Date: Sat, 23 Mar 2013 05:04:59 -0400
Message-ID: <20130323090459.GB25600@sigill.intra.peff.net>
References: <cover.1363865444.git.trast@student.ethz.ch>
 <72a500432c0e6fde830f505204a1d02180710656.1363865444.git.trast@student.ethz.ch>
 <CAPig+cSG1gYohpZQZxnCpKgkUPs=Dwfokx+3OhiqdGKX8fajBw@mail.gmail.com>
 <87k3oyzmg7.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 23 10:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJKOW-0002p3-BK
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 10:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab3CWJFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 05:05:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36695 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575Ab3CWJFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 05:05:12 -0400
Received: (qmail 9133 invoked by uid 107); 23 Mar 2013 09:06:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Mar 2013 05:06:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2013 05:04:59 -0400
Content-Disposition: inline
In-Reply-To: <87k3oyzmg7.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218902>

On Sat, Mar 23, 2013 at 06:58:48AM +0100, Thomas Rast wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Thu, Mar 21, 2013 at 8:52 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> >> This is a bit hacky and should really be replaced by equivalent
> >> support in --follow, and just using that.  However, in the meantime it
> >
> > s/using/use/
> 
> I'm not a native speaker, but I really think 'using' is more correct
> here.

Cannot...resist...grammar discussion.

I think you are both potentially right.

You might consider the two items "equivalent support" and "using that"
to be two noun phrases that are objects of the preposition "by", and
that the writer simply omits the second "by" after the "and". In which
case you are making a noun phrase from a verb phrase, and would want to
use the gerund form "using".  And the sentence, simplifying out some
modifiers and adding the missing "by" (which is fine to omit, but the
parts of speech become much clearer with it there), looks like:

  ...should be replaced by equivalent support, and by using that.

However, you could also argue that the final clause is a second verb
phrase for "this should" which just omits the extra "should" (which is
also OK in a list. In which case "use" acts as a verb, and parses as:

  ...should be replaced by equivalent support, and this should just use
  that.

So I think it is correct either way, and though it parses slightly
differently, the overall meaning is the same.

Phew. Totally not worth that much discussion, but for some reason I find
these sorts of ambiguous language cases interesting.

-Peff
