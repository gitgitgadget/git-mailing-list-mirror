From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/4] Some cleanups
Date: Wed, 30 Mar 2016 13:25:38 -0400
Message-ID: <20160330172538.GC19675@sigill.intra.peff.net>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sunshine@sunshineco.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:26:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJsM-0001Uc-J2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcC3RZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:40980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754744AbcC3RZl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:25:41 -0400
Received: (qmail 10780 invoked by uid 102); 30 Mar 2016 17:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:25:40 -0400
Received: (qmail 4720 invoked by uid 107); 30 Mar 2016 17:25:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:25:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 13:25:38 -0400
Content-Disposition: inline
In-Reply-To: <1459357518-14913-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290326>

On Wed, Mar 30, 2016 at 10:05:14AM -0700, Stefan Beller wrote:

> v2:
> Thanks Eric, Jeff, Junio for discussion, I picked up all hints and here
> is a v2.
> 
> * drop the overallocation patches (1&2)
> * use git_config_get_string instead of its _const equivalent, such that
>   we don't need a cast when freeing in git_config_get_notes_strategy
> * Use strbuf_list_free instead of cooking our own.
> * have a dedicated error exit path in bundle.c, create_bundle

I'm OK with all of these as-is, though I did mention a nit in the third
one. I also like Junio's rewrite instead of using strbuf_list_free.

-Peff
