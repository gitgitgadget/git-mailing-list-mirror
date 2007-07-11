From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: user manual wrong about remote branches?
Date: Wed, 11 Jul 2007 11:21:53 -0400
Message-ID: <f158199e0707110821k50a55e66p8fb0b92a3dec9ed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8e0y-0000NB-Mu
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264AbXGKPV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765415AbXGKPV5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:21:57 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:57233 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765408AbXGKPVz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:21:55 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1210755ika
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 08:21:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FJyFTNPwfyoaf06KrxSKcfij29kRSeJkfNa9IZ5NtG4avUDEWNtmI+FvQD9gS8WmtGHH/c0CTSmMcJlgptCrOI6ajrOVr4CUlBsWVR5LcMAU0Z0YItI8i9YcZWJGivSM/Otv90gHJoMz9kD2DqE1ztE95w8lRn2nWo5TS6rTPJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UaXHAT1MLhDPsjLtBoincoOfQO8gKt6XfYCgahqEsChz5sl0LXYaSNlW9JzCzO+BP5VLi3C2H6wzELSCdMPba9wkq9b4UQhp2kFbUZrdf/tmFCllvhpiSvrxriMJPB9qjQxNYSSfjqHY4vSvWqHHDppKpbG4SFkPcXf6hsahzuw=
Received: by 10.78.166.7 with SMTP id o7mr2460348hue.1184167313290;
        Wed, 11 Jul 2007 08:21:53 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Wed, 11 Jul 2007 08:21:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52168>

I got the latest git source like this:

git clone git://git.kernel.org/pub/scm/git/git.git

Then I did:

make prefix=/usr/local all doc
make prefix=/usr/local install install-doc

So my current version is:

git version 1.5.3.rc0.gbaa79

Now, Documentation/user-manual.txt says I should be able to see the
remote branch I cloned from when I do this in the source directory.

git branch -r

However, this command gives no output at all.  What gives?  Does this
mean git-fetch and git-pull won't work properly to keep me up-to-date
with the main repository?

Thanks,

Bradford C. Smith
