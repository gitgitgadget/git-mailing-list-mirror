From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Fri, 28 Mar 2014 14:50:18 -0400
Message-ID: <20140328185018.GB29987@sigill.intra.peff.net>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
 <20140326221531.11352.86408.chriscool@tuxfamily.org>
 <xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
 <20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
 <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
 <xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
 <20140327223406.GA32434@sigill.intra.peff.net>
 <xmqqha6jcl96.fsf@gitster.dls.corp.google.com>
 <20140327225658.GC32434@sigill.intra.peff.net>
 <xmqqzjkab634.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	mhagger@alum.mit.edu, dan.carpenter@oracle.com, greg@kroah.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:50:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTbrJ-0005FP-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaC1SuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:50:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:49492 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbaC1SuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:50:20 -0400
Received: (qmail 32532 invoked by uid 102); 28 Mar 2014 18:50:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 13:50:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 14:50:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjkab634.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245413>

On Fri, Mar 28, 2014 at 10:12:15AM -0700, Junio C Hamano wrote:

> By the way, that is "rfc2822"---do we want "rfc822" as its synonym
> as well as "rfc", I wonder ;-)

Oops, I wrote that as I was literally looking at the code that said
rfc2822 and didn't notice. On the other hand, I have never made the
mistake when actually running git, so it is probably not a big deal.

Besides which, isn't it 5322 these days? I do not think we need to keep
up with the treadmill.

-Peff
