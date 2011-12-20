From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Introducing vcsh - manage config files in $HOME via fake bare git repositories
Date: Tue, 20 Dec 2011 01:17:26 +0100
Message-ID: <CAD77+gTO35ZFdcOjTEEcymgDKMq4Uh3JZcqgXWR07kGksfkBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 01:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcnWk-0001Jj-0F
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 01:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1LTAZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 19:25:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34990 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1LTAZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 19:25:47 -0500
Received: by werm1 with SMTP id m1so1654575wer.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 16:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=FwKcyculq73vLfAgguJCZohpvLaqcYqk2W8m1xohe9c=;
        b=GaAtWUq62WLfZd0jDiV7WKHxdUWQeV8dVQUc1/VOk5RYTrOYSaw0/g7WBZk9PRw7Uk
         zbcR1nXIu7mcaMosXn5QP2u+nrnUjHkt2ENKV2BQIxDU44OupZSlJyPn+WRbmbMN3fAu
         7rP+ShPFw+HRe47NOCxyB9rFqNxZcCZKzjqvc=
Received: by 10.216.138.218 with SMTP id a68mr5424452wej.38.1324340746835;
 Mon, 19 Dec 2011 16:25:46 -0800 (PST)
Received: by 10.216.10.208 with HTTP; Mon, 19 Dec 2011 16:17:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187485>

Hi all,


some of you may be familiar with fake bare git repositories[1].

Basically, they allow you to keep the git directory and its working
directory separate from each other. This allows you to have an
arbitrary number of repositories with working trees in $HOME. That, in
turn, allows you to have one repo for zsh, one for vim, one for git,
etc pp.

vcsh[2] is a front-end for dealing with fake bare git repos, i.e. it
saves you a lot of typing and automates many things. It's written in
pure POSIX shell.


vcsh's userbase is slowly expanding and as it's feature set and syntax
are stable and there are no known bugs I think this is a good time to
try to increase adoption rate. I strongly believe that a lot of people
on this list could benefit from using it; hopefully you agree.
Publishing it here makes sense as if you are reading this, you are
obviously familiar with and using git already, anyway.

Feedback is very welcome. Good, bad or indifference, I will take it all.

Two notes:

* There is no test suite, yet. If anyone has a suggestion as to which
test suite has a reasonable feature set while having a syntax that
does not make you violently sick, or is even interested in helping to
write said test suite, do let me know.
* I am pondering renaming/aliasing vcsh to git-fbare.sh or similar.
That has a few issues, though..
** extra typing involved
** adds another command level of to otherwise standard git commands,
for example `git fbare zsh commit -a -m 'new feature'`
** forces everyone to have a default location for vcsh repos


Regards,
Richard

[1] http://lists.madduck.net/pipermail/vcs-home/2011-April/000378.html
[2] https://github.com/RichiH/vcsh
