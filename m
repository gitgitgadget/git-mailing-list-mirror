From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Tue, 1 Apr 2014 03:38:48 -0400
Message-ID: <20140401073848.GA22023@sigill.intra.peff.net>
References: <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
 <20140327224837.GB32434@sigill.intra.peff.net>
 <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
 <20140328184710.GA29987@sigill.intra.peff.net>
 <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
 <20140328190548.GB30739@sigill.intra.peff.net>
 <xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 09:39:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUtHd-0006SD-6e
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 09:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaDAHiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 03:38:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:51537 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbaDAHiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 03:38:50 -0400
Received: (qmail 10805 invoked by uid 102); 1 Apr 2014 07:38:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 02:38:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 03:38:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245572>

On Fri, Mar 28, 2014 at 12:30:02PM -0700, Junio C Hamano wrote:

> Let's just deal with a simple known cases (like FreeBSD) in the real
> code that everybody exercises at runtime, and have the new test only
> check we do not segfault on a value we used to segfault upon seeing.

OK. Here it is, with the other option as an "alt" patch for reference.

  [1/2]: date: recognize bogus FreeBSD gmtime output
  [2/2]: t4212: loosen far-in-future test for AIX
  [2alt/2]: work around unreliable gmtime errors on AIX

-Peff
