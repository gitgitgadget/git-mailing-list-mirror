From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Wed, 16 Sep 2015 06:33:50 -0400
Message-ID: <20150916103350.GF13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152629.GH29753@sigill.intra.peff.net>
 <55F84D9B.90004@ramsayjones.plus.com>
 <20150915175027.GA31091@sigill.intra.peff.net>
 <xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
 <c62ef479c559cb040628fc4ede5b151b@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcA2T-0000ZC-45
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbIPKd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:33:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:59857 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbbIPKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:33:59 -0400
Received: (qmail 16900 invoked by uid 102); 16 Sep 2015 10:33:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:33:59 -0500
Received: (qmail 16623 invoked by uid 107); 16 Sep 2015 10:34:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:34:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:33:50 -0400
Content-Disposition: inline
In-Reply-To: <c62ef479c559cb040628fc4ede5b151b@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278017>

On Wed, Sep 16, 2015 at 10:15:02AM +0200, Johannes Schindelin wrote:

> Maybe we should stick to the established practice of the many, many
> reentrant POSIX functions following the *_r() naming convention? I.e.
> the reentrant version of localtime() is called localtime_r(), the
> reentrant version of random() is called random_r() etc.
> 
> So I could see myself not needing an explanation if I had read
> sha1_to_hex_r(...).

I like this suggestion. By itself, the "_r" does not communicate as much
as "_to" to me, but as long as the reader knows the "_r" idiom, it
communicates much more.

I'll switch to this unless there is any objection.

-Peff
