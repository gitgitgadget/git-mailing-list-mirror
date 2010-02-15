From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Walking commits from the first
Date: Mon, 15 Feb 2010 10:09:02 +0530
Message-ID: <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
References: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngsjo-00005Z-G2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0BOEjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 23:39:07 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:45390 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab0BOEjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:39:05 -0500
Received: by yxe34 with SMTP id 34so2220887yxe.15
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 20:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=rZBmTV06JqEwZg/dHFJk1s2wbw0e1Hxuz+xcUKfVlYA=;
        b=g9CShXmDndN8ZP4Rd5D5daLRM5V6qfHc+wN2yjrpy2yx/uM14TjHrGkCWVjLjx/P7U
         RygZQZiNB0VS58zq+H55YEXJCKtyacIntgP2EzCQE936UZlTvuh0nApVjZzGFFcqfhkX
         QozAqWSgEk4kcvwiyuAi813dhqYAkeAvrRiV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=d6ySYnRApsg23/7X3TL18JC77sgNhSRNS0NUl20q4dQSsZmaVXLLcA/KcEPn8nN/BJ
         7cwz5ZTg1BOZoP1aYH0KBkZXwEK4sISN/XDVfDlaH6AK2Me7QwaDgYqn27t50abyzzO2
         kxc0o/kjV/Aept4T4PRBgc+LKnqFzMLy/fq6s=
Received: by 10.150.56.35 with SMTP id e35mr6479395yba.118.1266208742814; Sun, 
	14 Feb 2010 20:39:02 -0800 (PST)
In-Reply-To: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139967>

Hi,

 When you clone a big git repository and would like to read and
understand the source code, you need to checkout and read every commit
right from the first commit. As per my knowledge, there is no command
(even with flags) to checkout the first commit of the repository.

If there is some command, please put it in user's manual

Also if we somehow managed to do it by a series of commands, after we
finish reading it then we need to redo it all over again to checkout
the next commit.

So, what i would like to have is something like this:
1) git checkout --first
   Checksout the commit #1 of the git repository
2) git checkout --next
   Checksout the next commit

What I think:

I know that every git commit is a vertice in a DAG which has it's edge
pointed to it's parent. So, walking from the latest commits to old
commits is easy but the reverse is not.
I would like to know if there is any problem if we make the walking
bidirectional. What i mean is, when a new commit is created, create an
edge not only from it to it's parent but also from it's parent to it.
Also, have something for the first commit of the repo which can be
referred as INIT (similiar to HEAD)

-pavan
