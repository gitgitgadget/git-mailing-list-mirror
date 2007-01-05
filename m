From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Bugs in gitweb
Date: Thu, 4 Jan 2007 17:29:20 -0800 (PST)
Message-ID: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jan 05 02:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2dtk-0006Sh-HI
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 02:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbXAEB3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 20:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAEB3W
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 20:29:22 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:31964 "HELO
	web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932241AbXAEB3V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jan 2007 20:29:21 -0500
Received: (qmail 87600 invoked by uid 60001); 5 Jan 2007 01:29:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=X2bSwAnrlHx47I8LhZQQI15xF3XjDGYysWFuUv7ZHM4ziwUlo9WexttJfcDpD6dRGCBhjHebJiNjMrOSnyyh//d2m1aZxt/duwVyGAMqwQWJTYFx8/8AdKNqG7GR7YR3Gp1Sztzi+HCL8hz46HEH2xPQaKPjoeeSkq7UABLIydk=;
X-YMail-OSG: rG1V7RAVM1noLQifL_zZQJITX8BFjwII8suGmNsF
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Thu, 04 Jan 2007 17:29:20 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35966>

gitweb has two bugs in git_patchset_body (now you know who
you are without data-mining with git-blame).

The first bug is a missing "</div>" on commitdiff.
Saw this one a couple of days ago, but was swamped
and had no time to post.

The second bug is displaying a renamed file with the
same name as the one of the preceding "patch". Saw
this one today when I pulled.

To exhibit these, you need to "commitdiff" a commit
which has at least one rename and at least one regular
diff preceding the rename.

Can the guilty parties (you know who you are) please
fix this.

"And while at it" can you please actually *do* "refactor"
git_patchset_body *into smaller functions each one doing
a single particular task*.

It is sad to see git_patchset_body in such despicable state
all the while seeing words like "refactor" in the commit logs
of that function.

git_patchset_body is grossly overloaded for what it is
supposed to do to, and being one single huge blob, it is
hard to maintain.

Thanks,
    Luben
