From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over
 strbuf_split
Date: Wed, 17 Feb 2016 17:26:08 -0500
Message-ID: <20160217222607.GA25424@sigill.intra.peff.net>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
 <1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
 <20160217221430.GA24899@sigill.intra.peff.net>
 <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:26:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWAY3-00009J-8e
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965650AbcBQW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:26:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:44459 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965454AbcBQW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:26:10 -0500
Received: (qmail 14007 invoked by uid 102); 17 Feb 2016 22:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 17:26:10 -0500
Received: (qmail 13124 invoked by uid 107); 17 Feb 2016 22:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 17:26:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2016 17:26:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286562>

On Wed, Feb 17, 2016 at 02:19:39PM -0800, Junio C Hamano wrote:

> So, is everybody happy with this round?
> 
> With another series on top for the "conditional" stuff, I guess we
> are ready to do the formatting for "git branch --list", which would
> be a big step forward.

I have not looked with nearly as close an eye as Eric, but I did not see
anything objectionable (and I trust the reviews that have led us up to
v6 in the first place).

Thanks, Karthik, for your continued work on this (and to reviewers, of
course :) ).

-Peff
