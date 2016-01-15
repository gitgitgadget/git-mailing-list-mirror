From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/21] Peace with CRLF
Date: Fri, 15 Jan 2016 14:10:51 -0500
Message-ID: <20160115191051.GA11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:11:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK9m4-0003PX-CT
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 20:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbcAOTK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 14:10:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:54574 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755234AbcAOTKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 14:10:54 -0500
Received: (qmail 7358 invoked by uid 102); 15 Jan 2016 19:10:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 14:10:53 -0500
Received: (qmail 22854 invoked by uid 107); 15 Jan 2016 19:11:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 14:11:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 14:10:51 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284201>

On Thu, Jan 14, 2016 at 03:58:15PM -0800, Junio C Hamano wrote:

>  - The update to mktree used "lf_lines" in the preview, but this
>    version flips it to the same "nul_term_line" to match other two,
>    even though I think the latter is a terrible variable name with
>    bad taste.

Heh. I also dislike that variable name, but not want to nit-pick when
reading the preview.

I think just "use_nul_terminator" or something would be fine. It is
really the "line" which bugs me, because they are not really lines
anymore.

-Peff
