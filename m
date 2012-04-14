From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Re: i18n: use test_i18ncmp in t2020 (checkout
 --detach)
Date: Sat, 14 Apr 2012 04:15:51 -0400
Message-ID: <20120414081551.GB11124@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
 <20120414044413.GA1791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:16:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIy9P-0003tO-30
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 10:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab2DNIQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 04:16:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33910
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851Ab2DNIP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 04:15:58 -0400
Received: (qmail 27120 invoked by uid 107); 14 Apr 2012 08:16:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Apr 2012 04:16:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Apr 2012 04:15:51 -0400
Content-Disposition: inline
In-Reply-To: <20120414044413.GA1791@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195479>

On Fri, Apr 13, 2012 at 11:44:13PM -0500, Jonathan Nieder wrote:

> Here's a series doing that.  Patch 3 is a bonus patch unrelated to the
> cause: it fixes a test buglet noticed while working on the other two.
> 
> Jonathan Nieder (3):
>   test: do not rely on US English tracking-info messages
>   test: use test_i18ncmp for "Patch format detection failed" message
>   test: am of empty patch should not succeed

Thanks, all 3 look reasonable to me (the code you are replacing in the
third one is sufficiently confusing-looking that I wondered if something
else was going on, but I can't see anything, and the original thread has
no more discussion).

-Peff
