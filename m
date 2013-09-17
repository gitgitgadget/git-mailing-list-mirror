From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 18:03:45 -0400
Message-ID: <20130917220345.GA22914@sigill.intra.peff.net>
References: <20130917190659.GA15588@pengutronix.de>
 <xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
 <20130917201259.GB16860@sigill.intra.peff.net>
 <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
 <20130917202917.GA20020@sigill.intra.peff.net>
 <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
 <20130917212106.GB20178@sigill.intra.peff.net>
 <xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 00:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3NF-0004Dx-0y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 00:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3IQWDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 18:03:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:48340 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab3IQWDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 18:03:52 -0400
Received: (qmail 27034 invoked by uid 102); 17 Sep 2013 22:03:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 17:03:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 18:03:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234936>

On Tue, Sep 17, 2013 at 03:00:41PM -0700, Junio C Hamano wrote:

> > So given that, is it fair to say that a one-way "go here" merge, limited
> > by pathspec, is the closest equivalent?
> 
> Sorry, but it is unclear to me what you mean by one-way "go here"
> merge.  Do you mean oneway_merge() in unpack-trees.c?

Yes, that is what I meant.

In my mind, oneway_merge is "go here unconditionally", twoway_merge is
"go from A to B, respecting changes already made from A", and
threeway_merge is a "real" merge. But I am not sure if that is accurate
or just my confused mental model of unpack-trees. :)

-Peff
