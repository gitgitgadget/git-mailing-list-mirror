From: Daniel Grace <negativeview@gmail.com>
Subject: Lost a week?
Date: Thu, 15 Apr 2010 08:57:50 -0500
Message-ID: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 15:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2PZy-0006Mi-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 15:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab0DON55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 09:57:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:20004 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0DON55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 09:57:57 -0400
Received: by qw-out-2122.google.com with SMTP id 8so446501qwh.37
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=yp/hNWn8eGcEWHbke+qg1XYKWATrgGpTRaGZRypq+9M=;
        b=BE5gB1FArD77qNZHUWh7FUV2LJra75VfV0WlNBfxpzrnuye3T5cq/aVcHRMuK/IPa7
         ZdwjS2Rm+QBr59k0MGLgrHPBvrpBf79GVXyTJkAecNqpE7PDzn6zYVE3N4uXJ7IgTbEJ
         XxvUSirU2AxT7/EMP60ItvUrIw0fOF5MAUxjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nuXM9lB0nRPWsJ6IbQKqNfThh/b2KptN8FMSCjhHMgped0TV9q3vB0v/7KTqwxE0ub
         scV5WWwyEI1LjRUl7ovRRp6E4rNXUOtbuTbmACsI7kXjN2fVlYvka5CFjDnPGD426/Rt
         PyrBYJNVftPUVbaT+1hcO1i8kWGeeOs8zGl+k=
Received: by 10.229.86.140 with HTTP; Thu, 15 Apr 2010 06:57:50 -0700 (PDT)
Received: by 10.229.35.80 with SMTP id o16mr6304744qcd.93.1271339870975; Thu, 
	15 Apr 2010 06:57:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144986>

Appologies for not having more information. I usually use git as if
it's just SVN with non-network checkins.

A few days ago, I pushed my git repository to github:

127  git remote add github
git@github.com:negativeview/Wherespresso.git [Note, this is a private
repo]
128  git push github master

I then went about doing real-world business. I noticed at some point
that when I did a `git status` it said that no branches were checked
out. I don't remember doing anything between pushing to github and
this state. If I did a git branch it shows something like * (no
branch) then below that, master. I shrugged it off and did what I
expected to fix that odd issue:

515  git branch
516  git checkout master

Now, the next day, I noticed that I have no git history between the
6th and something I did soon after the git checkout master:

$ git log | grep Date | head -n 5
Date:   Wed Apr 14 14:43:58 2010 -0500
Date:   Tue Apr 6 00:42:20 2010 -0500
Date:   Mon Apr 5 23:57:54 2010 -0500
Date:   Mon Apr 5 07:01:26 2010 -0500
Date:   Mon Apr 5 06:17:18 2010 -0500

github shows the same. I KNOW that there were commits (representing a
good bit of work) in that time. I'm sure that it's *somewhere* but I'm
at a complete loss as to where it is. gitk shows no side branches (nor
does git branch). I don't use branches really, as much as I know that
I should.

Daniel
http://www.doomstick.com
