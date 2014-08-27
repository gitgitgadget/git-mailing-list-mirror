From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2014, #04; Tue, 26)
Date: Wed, 27 Aug 2014 04:13:23 -0400
Message-ID: <20140827081323.GA26538@peff.net>
References: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:13:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMYMY-0005IN-Te
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbaH0IN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 04:13:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59934 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755335AbaH0INZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 04:13:25 -0400
Received: (qmail 16379 invoked by uid 102); 27 Aug 2014 08:13:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 03:13:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 04:13:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255989>

On Tue, Aug 26, 2014 at 03:09:34PM -0700, Junio C Hamano wrote:

> --------------------------------------------------
> [New Topics]

There are a few misc topics of mine that I'd like to ping on:

  - jk/contrib-subtree-make-all; you picked up the topic, but it's not
    in pu or "what's cooking". Just forgotten, I think?

  - jk/send-pack-many-refspecs; this is in pu, but I didn't see it in
    "what's cooking". I'm concerned that the "ulimit" test gave you
    trouble and you punted on it. :)

  - "fast-export --anonymize"; I noticed you didn't pick this up at all.
    I agree it has yet to prove its worth, but I wonder if it is worth
    shipping it (possibly labeled as experimental and not to be depended
    on) to get it in the hands of users. The intended use is getting bug
    reports from users, who are not always savvy enough to pick up (and
    possibly rebase) a patch from the list. I dunno.

-Peff
