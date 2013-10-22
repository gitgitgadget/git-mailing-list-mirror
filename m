From: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
Subject: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 11:08:41 +0530
Message-ID: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 22 07:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYUgH-00011d-4f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 07:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab3JVFin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 01:38:43 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49080 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab3JVFim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 01:38:42 -0400
Received: by mail-pd0-f182.google.com with SMTP id q10so7280628pdj.27
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 22:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GDX8txo4a4OY5xljOrzsPTZ1aUu5EuibuhRx3H9W4mE=;
        b=y4S/zCL1ROw4x/Dn3v2E1ZGg4o501KeLxVsak4DcqoAvI45Z8bPk3nZ+UpOykW3bs6
         Qa4nh3rsma4syz9vDrKyiR4z1hmpR9GhXULUQr9le/SmzaXO90ufsBY5M8+ReixqgLwB
         po+M+XLOpv4L6hsuuCJwqf8P228ddkRGdrr8tgR2I3eH9glfESBwNqfCIOFeymQ7SU+0
         MAYvCcWHQ+X+HVtXM5uIK8HiE+KFdfrSQ1iR3B6zbjyLcK2vDklCxVF786296EkFlJbP
         ubr0RYas1cvwUtFl7NXOIPV/M+ebXSOaLA4lXG9N9y8DmxhV6nmEb1VzDlkwSQIpe9g9
         FeFg==
X-Received: by 10.68.240.33 with SMTP id vx1mr21313645pbc.12.1382420321796;
 Mon, 21 Oct 2013 22:38:41 -0700 (PDT)
Received: by 10.66.165.233 with HTTP; Mon, 21 Oct 2013 22:38:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236454>

Hi All,

I'm in a bit of a pickle! :) So I've come to ask for help from the guru's here.

My story is not unique but somehow the various suggested solutions
don't seem to work in my case.

* I was working on a feature which was supposed to be done off our
'dev' branch. But instead I forgot and branched out my topic branch
from master (or as we call it 'stable').
* I did 2 commits and finished off my work. Only later realizing that
it had to be done off 'dev'.
* Now I want to move my 2 commits (which are the top 2 commits on my
topic branch) to a new branch which is branched off 'dev'.

$ git branch
* topicA
* stable
* dev

topicA was based on stable. But now I want to base it dev.

So I did what was most suggested, i.e use 'git rebase --onto'.

Here's what I did when I was in topicA:

$ git rebase dev stable topicA
(this was suggested in the manpage as well).

This started off a massive rebase operation, because the 'dev' branch
is vastly diverged from stable, and a lot of conflicts started
appearing.

I'm not sure if I'm doing it right here, so can anyone suggest whether
this is right or do I need to do it differently?

PS: Please CC me (mandeepsandhu.chd@gmail.com) in your reply as I'm
not currently subscribed to the list.

Thanks for your time.

Regards,
-mandeep
