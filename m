From: Murtuza Mukadam <murtuza.i.mukadam@gmail.com>
Subject: Fwd: git-reviewed: linking commits to review discussion in git
Date: Mon, 17 Feb 2014 15:12:48 -0500
Message-ID: <CANx4bCAWVoCQdYQQ5cGXF-Z6Evck=Oeb2Shghkcuf7PMvSZBOA@mail.gmail.com>
References: <CANx4bCB5tTzKusbfcqQ=eoeOGJ-WxWvF3QNpfa5rTq7oOSG-5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Rigby <peter.rigby@concordia.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 21:12:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFUYg-00087T-Lg
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 21:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbaBQUMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 15:12:50 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:41486 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbaBQUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 15:12:49 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so18212146oag.14
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W+lNiUS/tPEgcAD/azao8HzMBo5bSzCkpjfA8jghvAg=;
        b=a01kW3JfDVuPLQtutZTKCneYDPxV0jfCykwEm1hZe7ey2vIyh3y4DHhIQ+dmOTVFXS
         Px3i1Ost9I/UZS/Mg3+lUYv4sO7aVrD3T2bluu+M4fa9NLdVGEq4bG1iFx4YwWiUewSF
         yMDwoD5pT7Ktx2WwDKj8O1Aa3eYMWKHotkkKx3X11/qaSrZLRMNU5skF5DgCpZz7Xfdm
         Knzuo30iHyHrchq+TPsLS9yyVq6R8fOYcwdzUnERf8aIUCejR+36pb82lO1oYa3Z7iOz
         wojz2zX49UVRjamFm/KQjDjF4Q29r+Ovgg9idZr5VQ1uwRVvYw3RoCfgYANz6IAC3eeP
         zkEQ==
X-Received: by 10.182.43.161 with SMTP id x1mr22245762obl.5.1392667968860;
 Mon, 17 Feb 2014 12:12:48 -0800 (PST)
Received: by 10.76.79.5 with HTTP; Mon, 17 Feb 2014 12:12:48 -0800 (PST)
In-Reply-To: <CANx4bCB5tTzKusbfcqQ=eoeOGJ-WxWvF3QNpfa5rTq7oOSG-5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242266>

Hello All,

We have linked peer review discussions on
git@vger.kernel.org to their respective commits within the main
git.git repository. You can view the linked reviews from 2012
until present in the GitHub repo at:
https://github.com/mmukadam/git/tree/review

If you want to search for the reviews related to a commit, you can
type in the full hash code here:
http://users.encs.concordia.ca/~m_mukada/git-review-tracker.html

or append the commit hash to the following url:
https://github.com/mmukadam/git/tree/review/<commit_hash>

Note, if you get a '404 page not found' from GitHub it means that we
couldn't find a review to link the commit to.

It's a bit hard to view the reviews on GitHub because the 'review' branch was
designed to be viewed on the command line using a set of simple scripts that
sit on top of the standard git commands.

For example:
to view all reviews Hamano is involved in you can do:
git reviewed --log-reviewer hamano

to view the reviews of particular commit:
git reviewed --log 1a1832eb085e5bca198735e5d0e766a3cb61b8fc

You can also create new reviews on a commit and mail them as well as
import reviews from email.

Note the command is git-reivewED because git-review is associated with Gerrit.

The tool is beta, but it just creates a detached review branch, so it
won't affect master. To remove it all you do is delete the scripts and
the 'review' branch. More info available here:

The online man-page is here:
http://users.encs.concordia.ca/~m_mukada/git-review.html

In order to install git-review, you need to clone the repository:
https://github.com/mmukadam/git-reviewed.git

The online tutorial is available here:
http://users.encs.concordia.ca/~m_mukada/git-review-tutorial.html


Sample output:

Let's say you want to see the reviews related to commit:
---------------------------------------------------------------------------------
git reviewed --log 9ce415d972a04df4bfceaad0fab8eaea9a66997e

Review: 74d203accc341993dbed507fceceb2841670ce37
Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Author:     Johannes Sixt <j6t@kdbg.org>
AuthorDate: Fri Jun 7 22:53:27 2013 +0200
Reviewer:   Junio C Hamano gitster@pobox.com <gitster@pobox.com>
ReviewDate: Thu Feb 13 11:35:13 2014 -0800


    Re: [PATCH] tests: turn on network daemon tests by default

Review: e80ebaa1fdd132a13bfbc6f87cdd4ecec7f2b715
Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Author:     Johannes Sixt <j6t@kdbg.org>
AuthorDate: Fri Jun 7 22:53:27 2013 +0200
Reviewer:   Junio C Hamano gitster@pobox.com <gitster@pobox.com>
ReviewDate: Wed Feb 12 14:34:52 2014 -0800


    Re: [PATCH] tests: turn on network daemon tests by default

