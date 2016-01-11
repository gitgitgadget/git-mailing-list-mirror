From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared
 repositories
Date: Mon, 11 Jan 2016 15:22:43 -0500
Message-ID: <20160111202243.GA14289@sigill.intra.peff.net>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
 <cover.1452537321.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:26:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIj3K-0000OV-8A
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbcAKUWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 15:22:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:51557 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965167AbcAKUWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 15:22:46 -0500
Received: (qmail 11996 invoked by uid 102); 11 Jan 2016 20:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 15:22:46 -0500
Received: (qmail 4993 invoked by uid 107); 11 Jan 2016 20:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 15:23:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 15:22:43 -0500
Content-Disposition: inline
In-Reply-To: <cover.1452537321.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283713>

On Mon, Jan 11, 2016 at 07:35:42PM +0100, Johannes Schindelin wrote:

> Transient files, e.g. commit messages, are writable only by the owner,
> even in shared repositories, to avoid interference between competing
> users working on the same files.
> 
> These files are typically not deleted after use. As a consequence, we
> have to delete such files before writing when they are owned by someone
> else than the current user.
> 
> The only change relative to v2 is that the second commit message
> clarifies why apply, fsck and fast-import are left unchanged.

This looks fine to me. Even if if there are sites that could also use
conversion, this is a strict improvement, and we can revisit the other
ones in the future.

Thanks.

-Peff
