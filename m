From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Thu, 02 Aug 2012 00:27:06 +0200
Organization: Debian
Message-ID: <5019AD3A.8030609@debian.org>
References: <1343856197-6393-1-git-send-email-robert@debian.org> <20120801214318.GA10384@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robert Luberda <robert@debian.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhOH-0002iC-LG
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab2HAW1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:27:37 -0400
Received: from master.debian.org ([70.103.162.29]:52920 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab2HAW1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:27:36 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1SwhO6-0004uO-P5; Wed, 01 Aug 2012 22:27:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id 7EFDCE2AF1;
	Thu,  2 Aug 2012 00:27:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.5) Gecko/20120624 Icedove/10.0.5
In-Reply-To: <20120801214318.GA10384@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202736>

Eric Wong wrote:

Hi,

> 
> I've long wanted to change this, but it breaks compatibility if folks
> are importing from the same repo, sharing changes and one upgrades
> git-svn.

Yes, I'm aware of this. That's why in our team at work everybody is
forced to use the modified version of git-svn:)
[ A bit of background: we have recently started using git svn at after
our main repository had been migrated to svn. Previously git over
clearcase approach was used; we established some workflow and a part of
it was to use gerrit for code reviews, however it turned out to be
hardly possible with git svn. On the other hand the lack of error
handling was pretty annoying when changes get rejected by svn pre-commit
hook. That's why I wrote the two patches I sent today. ]

> How about making this optional and configurable at init/clone time?

I don't think it will be hard to make it configurable. I can try to make
such a change, do you have any preferences about the option and
configuration key names?

Thanks a lot,
robert
