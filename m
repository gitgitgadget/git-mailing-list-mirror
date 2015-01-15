From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/10] urlmatch.c: make match_urls() static
Date: Thu, 15 Jan 2015 01:49:39 -0500
Message-ID: <20150115064939.GD11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
 <1421278855-8126-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBeFX-0002jq-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbbAOGtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:49:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:34815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751079AbbAOGtm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:49:42 -0500
Received: (qmail 20584 invoked by uid 102); 15 Jan 2015 06:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 00:49:42 -0600
Received: (qmail 10446 invoked by uid 107); 15 Jan 2015 06:50:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:50:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 01:49:39 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262461>

On Wed, Jan 14, 2015 at 03:40:50PM -0800, Junio C Hamano wrote:

> No external callers exist.

I think there was some notion that we might use this elsewhere (e.g., to
harmonize the credential.* and http.* config matching  rules). But I do
not have any plans to work on that soon, and I am not even sure what
interface would be needed, so it's reasonable to make this static in the
interim.

-Peff
