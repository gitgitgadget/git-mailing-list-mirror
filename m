From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC] git rebase --edit
Date: Fri, 12 Feb 2010 16:44:26 +0800
Message-ID: <be6fef0d1002120044w5f14d061t52863fbc8b0bd304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 09:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfr8b-0005gX-0n
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 09:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0BLIo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 03:44:28 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:38738 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0BLIo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 03:44:27 -0500
Received: by iwn39 with SMTP id 39so419250iwn.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=q0jFyjJJH2lzxXKWYwg1s0TRuEFNge8UFeCEw/mlnz8=;
        b=guZLLi5XE9rsP9UoroYP1wIKgeR9753xAB239IDNl3GgoLlszRJIN2o+nu+0kL+dUc
         RiKCiQ/K+1Ax0ClVBauKo8WJ715hiGluHsIWEFkAuB9+cKPWcu6cdOSumCLMIQA4+SvZ
         DRXFgqYtef7PmyRnAhYjqZ6ZO0D7MkoP4Ceu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=E1JzfxsYVVy7zudvJQEnoqF+pp6XH57Yuwd5kAZK9KEnJvkDOcoakcptfW51rcHOEJ
         DwoXLsgdhUO7C4Xdxo8M66l8AI7QFNQl+BXxAbxJr8aroVUW1tSJV9CUM5MPWB15voeo
         L0i3Ud4yGImFzkZdGtyvcvBWEmwzk2Sk90UoM=
Received: by 10.231.153.69 with SMTP id j5mr1713485ibw.33.1265964266637; Fri, 
	12 Feb 2010 00:44:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139663>

Hi,

sometimes, I need to edit a commit, and I find myself doing some
rather "mechanical" steps.

  $ git log #find the commit
  $ git rebase -i <commit>^
  $ #mark <commit> with 'e', save, exit editor

  Stopped at <commit>... <commit message>
  You can amend the commit now, with
  ...

Perhaps git-rebase --interactive could learn an option, say, --edit
<commit>, that

  1. determines where to start the rebase (instead of saying <commit>^ above),
  2. marks <commit> as 'e' in git-rebase-todo,
  3. start the edit process ("You can amend the commit now...").

The user would then proceed with the usual git-rebase --continue.

Is this a workable suggestion?

-- 
Cheers,
Ray Chuan
