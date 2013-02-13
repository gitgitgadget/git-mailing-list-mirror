From: "amccloud@gmail.com" <amccloud@gmail.com>
Subject: git svn init throws Not a git repository (or any of the parent
 directories): .git
Date: Wed, 13 Feb 2013 14:01:36 +0100
Message-ID: <CALiJYpDPf8R2mOZn5Ey_yArSAg73WRASKS1cqLsAu1tGJcO_SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5bz0-0002CR-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 14:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933991Ab3BMNCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 08:02:18 -0500
Received: from mail-ve0-f175.google.com ([209.85.128.175]:50912 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933982Ab3BMNCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 08:02:17 -0500
Received: by mail-ve0-f175.google.com with SMTP id cy12so1019266veb.6
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 05:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Vpv6ViCQdJZX+rIjF2TiTfesDS+3OoWUBZEQE6LP6Fg=;
        b=t/4k1eOWaL9xmgIP3Q+es5XfbdxpSji3QNhqwuHKXcMhwudCjHf2+K4lesqksQlTCT
         ZR3MozQW7WkuB35fzTPscQhlrHBgI8FTsSrTM4yN8bDnKrMnz8KiRQ4ev4Xrszybbelt
         j1fbjeTrKQVMaXja343uhNGrnCrJ7JdIPOwvOgbOWyhnvK5YjS4WBEdu1OqJpAqQSyXb
         Q3O07eZePfjpk62iCull5wgPknbxNyIKsr2qiCOgLbWQP1gqWd/ZZ11MR06bV19Ts/be
         k+L5ITn8sw8EU4Aj84vhuyyPFlXtPd4qCCVr2NmhOWVqBQXliAdX0WGkTdJKvM5niUD0
         iHKg==
X-Received: by 10.52.33.167 with SMTP id s7mr20214971vdi.52.1360760536426;
 Wed, 13 Feb 2013 05:02:16 -0800 (PST)
Received: by 10.58.218.133 with HTTP; Wed, 13 Feb 2013 05:01:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216256>

Hi all,

I have problem with git svn init:
When I execute
git svn init svn+ssh://username@example.com/path/repo
I see:
fatal: Not a git repository (or any of the parent directories): .git
Already at toplevel, but .git not found
 at /usr/lib/git-core/git-svn line 342

But when I execute:
git svn clone svn+ssh://username@example.com/path/repo
Everythins is ok and I see:
Initialized empty Git repository in /tmp/svn_migration/repo/.git/

Any hints why it's no working?
I prefer to do first init and then fetch, because I can fetch selected
revisions (git svn fetch --revision 1:1000) - so it's easier for me to
split migration into groups lets say 1000 revision at once.

My software versions:
git version 1.8.1.1

svn, version 1.6.12 (r955767)
   compiled Feb 17 2012, 10:36:45

Best regards.
