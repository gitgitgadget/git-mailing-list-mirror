From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: git commit -a -o ...
Date: Fri, 26 Jun 2009 02:34:35 -0400
Message-ID: <20090626063435.GA12283@coredump.intra.peff.net>
References: <F9B3FF44-FC23-4ADA-A933-9BED857AB469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 08:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK51N-0005hD-2B
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 08:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbZFZGek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 02:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbZFZGej
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 02:34:39 -0400
Received: from peff.net ([208.65.91.99]:42176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbZFZGei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 02:34:38 -0400
Received: (qmail 28526 invoked by uid 107); 26 Jun 2009 06:36:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 26 Jun 2009 02:36:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2009 02:34:35 -0400
Content-Disposition: inline
In-Reply-To: <F9B3FF44-FC23-4ADA-A933-9BED857AB469@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122282>

On Thu, Jun 25, 2009 at 04:39:32PM -0400, David Reitter wrote:

> I'm wondering why "git commit -a -o *" is not supported.
> With this command I'd like to commit the intersection of all changed,
> tracked files and those in the current directory.
> 
> I found that "git commit ." does what I want and it even detects
> deleted files (excellent, thank you).

I don't understand what "-a" is supposed to be doing there. It means
"all tracked files in the whole repo".  But from your "git commit ."
example, it sounds like you just want "git commit -o *" (in fact, "git
commit ." is more or less equivalent (with the except of dot-files) to
"git commit *", which is in turn the same as "git commit -o *").

Can you be more clear about the set of files you have, the set you want
to commit, and how "git commit" differs from your expectations?

-Peff