Review: 8da03766afcd60e432ffdd2d6f549e2ed02a4bc9
Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Author:     Johannes Sixt <j6t@kdbg.org>
AuthorDate: Fri Jun 7 22:53:27 2013 +0200
Reviewer:   Jeff King peff@peff.net <peff@peff.net>
ReviewDate: Mon Feb 10 16:29:37 2014 -0500


    [PATCH] tests: turn on network daemon tests by default



To show the email review discussion for a single review:
---------------------------------------------------------------------------------

git reviewed --view 74d203accc341993dbed507fceceb2841670ce37

Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Reviewer: Junio C Hamano <gitster@pobox.com>
Reviewer Date: Thu, 13 Feb 2014 11:35:13 -0800
---------------------------------------------------------------
From : Junio C Hamano <gitster@pobox.com>
Message-Id : <xmqqfvnmlsb2.fsf@gitster.dls.corp.google.com>
Date : Thu, 13 Feb 2014 11:35:13 -0800
Subject: Re: [PATCH] tests: turn on network daemon tests by default
References: <20140210191521.GA3112@sigill.intra.peff.net>
<20140210212931.GA16154@sigill.intra.peff.net>
<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
<20140211200445.GA27946@sigill.intra.peff.net>
<xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
<20140212214753.GA6799@sigill.intra.peff.net>
<xmqq38jom037.fsf@gitster.dls.corp.google.com>
In-Reply-To: <xmqq38jom037.fsf@gitster.dls.corp.google.com> (Junio C.
Hamano's message of "Wed, 12 Feb 2014 14:34:52 -0800")
Cc: Duy Nguyen <pclouds@gmail.com>, Git Mailing List
<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>
commit: 9ce415d972a04df4bfceaad0fab8eaea9a66997e

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   test_normalize_tristate GIT_TEST_DAEMON
>
> Heh, great minds think alike.  This is what I am playing with,
> without committing (because I do like your "ask config if this is a
> kind of various boolean 'false' representations, which I haven't
> managed to add to it).

[snip]

---
 t/lib-git-daemon.sh     |  8 ++++---
 t/lib-httpd.sh          | 22 +++++++++----------
 t/test-lib-functions.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 394b06b..615bf5d 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -16,9 +16,10 @@
 #      stop_git_daemon
 #      test_done

-if test -z "$GIT_TEST_GIT_DAEMON"
+test_tristate GIT_TEST_GIT_DAEMON
+if test "$GIT_TEST_GIT_DAEMON" = false
 then
-       skip_all="git-daemon testing disabled (define
GIT_TEST_GIT_DAEMON to enable)"
+       skip_all="git-daemon testing disabled (unset
GIT_TEST_GIT_DAEMON to enable)"
        test_done
 fi

[snip]

 # The following mingw_* functions obey POSIX shell syntax, but are actually
 # bash scripts, and are meant to be used only with bash on Windows.

--
1.9.0-rc3-260-g4cf525c


To see all the reviews anyone is involved in:
-------------------------------------------------------------------

git reviewed --log reviewer hamano

Review: ecb6f98955700169ed6f88d929babd7d0f770116
Commit Reviewed: 9c8ce7397bac108f83d77dfd96786edb28937511
Author:     Michael J Gruber <git@drmicha.warpmail.net>
AuthorDate: Thu Feb 13 11:35:08 2014 +0100
Reviewer:   Junio C Hamano gitster@pobox.com <gitster@pobox.com>
ReviewDate: Thu Feb 13 13:25:23 2014 -0800


    Re: [PATCH] release notes: typo fixes

Review: 74d203accc341993dbed507fceceb2841670ce37
Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Author:     Johannes Sixt <j6t@kdbg.org>
AuthorDate: Fri Jun 7 22:53:27 2013 +0200
Reviewer:   Junio C Hamano gitster@pobox.com <gitster@pobox.com>
ReviewDate: Thu Feb 13 11:35:13 2014 -0800


    Re: [PATCH] tests: turn on network daemon tests by default

Review: e80ebaa1fdd132a13bfbc6f87cdd4ecec7f2b715
Commit Reviewed: 9ce415d972a04df4bfceaad0fab8eaea9a66997e
Author:     Johannes Sixt <j6t@kdbg.org>
AuthorDate: Fri Jun 7 22:53:27 2013 +0200
Reviewer:   Junio C Hamano gitster@pobox.com <gitster@pobox.com>
ReviewDate: Wed Feb 12 14:34:52 2014 -0800


    Re: [PATCH] tests: turn on network daemon tests by default



Please let us know what you think about this tool as it will help us
in improving it. If you'd like us to extract the reviews related to a
different repository, please let us know.

This is part of my Msc thesis, so any feedback is appreciated.
We thank you for you time.

Cheers,
Murtuza
