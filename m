From: "Joe Fiorini" <joe@faithfulgeek.org>
Subject: Git rebase failure: .dotest overwritten
Date: Tue, 15 Jul 2008 17:08:42 -0400
Message-ID: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIrmK-0005Vu-PE
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYGOVIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbYGOVIp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:08:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:17364 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbYGOVIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:08:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2641915ywe.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 14:08:44 -0700 (PDT)
Received: by 10.103.49.12 with SMTP id b12mr235494muk.72.1216156122973;
        Tue, 15 Jul 2008 14:08:42 -0700 (PDT)
Received: by 10.103.160.9 with HTTP; Tue, 15 Jul 2008 14:08:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88594>

A friend of mine asked me for help with a git rebase problem.  I was
clueless.  Here is what he was seeing:
The main problem seems to be the following error: "fatal: Untracked
working tree file '.dotest/0001' would be overwritten by merge."; also
all the files that it says "already exist in working directory" did
not exist before he ran the rebase.  Maybe it's trying to run the
rebase more than once? His working copy was clean.  Any thoughts?  Any
other details I can provide?
Thanks!
Joe
git rebase master
First, rewinding head to replay your work on top of it...
HEAD is now at 9bba5f1... Create function snippet
Applying People page templates
.dotest/patch:59: trailing whitespace.

.dotest/patch:60: space before tab in indent.
  parent::BuildControlArray($EventParameters);
.dotest/patch:61: space before tab in indent.
  }
.dotest/patch:65: trailing whitespace, space before tab in indent.

.dotest/patch:67: trailing whitespace.

error: .dotest/0001: already exists in working directory
error: .dotest/0002: already exists in working directory
error: .dotest/0003: already exists in working directory
error: .dotest/binary: already exists in working directory
error: .dotest/final-commit: already exists in working directory
error: .dotest/info: already exists in working directory
error: .dotest/keep: already exists in working directory
error: .dotest/last: already exists in working directory
error: .dotest/msg: already exists in working directory
error: .dotest/msg-clean: already exists in working directory
error: .dotest/next: already exists in working directory
error: .dotest/patch: already exists in working directory
error: .dotest/sign: already exists in working directory
error: .dotest/utf8: already exists in working directory
error: .dotest/whitespace: already exists in working directory
Using index info to reconstruct a base tree...
stdin:59: trailing whitespace.

stdin:60: space before tab in indent.
  parent::BuildControlArray($EventParameters);
stdin:61: space before tab in indent.
  }
stdin:65: trailing whitespace, space before tab in indent.

stdin:67: trailing whitespace.

warning: squelched 49 whitespace errors
warning: 54 lines add whitespace errors.
Falling back to patching base and 3-way merge...
fatal: Untracked working tree file '.dotest/0001' would be overwritten by merge.
Failed to merge in the changes.
Patch failed at 0001.
When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
--
joe fiorini
http://www.faithfulgeek.org
// freelancing & knowledge sharing
