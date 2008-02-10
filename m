From: Sam Granieri Jr <sjgdev@gmail.com>
Subject: [Feature Request] Better Subversion integration
Date: Sat, 9 Feb 2008 20:44:59 -0600
Message-ID: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2Ci-0005GF-Oh
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYBJCpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYBJCpE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:45:04 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:31822 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbYBJCpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:45:02 -0500
Received: by py-out-1112.google.com with SMTP id u52so6163808pyb.10
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 18:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=8vpoxwabFn7ixtygiiTSjLh+TCplrIY3mjexsrCAdNQ=;
        b=IwVskaEv7M3AvG3VWY6HKdDkmtfBkY9xu/0kJvjmcD68SWckGoJyv6kgI29QLk5jdb6lLTh/UmSqjQxoe05MaxW2mYCP0Emn6ufiC9fLkRvWtxpfCtT2oPCt9mZY/sITdDwsb20ZFBifhodUkvSm55VwJiwaWU3cwstmmFVB+WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=Rgn4Wr8wRvMjRUhVq+6AL65gVwlGmxrgIFo9t7pSnGmsVeogHhowvAkS6jDDV6Ajg+qZFA0DmBX/PDeGWrP3PHrFKdH5NgwMWmwxUtu4KOa8QXJ7ZWP/L22d+XwJBy7/UmN78UDCqvpuuseKDEV9gf8APccF2nC1Yu7Vhq03EK0=
Received: by 10.35.88.16 with SMTP id q16mr16220275pyl.1.1202611501878;
        Sat, 09 Feb 2008 18:45:01 -0800 (PST)
Received: from ?192.168.5.104? ( [24.13.188.37])
        by mx.google.com with ESMTPS id x56sm46818098pyg.36.2008.02.09.18.45.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 18:45:01 -0800 (PST)
X-Mailer: Apple Mail (2.919.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73296>

Right now, git-svn import (or clone) will convert tags and branches as  
remote branches.
I would like it if git could pick up subversion tags and translate  
them as git tags upon importing

I also have some concerns with git-svn dcommit

Would it be possible for git-svn dcommit to convert locally created  
git tags to subversion tags? How about branches?

Or is git-svn dcommit only meant to push the current working  (git )  
branch to whatever (svn) branch you checked out from?

I've been using git since december and I'm trying to convert everyone  
I know to it from subversion. Unfortunately, I need to use subversion  
at work. Gits a great tool and I intend to be using it for a while.

Sam
