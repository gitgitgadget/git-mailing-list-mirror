From: Jeff King <peff@peff.net>
Subject: Re: git status internals and line endings
Date: Thu, 12 Nov 2009 19:15:47 -0500
Message-ID: <20091113001547.GB28836@sigill.intra.peff.net>
References: <4AFC70CE.5020106@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 01:15:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8jpT-0000PP-TT
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 01:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbZKMAPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 19:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755908AbZKMAPo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 19:15:44 -0500
Received: from peff.net ([208.65.91.99]:46346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815AbZKMAPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 19:15:44 -0500
Received: (qmail 24649 invoked by uid 107); 13 Nov 2009 00:19:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 12 Nov 2009 19:19:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Nov 2009 19:15:47 -0500
Content-Disposition: inline
In-Reply-To: <4AFC70CE.5020106@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132806>

On Thu, Nov 12, 2009 at 09:32:14PM +0100, Marc Strapetz wrote:

> On Linux, file1 and file3 are reported as modified -- as I would expect.
> The surprise is on Windows: here only file1 is reported as modified. Why
> not file3? Btw, 'git hash-object file3' reports the same SHA as for the
> LF-only content in the repository (not so on Linux, as expected).
> 
> Is this some special handling on Windows (and possibly on Mac OS)? In
> this case, can someone please point me to the corresponding code part?
> Thanks for any comments regarding this topic.

Sounds like the core.autocrlf setting (see "git help config"), which I
believe is set by default on Windows.

-Peff
