From: Eli Barzilay <eli@barzilay.org>
Subject: Re: rebase --continue confusion
Date: Sun, 06 Jun 2010 09:10:44 -0400
Message-ID: <m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
References: <4C01B855.7080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 15:11:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLFd6-0003RC-Ip
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 15:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab0FFNLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 09:11:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:60543 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab0FFNLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 09:11:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OLFcx-0003H9-D7
	for git@vger.kernel.org; Sun, 06 Jun 2010 15:10:59 +0200
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 15:10:59 +0200
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 15:10:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:fPCDWiroriwGCnJreoAwy0Ze4t8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148521>

Dale Rowley <ddrowley@gmail.com> writes:
>
> OK, so there isn't a bug in git, but since then I've seen co-workers
> stumped by this same problem. So maybe it would help to clarify the
> message? Maybe something like "The index is in the same state as it
> was before the patch was applied - refusing to make an empty
> commit. Did you forget to use 'git add'? Or maybe you should use
> 'git rebase --skip'?"

There are a number of these things that I asked about recently.
Here's another similarly one:

  $ git add foo
  $ git status -s
  M  foo
  $ git commit --amend foo
  # On branch master
  # No changes
  $ git status -s
  M  foo

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
