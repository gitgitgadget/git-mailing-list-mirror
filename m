From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Marking abandoned branches
Date: Wed, 13 Sep 2006 11:17:59 -0400
Message-ID: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 13 17:18:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNWV2-0005DT-J7
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 17:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWIMPSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWIMPSA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:18:00 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:19285 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750911AbWIMPSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 11:18:00 -0400
Received: by py-out-1112.google.com with SMTP id n25so3211489pyg
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 08:17:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NLQ0bty36RFaKTY5S7in0YcB9GKk5d7y8+n5NZPdKz/xWSjSXyB9RTIbpKh+kqIW/T8os3GPVs4JhXUOjMNyvVl0xbaI5Ug2duT+9Fvr8QyV83KD73PRx7BZ67m9j5MT1vqJJcgiTC407KobbLbRJu9avwJLvzr7UoLtDCHo6g0=
Received: by 10.35.132.13 with SMTP id j13mr13163157pyn;
        Wed, 13 Sep 2006 08:17:59 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 13 Sep 2006 08:17:57 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26913>

Since branch refs are being worked on it would make sense to add an
object that marks a branch as being abandoned. The visualization tools
would use this to suppress viewing of these branches in their default
display.

For example Mozilla has 100s of branches that were abandoned five or
more years ago. No point in having them impact a current gitk display.

You would add an abandoned branch marker after the last commit on the
branch and adjust the branch ref to point at it. If you want to open
the branch again point the branch ref back to the last commit and let
git prune remove the marker.

Abandoned branches are common in CVS since it is not distributed.
People start working on something in the main repo and then decide it
was a bad idea. In the git world these branches usually don't end up
in the main repo.

-- 
Jon Smirl
jonsmirl@gmail.com
