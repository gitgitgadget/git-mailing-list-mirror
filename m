From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 17:34:55 -0400
Message-ID: <20130419213455.GB20873@sigill.intra.peff.net>
References: <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
 <20130418203035.GB24690@sigill.intra.peff.net>
 <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
 <20130418214427.GA10119@sigill.intra.peff.net>
 <7vobdb4hii.fsf@alter.siamese.dyndns.org>
 <20130419043142.GA5055@elie.Belkin>
 <7vbo9a3011.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:35:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTIxX-0003ru-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958Ab3DSVfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:35:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:44352 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933914Ab3DSVfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:35:00 -0400
Received: (qmail 21507 invoked by uid 102); 19 Apr 2013 21:35:03 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 16:35:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 17:34:55 -0400
Content-Disposition: inline
In-Reply-To: <7vbo9a3011.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221823>

On Fri, Apr 19, 2013 at 10:25:46AM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >
> >>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
> >>     behaviour will change in Git 2.0 with respect to paths you
> >>     removed from your working tree.
> >>
> >>     * 'git add --no-all <pathspec>', which is the current default,
> >>       ignores paths you removed from your working tree.
> >>
> >>     * 'git add --all <pathspec>' will let you also record the
> >>       removals.
> >>
> >>     The removed paths (e.g. '%s') are ignored with this version of Git.
> >>     Run 'git status' to remind yourself what paths you have removed
> >>     from your working tree.
> >>
> >> or something?
> >
> > That looks good. :)
> 
> I think the direction may be good but the above is too tall to be
> the final version. of the message.  Somebody good at phrasing needs
> to trim it down without losing the essense.

Hmph. I actually like it as it is. It says:

  1. Here's what triggered this warning (removed paths without -A).

  2. Here is how you tell git what you want to do (--all/--no-all)

  3. Here is how you get more information about what you wanted to do
     (mention one such path, point to "git status").

I would not want to cut out any of those three. You could perhaps cut
out the bullet points in the middle, which reduces (2), but the user may
be able to figure it out from the first sentence. However, I like the
explicitness of those bullet points (and I prefer them to a wall of text
which is more daunting to read).

-Peff
