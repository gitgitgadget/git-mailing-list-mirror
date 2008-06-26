From: "Flavio Poletti" <flavio@polettix.it>
Subject: Re: git-diff/git-format-patch safe for GNU (or POSIX) patch?
Date: Thu, 26 Jun 2008 13:49:49 +0200 (CEST)
Message-ID: <58284.213.203.159.164.1214480989.squirrel@upmail.polettix.it>
References: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it>
    <20080626103607.GA16525@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 13:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpmm-0004uM-Hc
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbYFZLgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbYFZLgM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:36:12 -0400
Received: from [195.130.249.251] ([195.130.249.251]:56862 "HELO desantix.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1755042AbYFZLgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:36:11 -0400
Received: (qmail 6746 invoked by uid 511); 26 Jun 2008 11:49:49 -0000
Received: from localhost (HELO upmail.polettix.it) (127.0.0.1)
  by localhost with SMTP; 26 Jun 2008 11:49:49 -0000
Received: from 213.203.159.164
        (SquirrelMail authenticated user flavio@polettix.it)
        by upmail.polettix.it with HTTP;
        Thu, 26 Jun 2008 13:49:49 +0200 (CEST)
In-Reply-To: <20080626103607.GA16525@diana.vm.bytemark.co.uk>
User-Agent: SquirrelMail/1.4.6
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86436>

Thanks for the feedback! I wonder if this feature of patch "ignoring"
stuff it doesn't understand is a GNU feature or a POSIX feature, but I'm
abusing your patience here. (Incidentally, I also saw that POSIX has no
"unified" format, but this "ignoring" feature might apply in a wider
sense).

>> 4. some hints to use git for working on projects that do not use any
>> other VCS, or for which one only wants to produce and send a quick
>> patch starting from a tarball.
>
> You can use git/contrib/fast-import/import-tars.perl to import the
> last few releases into git (possibly just the last release, if you
> don't need the history) and then just build on that, and send patches
> back to the project when you're done.
>
> When the project makes another release, use import-tars to import the
> new tarball, and then rebase if you have any patches they haven't
> accepted yet.

Importing wasn't actually an issue, just a matter of init/add/commit. I
was more scared about the patch production process, i.e. producing a patch
that could be perfectly usable by the project's maintainers. But given
what you kindly said, I think I can dismiss this as excess of caution by
me.

Thanks,

   Flavio.
