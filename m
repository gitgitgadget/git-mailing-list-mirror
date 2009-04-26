From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH 0/2] Documentation: git-clean: description updates
Date: Sat, 25 Apr 2009 19:33:55 -0600
Organization: icecavern.net
Message-ID: <200904251933.56710.wjl@icecavern.net>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net> <7vhc0cxok0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 03:35:44 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxtHR-000584-FF
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 03:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZDZBeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 21:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbZDZBeG
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 21:34:06 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:54007 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751411AbZDZBeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 21:34:05 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id A97A1364B9;
	Sat, 25 Apr 2009 19:34:00 -0600 (MDT)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <7vhc0cxok0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117580>

On Saturday 25 April 2009 18:10:23 Junio C Hamano wrote:
> Thanks, will queue for 1.6.3, as I think both are clearly improvements.
>
> One could argue that the second one could be further improved, but I do
> not see anything controversial in it.

Okay, great! I'm all for incremental improvements, so please do hack my patch 
up if it helps!

>     This allows cleaning the working tree by removing files that are not
>     under version control.
>
>     Normally, only files unknown to git are removed, but if the '-x'
>     option is specified, ignored files are also removed. This can, for
>     example, be useful to remove all build products.
>
> The only iffy point I can see is that "unknown" is a bit fuzzy phrase in
> this context.  I know what you mean, but you are not writing for people
> who know what "git clean" does ;-)
>
> In the above, "unknown" refers to a set of files that is a strict subset
> of "untracked" files, excluding the "ignored" set.  But that is not
> defined anywhere in the glossary.
>
> Sometimes we colloquially say "files _known_ to git" to refer to "tracked"
> files (paths that appear in the index).  But your "files _unknown_ to git"
> is different from the complement of it.
>
> The saddest part is that "untracked files" is not defined in the glossary
> either.

Well, I wasn't sure how to canonically refer to "git that git does not track 
but also does not have ignore rules for" and "files that git ignores", so I 
tried to mostly just use the same terminology I saw kicking around in other 
documentation. I think "unknown files" and "ignored files" are fairly clear and 
seem like the terms I usually hear people using. If we add them to the 
glossary then we could use them in a standard way in the documentation.

>     Normally, the command removes files that are not in the index, but
>     ignored (see linkgit:gitignore[5]) files are kept.  With the '-x'
>     option, the command removes the ignored files as well.

Are you already queuing this or any of these other things? If not, I would be 
happy to work on another patchset that attacks both this and the glossary 
issue.
