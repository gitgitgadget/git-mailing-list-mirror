From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] cvsimport: new -R option: generate
 .git/cvs-revisions mapping
Date: Sun, 7 Feb 2010 00:10:53 -0500
Message-ID: <20100207051053.GA17118@coredump.intra.peff.net>
References: <bc341e101002061026t2e7fa4cfte9119bf7fc2d2ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 07 06:10:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdzQ9-0005Ef-RY
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 06:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab0BGFKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 00:10:53 -0500
Received: from peff.net ([208.65.91.99]:51422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab0BGFKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 00:10:52 -0500
Received: (qmail 14374 invoked by uid 107); 7 Feb 2010 05:10:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 07 Feb 2010 00:10:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Feb 2010 00:10:53 -0500
Content-Disposition: inline
In-Reply-To: <bc341e101002061026t2e7fa4cfte9119bf7fc2d2ddc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139219>

On Sat, Feb 06, 2010 at 06:26:24PM +0000, Aaron Crane wrote:

> I believe this revised patch takes account of all his comments.  In
> particular, compared to the previous version:
> 
> - Tests are included
> - Now works with incremental import
> - The file is always generated as .git/cvs-revisions, rather than
>   letting the user pick the name

Thanks, it looks much better.

Acked-by: Jeff King <peff@peff.net>

-Peff
