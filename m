From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 16:02:57 -0500
Message-ID: <20110207210257.GA14963@sigill.intra.peff.net>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <vpqtygfa7g8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:03:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYEm-0001J6-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab1BGVDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:03:02 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1BGVDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:03:01 -0500
Received: (qmail 30661 invoked by uid 111); 7 Feb 2011 21:03:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 21:03:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 16:02:57 -0500
Content-Disposition: inline
In-Reply-To: <vpqtygfa7g8.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166293>

On Mon, Feb 07, 2011 at 09:57:43PM +0100, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I would say so; "add -p" was an ill-executed afterthought.  The codepath
> > was originally meant to be used from "-i" as the top-level interface that
> > was a fully interactive way to prepare for the next commit, which is an
> > operation that is inherently full-tree.
> 
> I agree that "git add -i" is a way to prepare the next commit, but you
> seem to imply that "git add -u" is not and then I have to disagree.

How about "git commit -a"? Shouldn't that be more or less equivalent to
"git add -u && git commit"? But it is full-tree.

So I think there is less "we do it one way, and this is the outlier" and
more "we are horribly inconsistent".

-Peff
