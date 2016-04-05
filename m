From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon, 4 Apr 2016 21:52:34 -0400
Message-ID: <20160405015234.GB29953@sigill.intra.peff.net>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:04:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anGLd-0006tx-3c
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 04:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbcDEBwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:52:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:44184 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756607AbcDEBwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:52:45 -0400
Received: (qmail 23289 invoked by uid 102); 5 Apr 2016 01:52:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:52:39 -0400
Received: (qmail 32388 invoked by uid 107); 5 Apr 2016 01:52:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 21:52:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 21:52:34 -0400
Content-Disposition: inline
In-Reply-To: <1459817917-32078-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290753>

On Mon, Apr 04, 2016 at 05:58:37PM -0700, Junio C Hamano wrote:

> +count_expand ()
> +{

This function takes a lot of unnamed arguments that we process with
"shift". It might be nice to give a brief comment describing them.

> +test_expand ""
> +test_expand --pretty
> +test_expand --pretty=short
> +test_expand --pretty=medium
> +test_expand --pretty=full
> +test_expand --pretty=fuller
> +test_expand --pretty=fuller
> +test_expand --pretty=raw
> +test_expand --pretty=email

Duplicated fuller?

-Peff
