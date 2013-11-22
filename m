From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 17:36:54 -0500
Message-ID: <20131122223654.GB7538@sigill.intra.peff.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
 <20131122102345.GC12042@sigill.intra.peff.net>
 <87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
 <20131122172626.GA4881@sigill.intra.peff.net>
 <87vbzkiahs.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 22 23:37:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjzLQ-0001Ql-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 23:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3KVWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 17:36:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:44038 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755484Ab3KVWg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 17:36:56 -0500
Received: (qmail 17569 invoked by uid 102); 22 Nov 2013 22:36:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 16:36:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 17:36:54 -0500
Content-Disposition: inline
In-Reply-To: <87vbzkiahs.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238219>

On Fri, Nov 22, 2013 at 06:58:55PM +0100, Thomas Rast wrote:

> > I didn't touch that. Vicent, did you have a comment on the name (it
> > really does look like it is a negation, and the only caller is
> > ewah_not).
> 
> Hmm, so it really was that one unlucky thing :-)

I don't promise there is only one unlucky thing. :) Only that we made a
good faith effort to address the comments. There were a lot of comments
and a lot of re-rolls, and I would not be surprised if something else
was missed (I am not thinking of anything in particular, but just
preparing you mentally).

> I don't have much to say on the area, but if you think it helps you I
> can set aside some time RSN to review the second half of the series,
> too.  Back in June I only looked at the first half.

I would love that. My comments to Junio were not to rush the topic, but
mainly to keep it progressing.

Re-rolling such a big chunk of code _is_ a pain for both me and for
reviewers, so I wouldn't mind switching to "fixes on top" instead of
re-rolling at some point. But we can do another round or two of re-roll
first.

-Peff
