From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: introduce --parents parameter for commands
 branch and tag
Date: Mon, 20 May 2013 22:46:45 +0000
Message-ID: <20130520224645.GA9557@dcvr.yhbt.net>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
 <1368648883-9412-1-git-send-email-tobias.schulte@gliderpilot.de>
 <20130520221340.GA8781@dcvr.yhbt.net>
 <7vobc5th0c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tobias Schulte <tobias.schulte@gliderpilot.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYqx-0001wl-HH
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab3ETWqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:46:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46186 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab3ETWqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:46:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2329A1F42C;
	Mon, 20 May 2013 22:46:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vobc5th0c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224991>

Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; is it a good time for me to pull?

Yes, I think so.  Thanks!

The following changes since commit de3a5c6da194928868b5eee4a9c4d538b4194727:

  Git 1.8.3-rc3 (2013-05-17 12:19:20 -0700)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to f4f4c7fc00e8acf91150c717cf005fc36c1dd120:

  git-svn: introduce --parents parameter for commands branch and tag (2013-05-20 22:05:54 +0000)

----------------------------------------------------------------
Jonathan Nieder (1):
      git-svn: clarify explanation of --destination argument

Nathan Gray (1):
      git-svn: multiple fetch/branches/tags keys are supported

Tobias Schulte (1):
      git-svn: introduce --parents parameter for commands branch and tag

 Documentation/git-svn.txt                | 36 ++++++++++++++++++++----
 git-svn.perl                             | 19 ++++++++++++-
 t/t9167-git-svn-cmd-branch-subproject.sh | 48 ++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100755 t/t9167-git-svn-cmd-branch-subproject.sh

-- 
Eric Wong
