From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Tue, 3 Sep 2013 13:20:47 -0400
Message-ID: <20130903172046.GA1050@sigill.intra.peff.net>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuHf-0002JO-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab3ICRUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:20:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:56859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab3ICRUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:20:51 -0400
Received: (qmail 16674 invoked by uid 102); 3 Sep 2013 17:20:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 12:20:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 13:20:47 -0400
Content-Disposition: inline
In-Reply-To: <20130903170419.GA29921@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233745>

On Tue, Sep 03, 2013 at 10:04:19AM -0700, Jonathan Nieder wrote:

> > It depends on the change, I suppose.  I agree, changing 3k+ lines just
> > to avoid yoda conditions...  I doubt the gain worth the code churn.
> 
> Especially when the idiom being changed is not even being made better.
> ;-)

Yes. IMHO it is not just "not worth the churn" but actively making the
code less readable.

> While at it, I rerolled the other patches from the series to clarify
> their commit messages (replacing "fix <something>" with a fuller
> description).

The series looks fine to me, modulo the fix up in v2 of 4/4.

-Peff
