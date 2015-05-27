From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 05/11] transport: add infrastructure to support a
 protocol version number
Date: Wed, 27 May 2015 02:39:25 -0400
Message-ID: <20150527063925.GC885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxV00-0005h4-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbbE0Gj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:39:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:36474 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751417AbbE0Gj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:39:27 -0400
Received: (qmail 31446 invoked by uid 102); 27 May 2015 06:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:39:27 -0500
Received: (qmail 4875 invoked by uid 107); 27 May 2015 06:39:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:39:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:39:25 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270024>

On Tue, May 26, 2015 at 03:01:09PM -0700, Stefan Beller wrote:

> +	OPT_STRING('y', "transport-version", &transport_version,
> +		   N_("transport-version"),
> +		   N_("specify transport version to be used")),

Interesting choice for the short option ("-v" would be nice, but
obviously it is taken). Do we want to delay on claiming the
short-and-sweet 'y' until we are sure this is something people will use
a lot? In an ideal world, it is not (i.e., auto-upgrade and other tricks
become good enough that nobody bothers to specify it manually).

-Peff
