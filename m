From: Jeff King <peff@peff.net>
Subject: Re: git-repack keeps running out of memory
Date: Mon, 1 Jun 2015 16:58:54 -0400
Message-ID: <20150601205854.GA21144@peff.net>
References: <556CA6C8.6000804@ubuntu.com>
 <xmqqlhg35ky2.fsf@gitster.dls.corp.google.com>
 <556CAD64.8000208@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:59:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzWnW-00061W-NT
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 22:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbbFAU67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 16:58:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:39148 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751891AbbFAU65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 16:58:57 -0400
Received: (qmail 1018 invoked by uid 102); 1 Jun 2015 20:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 15:58:57 -0500
Received: (qmail 2212 invoked by uid 107); 1 Jun 2015 20:58:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 16:58:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 16:58:54 -0400
Content-Disposition: inline
In-Reply-To: <556CAD64.8000208@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270471>

On Mon, Jun 01, 2015 at 03:07:16PM -0400, Phil Susi wrote:

> It's more the --window-memory argument that is important here: it is
> supposed to prevent exactly this problem.  I guess I tried adding the
> --max-pack-size as well on the off chance that it would help.

How many processors do you have? The window-memory is per-thread. Try
with --threads=1.

-Peff
