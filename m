From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Fri, 14 Mar 2014 00:57:58 -0400
Message-ID: <20140314045758.GA32748@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net>
 <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
 <20140312211415.GA10305@sigill.intra.peff.net>
 <20140312220640.GA14802@sigill.intra.peff.net>
 <xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
 <CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOKC7-0005Q6-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbaCNE6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:58:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:39259 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751860AbaCNE6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:58:00 -0400
Received: (qmail 2466 invoked by uid 102); 14 Mar 2014 04:58:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 23:58:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 00:57:58 -0400
Content-Disposition: inline
In-Reply-To: <CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244081>

On Wed, Mar 12, 2014 at 11:33:50PM -0400, Quint Guvernator wrote:

> It is _not_ my goal to make the code harder to maintain down the road.
> So, at this point, which hunks (if any) are worth patching?

This discussion ended up encompassing a lot of other related cleanups. I
hope we didn't scare you away. :)

My understanding is that you were approaching this as a micro-project
for GSoC. I'd love it if you want to pick up and run with some of the
ideas discussed here. But as far as a microproject goes, I think it
would make sense to identify one or two no-brainer improvement spots by
hand, and submit a patch with just those (and I think Junio gave some
good guidelines in his reply).

-Peff
