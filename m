From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] argv_array: add argv_array_copy
Date: Thu, 6 Aug 2015 14:52:22 -0400
Message-ID: <20150806185221.GA1444@sigill.intra.peff.net>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
 <1438882524-21215-4-git-send-email-sbeller@google.com>
 <CAPig+cQ3bAML7WMyS3Q1YQCjR2SfgB47AEkTmqbycAJcig0=tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:52:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNQHN-0005Md-HL
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbbHFSw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:52:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:41639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753269AbbHFSw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:52:26 -0400
Received: (qmail 17959 invoked by uid 102); 6 Aug 2015 18:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 13:52:26 -0500
Received: (qmail 6775 invoked by uid 107); 6 Aug 2015 18:52:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Aug 2015 14:52:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2015 14:52:22 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ3bAML7WMyS3Q1YQCjR2SfgB47AEkTmqbycAJcig0=tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275437>

On Thu, Aug 06, 2015 at 02:18:26PM -0400, Eric Sunshine wrote:

> However, that begs the question: Why do you need argv_array_copy() at
> all? Isn't the same functionality already provided by
> argv_array_pushv()? To wit, a caller which wants to copy from 'src' to
> 'dst' can already do:
> 
>     struct argv_array src = ...;
>     struct argv_array dst = ARGV_ARRAY_INIT;
>     argv_array_pushv(&dst, src->argv);

Thanks for reviewing this, Eric. Everything you said is exactly what I
was thinking, too, especially this last part.

-Peff
