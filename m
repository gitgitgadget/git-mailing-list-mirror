From: Russ Brown <pickscrape@gmail.com>
Subject: git-svn eliminating master
Date: Fri, 28 Sep 2007 15:01:51 -0500
Message-ID: <46FD5DAF.7030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 22:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbM2P-0004eZ-S4
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbXI1UCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbXI1UCG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 16:02:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:50940 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbXI1UCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 16:02:05 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1419530wra
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=woT/IqzgvV0By8jhvreNkZ8vj8U2OuX2J9gH0iUGHOU=;
        b=HPei4GZ529KjQv4JDfwQBevaIgQygNmPEwypaiNG6U51PNQ4s4W8oCbtA4Rt0dibPgKHRUL//LU3KXRQEgdEqy7aenfDtEe3cOWuAGl8AtcjtVyE/ARI3KyPhXP8YGazCn7Wz7UWJZBruEYAM/MaMbzeIT8M+Hzh54mchbfGkxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ABISOwMuPHQp2s4ZwHJw9z8UhsdtimjWriEX8Yoa//w0+A/5KXQP6zI9iokX/qSGlTuGJcQC5u304eJZAIkjl8YaXrCYHTOdl9XQQnKi7th1ceuDCvqyXE1qDI8ElqS+pPzXpBbfmhv2nvPNM5ylv6r7fqGMZc66lNWSHmLGpVs=
Received: by 10.90.55.16 with SMTP id d16mr6808216aga.1191009722718;
        Fri, 28 Sep 2007 13:02:02 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id o27sm5775502ele.2007.09.28.13.02.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 Sep 2007 13:02:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59418>

So I've been using git-svn for a while, and just decided to try
publishing my repo via gitweb so I can experiment with showing others my
local branches before I dcommit them to the subversion repository (i.e.
allowing code review prior to commit).

It's working pretty nicely: the only problem I have is the master
branch. I don't use master at all, and I'm willing to be that a lot of
other git-svn users don't either. I take all of my branches from either
trunk or one of the other upstream svn server branches.

The problem is gitweb appears to show the master branch by default,
while I'd rather show trunk by default. Is it legal to just delete the
master branch, or failing that have it automatically follow trunk so I
don't have to rebase it every time I want to push? Personally I'd rather
delete it because it's not used at all in my case and will only lead to
confuse the other developers who decide to look at my repo.

I've tried deleting master in a test repo, and it seems to be fine. But
I don't know if there are any hidden surprised that might come back to
bite me later.

Thanks.

-- 

Russ
