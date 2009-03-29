From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sun, 29 Mar 2009 04:52:44 -0700 (PDT)
Message-ID: <1238327564546-2552334.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> <1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> <1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 13:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lntb9-0002Yo-Jq
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 13:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZC2Lwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 07:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZC2Lwr
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 07:52:47 -0400
Received: from kuber.nabble.com ([216.139.236.158]:51599 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZC2Lwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 07:52:46 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LntZE-0004rW-Hp
	for git@vger.kernel.org; Sun, 29 Mar 2009 04:52:44 -0700
In-Reply-To: <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115019>


Thank you again for your reply :-) Ahh, yes, that makes sense about the local repository. However, on checking, the local repository that I set up has no files except in .git directories - is that to be expected at this stage?

Also, when I tried "git svn rebase", I got the following error:

"Migrating from a git-svn v1 layout...

"Data from a previous version exists, but .git/svn (required for this version (1.6.2 msysgit.0.186.gf7512) of git-svn) does not exist. Done migrating from a git-svn v1 layout

"Unable to determine upstream SVN information from working tree history"

And the local directories for the repositories are still empty. Am I doing something wrong...?


Heya,

On Sun, Mar 29, 2009 at 12:51, jamespetts <jamespetts@yahoo.com> wrote:
> However, after several hours of downloading (I left it overnight), it gave the error, "The connection was aborted: Can't read from connection: The connection was aborted at C:\Program Files\Git/libexec/git-core/git-svn/ line 2490".

You can continue downloading, just issue' git svn rebase' again, and
it will continue where it left of.

> When I look at my repository on Github, it is still empty, apart
> from the empty README file that I created just to initialise it.
> Why would it be going wrong? How do I deal with that?

You would have to push the repository to github regardless of whether
'git svn rebase' finished in one go. Keep in mind that' git svn
rebase' is the way to get changes _into_ your _local_ repository.
You'll need to use 'git push' to get your changes up to github.

-- 
Cheers,

Sverre Rabbelier
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2552334.html
Sent from the git mailing list archive at Nabble.com.
