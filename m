From: Jeff King <peff@peff.net>
Subject: Re: automatically removing missing files beneath a directory
Date: Thu, 8 May 2008 13:18:43 -0400
Message-ID: <20080508171843.GA29607@sigill.intra.peff.net>
References: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com> <20080508164456.GA29103@sigill.intra.peff.net> <7f9d599f0805081012ke0b342ct55a3aac1b37b158a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu May 08 19:19:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9mG-0004Mo-0l
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759495AbYEHRSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758602AbYEHRSl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:18:41 -0400
Received: from peff.net ([208.65.91.99]:1093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbYEHRSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:18:40 -0400
Received: (qmail 8457 invoked by uid 111); 8 May 2008 17:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 13:18:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 13:18:43 -0400
Content-Disposition: inline
In-Reply-To: <7f9d599f0805081012ke0b342ct55a3aac1b37b158a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81541>

On Thu, May 08, 2008 at 10:12:56AM -0700, Geoffrey Irving wrote:

> Cool.  "git add -u && git add ." does exactly what I want.
> 
> This is only indirectly mentioned in the documentation.  If you think
> it's reasonable to mention it more explicitly, I've attached a patch.

Yeah, the term "update" is not really defined there. I actually prefer
to mention it even earlier in the paragraph; does this make sense to
you?

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 35e67a0..e2389e3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -71,7 +71,9 @@ OPTIONS
 	the specified filepatterns before exiting.
 
 -u::
-	Update only files that git already knows about. This is similar
+	Update only files that git already knows about, staging modified
+	content for commit and marking deleted files for removal. This
+	is similar
 	to what "git commit -a" does in preparation for making a commit,
 	except that the update is limited to paths specified on the
 	command line. If no paths are specified, all tracked files in the
