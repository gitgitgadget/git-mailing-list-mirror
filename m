From: Francis Moreau <francis.moro@gmail.com>
Subject: git-rebase skips automatically no more needed commits
Date: Tue, 6 Sep 2011 18:08:48 +0200
Message-ID: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 18:08:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yCk-0003JG-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab1IFQIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:08:51 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54441 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab1IFQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:08:49 -0400
Received: by vxi9 with SMTP id 9so4759492vxi.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4BhyLz0ZIkoQ8RZ8GJ7cPa0Lmsat5EcC3caNuSETXbA=;
        b=CFFyBBBsTzbFzBezO4i21X+MC1xIh2d2LknBYspMKVOTAtgQ9OAbh6BkmH2GNfLTsf
         cF6I7rbvfgl3OmVB7nRO1ytQx8t8zOvznBH47zds+Ymks+Eib1+crQJb6v5CXlyA+PHs
         gbbppyd1LpgjnIw1GJR0yBf3sgfqIKf6kNMz0=
Received: by 10.52.91.103 with SMTP id cd7mr3777951vdb.397.1315325328773; Tue,
 06 Sep 2011 09:08:48 -0700 (PDT)
Received: by 10.52.110.2 with HTTP; Tue, 6 Sep 2011 09:08:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180810>

Hello,

When rebasing my current branch onto the last master one, there're
sometimes some commits which doesn't add anything anymore.

Currently git-rebase produces the following message:

    nothing added to commit but untracked files present (use "git add" to track)

Would it be possible to add a new option to this command so it simply
skip the unneeded commit ?

Thanks
-- 
Francis
