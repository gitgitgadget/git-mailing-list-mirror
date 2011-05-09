From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 9 May 2011 18:08:06 -0400
Message-ID: <20110509220806.GC3719@sigill.intra.peff.net>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
 <7vei47q0i6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYcn-0007KB-TR
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab1EIWIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:08:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39567
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932183Ab1EIWII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:08:08 -0400
Received: (qmail 12827 invoked by uid 107); 9 May 2011 22:10:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 18:10:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 18:08:06 -0400
Content-Disposition: inline
In-Reply-To: <7vei47q0i6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173272>

On Mon, May 09, 2011 at 09:53:05AM -0700, Junio C Hamano wrote:

> I agree with this. I do not foresee myself using "commit -p" ever for this
> exact reason. I however didn't see anything wrong in the series and I do
> not see any reason to reject it, either. It's just another long rope other
> people can use to tangle their neck with ;-).

Heh. Maybe your title should be "Git Hangman". :)

> > Hmm. Test t7501.8 explicitly tests that this isn't allowed. But the test
> > is poorly written, and falsely returns success even with your patch.
> 
> Thanks. Let me see if I can simply amend what I queued already ;-)

It's unfortunately not quite as simple as having that test succeed, as
it changes state that breaks later tests. I didn't investigate deeply,
though.

-Peff
