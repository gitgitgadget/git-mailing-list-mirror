From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test_must_fail: compare exit_code using integer -eq
 operator
Date: Sat, 28 Nov 2015 11:58:07 -0500
Message-ID: <20151128165806.GA27264@sigill.intra.peff.net>
References: <565630A4.7070205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 17:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2ipA-0004qF-ML
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 17:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbbK1Q6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 11:58:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:34673 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752192AbbK1Q6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 11:58:09 -0500
Received: (qmail 18532 invoked by uid 102); 28 Nov 2015 16:58:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 10:58:09 -0600
Received: (qmail 23418 invoked by uid 107); 28 Nov 2015 16:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:58:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 11:58:07 -0500
Content-Disposition: inline
In-Reply-To: <565630A4.7070205@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281788>

On Wed, Nov 25, 2015 at 10:05:24PM +0000, Ramsay Jones wrote:

> Hi Jeff,
> 
> Can we squash this into your fixup?

I think it's a good thing to do, but I had figured it could be a
separate patch (especially since it is touching lines that are otherwise
unchanged by the patch). Looks like Lars folded it into his patch,
though, and I am OK with that, too.

-Peff
