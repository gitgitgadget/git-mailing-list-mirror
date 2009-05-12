From: Jeff King <peff@peff.net>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 12:16:38 -0400
Message-ID: <20090512161638.GB29566@coredump.intra.peff.net>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 12 18:17:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ufB-00076N-Cl
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZELQQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756991AbZELQQn
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:16:43 -0400
Received: from peff.net ([208.65.91.99]:53572 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbZELQQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:16:39 -0400
Received: (qmail 31986 invoked by uid 107); 12 May 2009 16:17:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 May 2009 12:17:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2009 12:16:38 -0400
Content-Disposition: inline
In-Reply-To: <20090512151403.GS30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118917>

On Tue, May 12, 2009 at 08:14:03AM -0700, Shawn O. Pearce wrote:

> As for file names, no plans, its a sequence of bytes, but I think a
> lot of people wind up using some subset of US-ASCII for their file
> names, especially if their project is going to be cross platform.

Or they use a single encoding like utf8 so that there are no surprises.
You can still run into normalization problems with filenames on some
filesystems, though.  Linus's name_hash code sets up the framework to
handle "these two names are actually equivalent", but right now I think
there is just code for handling case-sensitivity, not utf8 normalization
(but I just skimmed the code, so I might be wrong).

-Peff
