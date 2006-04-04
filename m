From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 04 Apr 2006 11:32:29 -0400
Message-ID: <1144164749.30675.12.camel@dv>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	 <20060404082002.GJ4663@admingilde.org>
	 <81b0412b0604040217s3b8863d3w1b79400c42ca2b90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 17:33:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQnWK-00020H-AY
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 17:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDDPch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 11:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDDPch
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 11:32:37 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:8910 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750712AbWDDPch
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 11:32:37 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FQnWD-0001A0-GG
	for git@vger.kernel.org; Tue, 04 Apr 2006 11:32:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FQnWA-00085F-8y; Tue, 04 Apr 2006 11:32:30 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0604040217s3b8863d3w1b79400c42ca2b90@mail.gmail.com>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18393>

On Tue, 2006-04-04 at 11:17 +0200, Alex Riesen wrote:
> On 4/4/06, Martin Waitz <tali@admingilde.org> wrote:
> > What is the use case of cleaning up all untracked files without also
> > cleaning ignored files?
> 
> Thinks of git's .gitignore: it has config.mak in it. Are you sure you want
> "clean" your build customizations?

In may case, I normally want to remove copies of the sources.  For
example, I take foo.c, make a clean copy of it, then I change and test
it.  If if doesn't work and I want to try another approach, I copy it to
foo.c-bad or foo.c-approach1.  I also make diffs between files to see
what exactly I changed.  I may also create files for output, valgrind
logs and so on.

At some point, I'm satisfied with foo.c, so I commit it.  Then I want to
remove copies, diffs and other stuff.  Yet I don't want to rebuild
everything.

It's very rare that I add a new file, and I always remember to add it to
the version control.  But I'll consider adding an option to only remove
ignored files.

-- 
Regards,
Pavel Roskin
