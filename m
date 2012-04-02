From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] fetch-pack: new --stdin option to read refs from
 stdin
Date: Mon, 2 Apr 2012 16:42:21 -0400
Message-ID: <20120402204220.GC26503@sigill.intra.peff.net>
References: <4F79C195.6090905@gmx.net>
 <4F79C22C.9080702@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEo55-00069I-OI
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2DBUmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:42:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43530
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab2DBUmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:42:22 -0400
Received: (qmail 21079 invoked by uid 107); 2 Apr 2012 20:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 16:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 16:42:21 -0400
Content-Disposition: inline
In-Reply-To: <4F79C22C.9080702@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194558>

On Mon, Apr 02, 2012 at 05:13:48PM +0200, Ivan Todoroski wrote:

> +		else {
> +			/* read from stdin one ref per line, until EOF */
> +			struct strbuf line;
> +			strbuf_init(&line, 0);

A minor style nit, but we usually spell this:

  struct strbuf line = STRBUF_INIT;

Other than that, this version looks good to me. Thanks.

-Peff
