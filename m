From: Jeff King <peff@peff.net>
Subject: Re: cvs import and internal plumbing commands
Date: Thu, 16 Jul 2009 06:01:21 -0400
Message-ID: <20090716100121.GA6742@coredump.intra.peff.net>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 12:01:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRNmQ-0000eR-T7
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 12:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbZGPKB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZGPKB0
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 06:01:26 -0400
Received: from peff.net ([208.65.91.99]:47556 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbZGPKBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 06:01:25 -0400
Received: (qmail 19729 invoked by uid 107); 16 Jul 2009 10:03:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Jul 2009 06:03:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jul 2009 06:01:21 -0400
Content-Disposition: inline
In-Reply-To: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123394>

On Sun, Jul 05, 2009 at 02:43:01PM +1200, Antony Stubbs wrote:

> I've got a new install from mac-ports and am having trouble with cvs
> import not finding the plumbing commands.
> 
> It seems that cvsimport still uses all the old style git-hash-object
> type commands, instead of the new " git hash-object" command style.
> And on my system, I don't have any of the old style commands.

The old style commands should be in the execdir (e.g.,
/usr/local/libexec/git-core). That directory should be placed at the
beginning of the PATH when you run "git cvsimport".

If you run "git --exec-path", what directory does it print? If you go to
that directory, is it filled with dashed git commands?

-Peff
