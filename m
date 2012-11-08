From: Jeff King <peff@peff.net>
Subject: Re: [PATCH as/check-ignore] t0007: fix tests on Windows
Date: Thu, 8 Nov 2012 13:04:45 -0500
Message-ID: <20121108180445.GL15560@sigill.intra.peff.net>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 <5096D92A.7090600@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWWTP-0000et-IB
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 19:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab2KHSEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 13:04:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36531 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756533Ab2KHSEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 13:04:49 -0500
Received: (qmail 31418 invoked by uid 107); 8 Nov 2012 18:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 13:05:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 13:04:45 -0500
Content-Disposition: inline
In-Reply-To: <5096D92A.7090600@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209180>

On Sun, Nov 04, 2012 at 10:07:54PM +0100, Johannes Sixt wrote:

> The value of $global_excludes is sometimes part of the output
> that is tested for. Since git on Windows only sees DOS style paths,
> we have to ensure that the "expected" values are constructed in
> the same manner. To account for this, use $(pwd) to set the value
> of global_excludes.
> 
> Additionally, add a SYMLINKS prerequisite to the tests involving
> symbolic links.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thanks. I put this on top of as/check-ignore in 'pu' for reference, but
I am still expecting a re-roll from Adam or Duy at some point.

-Peff
