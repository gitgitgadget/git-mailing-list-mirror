From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH v4 3/5] config: make parsing stack struct independent
 from actual data source
Date: Tue, 14 May 2013 04:35:51 +0200
Message-ID: <20130514023551.GB23146@sigill.intra.peff.net>
References: <20130511131721.GA17991@book-mint>
 <20130511132013.GD17991@book-mint>
 <7vfvxrscjc.fsf@alter.siamese.dyndns.org>
 <20130513140435.GC3561@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 14 04:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc55r-0004UG-9e
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 04:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab3ENCfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 22:35:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53425 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755376Ab3ENCfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 22:35:54 -0400
Received: (qmail 6194 invoked by uid 102); 14 May 2013 02:36:20 -0000
Received: from c-67-166-180-82.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.166.180.82)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 May 2013 21:36:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2013 04:35:51 +0200
Content-Disposition: inline
In-Reply-To: <20130513140435.GC3561@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224232>

On Mon, May 13, 2013 at 04:04:35PM +0200, Heiko Voigt wrote:

> > > -static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> > > +static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
> [...]
> I thought I recalled that Jeff asked me to change the name but I can
> not find the email, so maybe its just my wrong memory. I am happy to
> drop the rename here, if thats what you meant.

I think you are thinking of:

  http://thread.gmane.org/gmane.comp.version-control.git/217018/focus=217170

where I criticize the name. But I think the comment you added makes its
purpose much more clear, so the name is less important (and for the
record, I think "do_config" or "config_source_parse" would be fine,
too).

-Peff
