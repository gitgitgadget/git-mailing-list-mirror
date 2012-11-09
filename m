From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 00:21:48 +0100
Message-ID: <CAMP44s3yVtQ4wGqVTyHN-VfAM7iRo9WfNnAu+ns7Zkc_cPBH3g@mail.gmail.com>
References: <20121109192336.GA9401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWxtj-0006Ql-Pk
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 00:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2KIXVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 18:21:50 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37510 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2KIXVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 18:21:49 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so4576200obb.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 15:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UZtgy5gW1D+CA8knK3bUSJwCbpG3G+mnhkpU/d095lY=;
        b=Ny9G+mXzRpWFbZjXydWLDkX6O9EdNfqcpdNeFXKPprT0P7O2z+To7bNxWnnnFKMNC8
         vjKMSnFCe6w3sm1bwIH89BCxFSigEvxsfSJ12KwPDCsc6q98fl+uSfr30QursHpkvpEJ
         DKeDriup/ekfki73PBRYS0i/ylWgusHN6sJlE/Qx6j9joDPWCaWa4l2tH0LHqqcrVDr8
         dCJ5cPaq4sFICQl3t666ggvLLd7HCRbreoPAqLWrIBqRc3/xks2zQ9wNk77w4CJ4dMWZ
         WgxNCiUSF+w/WsOlYUT8bxRkQEW4pz30WBGnr2JUoWfOFvM8Mo5cwnsdVmhzW0XMbSYs
         yV5w==
Received: by 10.60.12.233 with SMTP id b9mr9313109oec.95.1352503308824; Fri,
 09 Nov 2012 15:21:48 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 9 Nov 2012 15:21:48 -0800 (PST)
In-Reply-To: <20121109192336.GA9401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209252>

Hi,

On Fri, Nov 9, 2012 at 8:23 PM, Jeff King <peff@peff.net> wrote:

> * fc/fast-export-fixes (2012-11-08) 14 commits
>  - fast-export: don't handle uninteresting refs
>  - fast-export: make sure updated refs get updated
>  - fast-export: fix comparison in tests
>  - fast-export: trivial cleanup
>  - remote-testgit: make clear the 'done' feature
>  - remote-testgit: report success after an import
>  - remote-testgit: exercise more features
>  - remote-testgit: cleanup tests
>  - remote-testgit: remove irrelevant test
>  - remote-testgit: get rid of non-local functionality
>  - Add new simplified git-remote-testgit
>  - Rename git-remote-testgit to git-remote-testpy
>  - remote-testgit: fix direction of marks
>  - fast-export: avoid importing blob marks
>
>  Improvements to fix fast-export bugs, including how refs pointing to
>  already-seen commits are handled. An earlier 4-commit version of this
>  series looked good to me, but this much-expanded version has not seen
>  any comments.
>
>  Needs review.

I can send the previous 4-commit version if needed, the only thing
that changed is the commit messages.

I think it's unfortunate that 4-commit version would not be mentioning
that it fixes the above tests, but hey; I did what I could.

> * fc/zsh-completion (2012-10-29) 3 commits
>  - completion: add new zsh completion
>  - completion: add new __gitcompadd helper
>  - completion: get rid of empty COMPREPLY assignments
>
>  There were some comments on this, but I wasn't clear on the outcome.
>
>  Need to take a closer look.

SZEDER should probably take a look. I think it should be better than
the previous series.

> * fc/completion-test-simplification (2012-10-29) 2 commits
>  - completion: simplify __gitcomp test helper
>  - completion: refactor __gitcomp related tests
>
>  Clean up completion tests.
>
>  There were some comments on the list.
>
>  Expecting a re-roll.

The second patch I can re-roll, but the first patch needs some
external input. My preference is that tests should also be simple and
maintainable, SZEDER's preference is that tests are better being
explicit and verbose (even if harder to maintain) to minimize possible
issues in the tests.

> * fc/remote-testgit-feature-done (2012-10-29) 1 commit
>  - remote-testgit: properly check for errors
>
>  Needs review.

Sverre probably should reply. I think I already addressed his comments
and the patch should be OK to push.

But probably it's not that important considering the testgit
refactoring, and also I'm thinking that we need to actually check the
status of the process[1] because the situation is still not OK with
pushing, and I'm learning it the hard way with a buggy remote helper.

> * fc/remote-bzr (2012-11-08) 5 commits
>  - remote-bzr: update working tree
>  - remote-bzr: add support for remote repositories
>  - remote-bzr: add support for pushing
>  - remote-bzr: add simple tests
>  - Add new remote-bzr transport helper
>
>  New remote helper for bzr.
>
>  Will merge to 'next'.

I already have a newer version of this with support for special modes:
executable files, symlinks, etc. I think a reroll would make sense.

> * fc/remote-hg (2012-11-04) 16 commits
>  - remote-hg: the author email can be null
>  - remote-hg: add option to not track branches
>  - remote-hg: add extra author test
>  - remote-hg: add tests to compare with hg-git
>  - remote-hg: add bidirectional tests
>  - test-lib: avoid full path to store test results
>  - remote-hg: add basic tests
>  - remote-hg: fake bookmark when there's none
>  - remote-hg: add compat for hg-git author fixes
>  - remote-hg: add support for hg-git compat mode
>  - remote-hg: match hg merge behavior
>  - remote-hg: make sure the encoding is correct
>  - remote-hg: add support to push URLs
>  - remote-hg: add support for remote pushing
>  - remote-hg: add support for pushing
>  - Add new remote-hg transport helper
>
>  New remote helper for hg.
>
>  Will merge to 'next'.

:)

I have a few patches on top of this, but they can probably wait.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/208139

-- 
Felipe Contreras
