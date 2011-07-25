From: Phil Hord <hordp@cisco.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Mon, 25 Jul 2011 17:58:32 -0400
Message-ID: <4E2DE708.8050805@cisco.com>
References: <201107252233.02088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTAf-00046R-HU
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab1GYV6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:58:37 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:52092 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1GYV6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3360; q=dns/txt;
  s=iport; t=1311631115; x=1312840715;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=j/sDNguGJGdbj5Hh0PQsE8yEE1EnC5y4SwJ6srK9IgU=;
  b=d9SVak7zgjlj+cdYgDM5UUUPdETQ2C+IrvqEcm+eieP5Q4HCioQ1hlvx
   53OFeSobZI1M1tVYCwwt1CwRcZzcgLgx9PiSUKfo4iIRQkMJh+ePJGezd
   ZSwun4vv3pNxlFko97rFVonw3km7Mdg2YqiLXKyFR2q8qfvy6H/dhc8Ux
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAK/mLU6tJV2c/2dsb2JhbAA0AQEBAQMUAQhnAREMDgoJIg8JAwIBAgECUQcOAQ4BAR+nNHerRp45hj8EknCFB4t1
X-IronPort-AV: E=Sophos;i="4.67,265,1309737600"; 
   d="scan'208";a="6276207"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-5.cisco.com with ESMTP; 25 Jul 2011 21:58:34 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p6PLwXO3031812;
	Mon, 25 Jul 2011 21:58:34 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <201107252233.02088.jnareb@gmail.com>
X-TagToolbar-Keys: D20110725175832134
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177824>

On 07/25/2011 04:33 PM, Jakub Narebski wrote:
> NOTES:
> ^^^^^^
> How to detect if it is msysGit or Cygwin from within?  Perhaps we
> should have just "MS Windows"...

I think it's useful to know which build they're using, cygwin or msys. 
Hopefully it's not too confusing for them and they can answer correctly.

>
>
> === 11. What Git interfaces, implementations and frontends do you use? ===
> (multiple choice, with other)
>
>  + JGit (Java implementation), e.g. via Eclipse plugin
>  + NGit or Git# (C# implementation)
>  + Dulwich (pure-Python implementation)
>  + Git::PurePerl (Perl implementation)
>  + git.js (JavaScript)
>  + libgit2 bindings
>
>  + git (core) commandline
>  + Cogito (DEPRECATED)
>  + Easy Git
>  + Pyrite
>  + I don't know, I only use (graphical) tools
>
>  + pg aka Patchy Git (DEPRECATED)
>  + StGIT
>  + Guilt
>  + TopGit
>
>  + Zit
>
>  + other (please specify)

You can probably drop pg and Cogito now, yes?

Looking at the 2010 results, I would add these GUIs to the main list:
git-gui (core)
gitk (core)
gitX
gitg
git-cola
TortoiseGit
SmartGit
Git Extensions
Giggle

Is there room for Gerrit here, or maybe in one of the other questions?
Also, cgit and other web interfaces, I suppose.


> === 16. Which of the following Git features do you use? ===
> (multiple choice, with other)
>
>  + localization of command-line messages (i18n)
>  + git bundle (off-line transport)
>
>  + eol conversion (crlf or eol)
>  + gitattributes (any)
>  + custom diff/merge driver
>  + word diff
>  + merge strategy options (e.g. -Xrenormalize)
>  + textconv
>
>  + submodules (subprojects)
>  + subtree merge (optionally git-subtree)
>
>  + partial (sparse) checkout, or assume-unchanged bit
>
>  + separate worktree / core.worktree
>  + multiple worktrees (e.g. git-new-worktree)
>  + gitdir mechanism (.git file pointing to repository)
>
>  + alternates mechanism (sharing object database)
>  + stash (optionally "git stash --keep-index")
>  + shallow clone (e.g. "git clone --depth=<n>")
>  + detaching HEAD (e.g. "git checkout --detach")
>  + commit message templates
>  + interactive commit / per-hunk comitting / partial commit
>  + interactive rebase (small scale history editing)
>  + git-filter-branch or equivalent (large history rewriting)
>  + bisect (optionally "git bisect run <script>")
>  + tracking code movement with git-blame ("git blame -M" etc.)
>  + committing with dirty tree (keeping some changes uncommitted)
>
>  + non-default hooks (from contrib/hooks/ or other)
>  + shell completion of commands
>  + git-aware shell prompt
>  + git aliases, shell aliases for git, or own git scripts
>
>  + one-way interaction with other SCMs (from SCM to git)
>  + two-way interaction with other SCMs (from SCM to git, from git to SCM)
>
>  + git-cvsserver
>  + git notes
>
>
>  + Other, please specify
>
> NOTES:
> ^^^^^^
> The problem is come up not with exhaustive list of features: there are
> too many of them to list.  The problem is coming up with list of
> important and used enough often features.
>
> So: what features should be included in this list?  What features
> should be removed from above list of answers?

bridges (git-svn, hg-git, git-p4, etc.)
IDE integration (Eclipse, Netbeans, etc.)

Phil
