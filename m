From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] config: Cleanup config file handling.
Date: Sun, 15 Feb 2009 15:15:06 -0500
Message-ID: <20090215201505.GC26779@coredump.intra.peff.net>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 21:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnPp-00024I-NH
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZBOUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 15:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZBOUPJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:15:09 -0500
Received: from peff.net ([208.65.91.99]:59791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZBOUPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 15:15:08 -0500
Received: (qmail 9893 invoked by uid 107); 15 Feb 2009 20:15:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 15:15:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 15:15:06 -0500
Content-Disposition: inline
In-Reply-To: <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110054>

On Sun, Feb 15, 2009 at 11:00:54AM +0200, Felipe Contreras wrote:

> As suggested by Johannes Schindelin.

Thank you for splitting this patch up. I have to admit I was too scared
to read the original after seeing the diffstat.

But part of the nice thing about splitting up is that you can write
meaningful commit messages for each individual change. Reading this
commit message, I don't know what to expect.

Your 1/8, though short, tells me what to expect: a trivial rename. But
"clean up config file handling" is quite ambiguous. And after reading
the patch, I am left wondering why the filename and errno are not useful
as part of the die() message. I think even a single sentence would
probably make it clear.

And yes, I know I can look elsewhere in the thread to find the
discussion between you and Dscho. But think of the poor "git log" user
six months from now.

-Peff
