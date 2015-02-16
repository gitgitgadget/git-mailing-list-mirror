From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] test updates around diff
Date: Mon, 16 Feb 2015 01:23:05 -0500
Message-ID: <20150216062305.GE32381@peff.net>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNF5N-0002in-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbbBPGXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:23:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:49420 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbbBPGXI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:23:08 -0500
Received: (qmail 9628 invoked by uid 102); 16 Feb 2015 06:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:23:08 -0600
Received: (qmail 12611 invoked by uid 107); 16 Feb 2015 06:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:23:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:23:05 -0500
Content-Disposition: inline
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263882>

On Sun, Feb 15, 2015 at 03:43:38PM -0800, Junio C Hamano wrote:

> This is primarily to update t4008 that will have to be updated in
> the course of "diff -B -M" work to modern standard and also make it
> easier to be used as the test bed.

I gave this a once-over and they all look sane. I agree with the logic
in 5/6 that tests which do not care about the exact object names should
just be using "--name-status" or similar.

Thanks for a pleasant and easy read. :)

-Peff
