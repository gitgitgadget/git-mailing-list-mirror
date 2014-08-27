From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2014, #04; Tue, 26)
Date: Wed, 27 Aug 2014 12:28:19 -0400
Message-ID: <20140827162819.GB1432@peff.net>
References: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
 <20140827081323.GA26538@peff.net>
 <xmqqfvgieyoo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:28:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMg5D-00070e-IU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935103AbaH0Q2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:28:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:60153 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933798AbaH0Q2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:28:21 -0400
Received: (qmail 8345 invoked by uid 102); 27 Aug 2014 16:28:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 11:28:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 12:28:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvgieyoo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256007>

On Wed, Aug 27, 2014 at 08:31:51AM -0700, Junio C Hamano wrote:

> >   - jk/send-pack-many-refspecs; this is in pu, but I didn't see it in
> >     "what's cooking". I'm concerned that the "ulimit" test gave you
> >     trouble and you punted on it. :)
> 
> It was picked up after the day's edition of "What's cooking" was
> written, or something, I think.

Ah, sorry to nag, then.

> >   - "fast-export --anonymize"; I noticed you didn't pick this up at all.
> >     I agree it has yet to prove its worth, but I wonder if it is worth
> >     shipping it (possibly labeled as experimental and not to be depended
> >     on) to get it in the hands of users. The intended use is getting bug
> >     reports from users, who are not always savvy enough to pick up (and
> >     possibly rebase) a patch from the list. I dunno.
> 
> I was waiting for the topic to calm down a bit, without knowing if
> there will or will not be a reroll with some low-hanging fruit
> enhancement based on the discussion, to avoid an "oops, need to
> replace the one I queued but haven't pushed out yet with the new
> reroll".

Makes sense. I think the v2 I sent[1] is OK, and as far as I was
planning to take it for now (there were some other possible enhancements
discussed, but I think those can happen in-tree if somebody feels like
working on it).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/255646
