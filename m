From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 14:53:46 -0500
Message-ID: <20160118195346.GA9337@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <20160118195159.GD1009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:53:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFsA-0006g6-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 20:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609AbcARTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 14:53:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:55605 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755979AbcARTxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 14:53:48 -0500
Received: (qmail 31369 invoked by uid 102); 18 Jan 2016 19:53:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:53:48 -0500
Received: (qmail 13161 invoked by uid 107); 18 Jan 2016 19:54:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 14:54:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 14:53:46 -0500
Content-Disposition: inline
In-Reply-To: <20160118195159.GD1009@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284309>

On Mon, Jan 18, 2016 at 02:51:59PM -0500, Jeff King wrote:

> It would be nice to also test that
> "git ls-remote --symrefs --heads" shows "refs/heads/foo" as a symref.
> But that cannot work with the current code, because upload-pack only
> tells us about the symref HEAD, and not any others.

Actually, I wonder if it is worth making a note of that in the new
"--symref" documentation, so people do not report it is a bug that
"ls-remote" does not show it. :)

-Peff
