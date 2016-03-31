From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/4] notes: don't leak memory in
 git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 21:06:04 -0400
Message-ID: <20160331010604.GA23999@sigill.intra.peff.net>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
 <1459357518-14913-2-git-send-email-sbeller@google.com>
 <CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
 <xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 03:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alR3z-0001jV-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 03:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbcCaBGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 21:06:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:41312 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752525AbcCaBGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 21:06:08 -0400
Received: (qmail 6638 invoked by uid 102); 31 Mar 2016 01:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 21:06:07 -0400
Received: (qmail 9787 invoked by uid 107); 31 Mar 2016 01:06:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 21:06:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 21:06:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290364>

On Wed, Mar 30, 2016 at 02:07:14PM -0700, Junio C Hamano wrote:

> This is a tangent, but am I the only one who finds that the naming
> of functions in config-get API is confusing?  Just wondering if we
> should rename the ones that keeps the memory ownership to the config
> subsystem with s/get/peek/ or something.

You are definitely not the only one.

I think the get/peek thing would help, but I also get confused between
git_config_string() and git_config_get_string().

-Peff
