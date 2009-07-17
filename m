From: Jeff King <peff@peff.net>
Subject: Re: cvs import and internal plumbing commands
Date: Fri, 17 Jul 2009 17:45:23 -0400
Message-ID: <20090717214523.GA29955@coredump.intra.peff.net>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRvFE-0001Yn-VR
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 23:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898AbZGQVp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 17:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbZGQVp3
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 17:45:29 -0400
Received: from peff.net ([208.65.91.99]:39794 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887AbZGQVp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 17:45:29 -0400
Received: (qmail 29318 invoked by uid 107); 17 Jul 2009 21:47:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 17:47:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 17:45:23 -0400
Content-Disposition: inline
In-Reply-To: <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123491>

On Sat, Jul 18, 2009 at 09:44:08AM +1200, Antony Stubbs wrote:

> >The old style commands should be in the execdir (e.g.,
> >/usr/local/libexec/git-core). That directory should be placed at the
> >beginning of the PATH when you run "git cvsimport".
> 
> Ok cool, I'll have a look when I get home.
> 
> But should we not migrate it for the future anyway? An at least that
> way it would work by default, in this environment?

Yes, I think it is reasonable to migrate it in any case, if only because
it serves as an example when people read it, and we are trying to
encourage the dashless form.

-Peff
