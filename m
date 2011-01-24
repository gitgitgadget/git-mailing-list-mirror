From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: merging branch
Date: Mon, 24 Jan 2011 12:33:02 +0100
Message-ID: <AANLkTinKt0pi_1NaEJY8-c1B3SKsWdxqEyTvJiGL-vYj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 12:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhKfp-0002gQ-3B
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 12:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab1AXLdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 06:33:24 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53950 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab1AXLdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 06:33:23 -0500
Received: by ywe10 with SMTP id 10so848912ywe.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=hV9hUd+esUTtJVuIG2V4coNxebHZqrrXRJr+a9X19Ek=;
        b=Fb5dvkXMoCG9xa/02NEzQD+Qsvl/Jk3TMxDSUtO/MHd5hDqJOQgWYpPGuhJRx/xDPV
         GTPIVvc6j0F2Nkc0lpHxkuoN7UJULhE/ET5YSD5r/lKn5oqFctI/jLzo8hk9QVug6Q4p
         tqGELjG9SJbOARgm3iUHO0Iod+11JelmXG1R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=G713Zc/0oEGS6iiGwSYuUXbw6S5FYSL35eobkV1Y/p95VQ50GfrV1vhVQ5zceZVGnO
         Q87DxJYIUEfq0+gs/ZWGy8gErSMao10LM+WxVVdw4llpOuJL+rXrIy1M96rx5gc0TB0f
         qbBkvLdJb5LkcfPzGU9wFEvK7pNcsSCx1xM+c=
Received: by 10.90.71.2 with SMTP id t2mr4810349aga.106.1295868802674; Mon, 24
 Jan 2011 03:33:22 -0800 (PST)
Received: by 10.90.54.18 with HTTP; Mon, 24 Jan 2011 03:33:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165448>

Hi,

  I have the following branches:

$ git branch
* master
  release

  I have messed up my 'release' branch by manually importing file one
by one using: git checkout release && git checkout master my_file.cxx

  So now I'd like to merge back release to master. I tried:

$ git checkout master && git merge -s ours release
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 27 commits.
#
nothing to commit (working directory clean)
$ git diff origin/master..master
-> return nothing

Since most of those commits will be redundant, I need to 'git pull
--rebase', right ? However I did not understand how to pass the
--interactive option to git pull --rebase to split this set of 27
commits (I'd like to discard at least one large one)

Thanks !
-- 
Mathieu
