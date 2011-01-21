From: Jeff King <peff@peff.net>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 11:16:46 -0500
Message-ID: <20110121161646.GA21840@sigill.intra.peff.net>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch>
 <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
 <20110120231649.GC14184@vidovic>
 <20110120233429.GB9442@sigill.intra.peff.net>
 <7vy66epz4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 17:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgJfV-0003Ke-My
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 17:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1AUQQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 11:16:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40945 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab1AUQQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 11:16:51 -0500
Received: (qmail 19636 invoked by uid 111); 21 Jan 2011 16:16:50 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 16:16:50 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jan 2011 11:16:46 -0500
Content-Disposition: inline
In-Reply-To: <7vy66epz4r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165377>

On Thu, Jan 20, 2011 at 10:08:36PM -0800, Junio C Hamano wrote:

> >   3. Say "we also take diff options, and you can find out more about
> >      diff options in git-diff(1)." This at least points the user in the
> >      right direction, but you can't search for "--color-words" in the
> >      page.
> >
> >   4. Do (3), but also list the all (or common) diff options in a succint
> >      list without descriptions, and refer the user to git-diff(1). Then
> >      they can grep if they like, and while they won't get the immediate
> >      answer, they will get referred to the right place.
> [...]
> One complication in either 3 or 4 is that they sometimes need to be
> accompanied with "... except these diff options do not make sense in the
> context of this command, so they are no-op".  That is probably a price
> worth paying to be more helpful than 2 is.

Yeah, I took a quick look at diff-options.txt. I think many of those
special cases can be handled by just mentioning the exceptions in the
text. They are usually simple and obvious special cases, like "for -M,
if you are in a command which is traversing, you might be interested in
--follow". I don't think it will hurt people to read that, even if they
are looking at the diff-options because they want to know about "git
diff".

I'll this to my documentation cleanup todo list. It's lower priority
than many other things, but believe it or not I am working towards it.
:)

-Peff
