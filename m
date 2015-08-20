From: Konstantin Hollerith <khollerith@gmail.com>
Subject: Why does 'git branch -d' act differntly after clone?
Date: Thu, 20 Aug 2015 14:10:37 +0200
Message-ID: <CALwJaCzYgDKdcT7H7=5x0fnNRv4MsrtjJoHJcB9rJyh3dU--xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 14:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSOgC-0007OK-VM
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 14:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbHTMKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 08:10:40 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34478 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbbHTMKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 08:10:38 -0400
Received: by oiey141 with SMTP id y141so21241294oie.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=D+Yv5791MlLOvAAC/S7SFIE4RQ82kwWVXjHoVhKNRO4=;
        b=OvdQNWgdnNGzu/kxRrDV9NkohrOe9M24wG36n2nEX51U4KCP0ZUCUyyhVBOI0xyRA2
         QakFoxzMqd/ONGLXgYigEiAvN2JP5l0iPEcJujKcJxPnRgzVKkTZYALVpXGQN4sCLYJo
         EoO66vk2pYFzHYZyXh5A2XWpvAM6TvZdd/KwojbzzslCHukW2aG+YQumgkhLWyIlhfR5
         WUd0zntjuBy9llOBQExfyVnyTAIkB7iBaubNb92PLzPIEg4hhl7CQOyAKqqXFG6oLiEU
         vB7OWwOaOG+hsHkVOd45eFRFs4RR9MUm13xJzC6vW7iSuLdKKv6qfZu5n+k5cCHG0nt5
         OX9A==
X-Received: by 10.202.15.11 with SMTP id 11mr2281122oip.127.1440072638054;
 Thu, 20 Aug 2015 05:10:38 -0700 (PDT)
Received: by 10.76.38.227 with HTTP; Thu, 20 Aug 2015 05:10:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276235>

Hi,

I created a simple repository.
If i create a new branch from master and commit some changes and
then delete it with

    git branch -d neuerTestBranch

I'll get a error:

    error: The branch 'neuerTestBranch' is not fully merged.

I like that error, it reminds me, that i forgot to merge.
However, if i don't delete this branch and clone the Repository somewhere
else, i don't get the error anymore. When i delete the branch now, i get
this message:

    warning: deleting branch 'neuerTestBranch' that has been merged to
    'refs/remotes/origin/neuerTestBranch', but not yet merged to HEAD.

And the Branch is deleted right away.

Why does git branch -d acts differently after a clone?
Is this behavior maybe a Bug?
Is it possible to force a behavior like the first in cloned repositories,
too?

I use 'git version 2.5.0.windows.1'.

Cheers,
Konstantin
