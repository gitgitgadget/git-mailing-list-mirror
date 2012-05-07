From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] correct git-status Porcelain Format documentation
Date: Mon, 7 May 2012 17:21:25 -0400
Message-ID: <20120507212125.GA19532@sigill.intra.peff.net>
References: <20120506132959.GA28214@sigill.intra.peff.net>
 <20120506135141.GA17176@sigill.intra.peff.net>
 <7vobpz6ewg.fsf@alter.siamese.dyndns.org>
 <20120507181348.GA26977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVN6-0006ca-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab2EGVV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:21:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33237
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab2EGVV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:21:27 -0400
Received: (qmail 27327 invoked by uid 107); 7 May 2012 21:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:21:25 -0400
Content-Disposition: inline
In-Reply-To: <20120507181348.GA26977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197308>

On Mon, May 07, 2012 at 02:13:48PM -0400, Jeff King wrote:

> I'll prepare a series to fix "-b -z" and "-b --porcelain".

Here's that series:

  [1/5]: commit: refactor option parsing
  [2/5]: status: refactor colopts handling
  [3/5]: status: refactor null_termination option
  [4/5]: status: fix null termination with "-b"
  [5/5]: status: respect "-b" for porcelain format

Patches 1 and 3 are cleanups to aid 4 and 5, which are the real fixes.
Patch 2 is an optional cleanup I noticed while in the area.

-Peff
