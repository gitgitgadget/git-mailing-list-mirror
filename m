From: Jeff King <peff@peff.net>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Tue, 18 Sep 2012 14:55:30 -0400
Message-ID: <20120918185530.GB20498@sigill.intra.peff.net>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
 <7v7grsqi98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 20:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE2xS-0001v8-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 20:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2IRSze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 14:55:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47452 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab2IRSzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 14:55:32 -0400
Received: (qmail 23256 invoked by uid 107); 18 Sep 2012 18:55:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Sep 2012 14:55:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2012 14:55:30 -0400
Content-Disposition: inline
In-Reply-To: <7v7grsqi98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205848>

On Mon, Sep 17, 2012 at 05:36:35PM -0700, Junio C Hamano wrote:

> > But note that using "format-patch -s" will break; it puts the sign-off
> > below the "---".
> 
> I think "format-patch -s" is a workflow mistake in the first place.
> You should be doing the sign-off the commit when you commit in the
> first place.  It is not like "I cannot sign off because I think it
> is still iffy" or anything.

It is mostly "I do not signoff because typing '-s' each time I commit is
a pain". I know it is supposed to be a conscious decision, but I think
it is a little silly. Since everything I do for git.git is going to be
signed-off, either I will automate it, or I will end up typing it
without thinking.  Whenever I make a conscious decision, it is to
_withhold_ signoff, since that is the exceptional case.

But even without that, I still think format-patch is a reasonable time
to do it. It is the time when I proof-read my commit message and patch
in its final form, and think "do I really want to send this?". That
seems to me like a reasonable time to make such a conscious decision to
signoff (or not).

> But your point still stands; "commit -s" will not see through that
> official trick either ;-).

Yes. :)

-Peff
