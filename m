From: Harry Johnson <hjohnson@viasic.com>
Subject: Noob question regarding git push
Date: Wed, 19 Jan 2011 17:30:26 -0500
Message-ID: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 23:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfgXx-0007ek-Af
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 23:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab1ASWa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 17:30:28 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64425 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab1ASWa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 17:30:28 -0500
Received: by ewy5 with SMTP id 5so874116ewy.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 14:30:26 -0800 (PST)
Received: by 10.216.90.79 with SMTP id d57mr3006043wef.65.1295476226704; Wed,
 19 Jan 2011 14:30:26 -0800 (PST)
Received: by 10.216.243.129 with HTTP; Wed, 19 Jan 2011 14:30:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165297>

Hi All,

So I have a central build repo from which we perform nightly builds.
Then my development repo is a clone of the build repo. The idea is
that after I am convinced that my changes in my development repo are
stable enough I push them to the build repo using git push.

This seems to work and I can see my changes when doing a git log from
the build repo. However, the actual working files have not been
updated nor can I figure out any way to get them updated. For instance
I have tried deleting one of the files that should be changed and then
doing a git checkout <file>. The changes are still not present. I have
tried doing a git reset --hard HEAD. The file still doesn't contain
the changes. I have even tried checking out a different branch in the
build repo and then re-checking out the master that should have those
changes. Still nothing.

What's the proper technique for making sure you see the actual changes
that were pushed to a repo?

This is debian lenny with git version 1.5.6.5.

TIA,
-Harry
