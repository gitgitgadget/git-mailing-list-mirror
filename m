From: Jeff King <peff@peff.net>
Subject: Re: lib-httpd/apache.conf and mod_unixd.so
Date: Sun, 12 Jun 2016 09:00:44 -0400
Message-ID: <20160612130044.GB15289@sigill.intra.peff.net>
References: <CACsJy8D8e2R9YZGGFQR-AC0OtWWYriuJoTmvtG4VuqdfPZGXeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 15:00:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC50a-0004jL-Db
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 15:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcFLNAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 09:00:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:53457 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbcFLNAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 09:00:52 -0400
Received: (qmail 16000 invoked by uid 102); 12 Jun 2016 13:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 09:00:46 -0400
Received: (qmail 6527 invoked by uid 107); 12 Jun 2016 13:00:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 09:00:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jun 2016 09:00:44 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8D8e2R9YZGGFQR-AC0OtWWYriuJoTmvtG4VuqdfPZGXeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297136>

On Sun, Jun 12, 2016 at 05:48:42PM +0700, Duy Nguyen wrote:

> A quick search shows that loading mod_unixd.so will do (and did make
> httpd run for me). Problem is, can I just update apache.conf to load
> it when apache version >= 2.4? I don't know if doing that would cause
> failure for other people because mod_unixd has existed since 2.2 and
> people have run httpd tests fine so far...

Are you running a version that has 5922322 (t/lib-httpd: load mod_unixd,
2015-05-11)?

-Peff
