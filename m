From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] mark private symbols static
Date: Thu, 15 Jan 2015 02:18:27 -0500
Message-ID: <20150115071827.GG11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 08:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBehO-0003Rp-EV
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 08:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbbAOHSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 02:18:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:34832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751176AbbAOHS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 02:18:29 -0500
Received: (qmail 23086 invoked by uid 102); 15 Jan 2015 07:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:18:30 -0600
Received: (qmail 10703 invoked by uid 107); 15 Jan 2015 07:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 02:18:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 02:18:27 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262465>

On Wed, Jan 14, 2015 at 03:40:45PM -0800, Junio C Hamano wrote:

> Here are a handful of patches to make symbols that are only used
> within a .c file as static.  This is not the kind of changes we
> would want to do in the pre-release freeze period, and it is just
> for reference.  I may later come back to them after 2.3 final is
> tagged.

I commented specifically on the ones that are in areas I touch a lot,
but all of them look fine to me.

-Peff
