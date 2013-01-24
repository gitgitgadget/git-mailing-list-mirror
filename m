From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL (updated)] git-svn updates for master
Date: Thu, 24 Jan 2013 10:25:25 +0000
Message-ID: <20130124102525.GA22425@dcvr.yhbt.net>
References: <20130124012810.GA8096@dcvr.yhbt.net>
 <20130124013254.GB8096@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Barry Wardell <barry.wardell@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyK0C-0000Es-19
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 11:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3AXKZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 05:25:27 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36364 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3AXKZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 05:25:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21D51F6E1;
	Thu, 24 Jan 2013 10:25:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130124013254.GB8096@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214425>

I've squashed the change I mentioned in
http://mid.gmane.org/20130124101417.GA22138@dcvr.yhbt.net
to Barry's commit, and added Jonathan's Reviewed-by to my cleanup
commit.

The following changes since commit ec3ae6ec46ed48383ae40643990f169b65a563cc:

  Merge git://ozlabs.org/~paulus/gitk (2013-01-23 08:35:03 -0800)

are available in the git repository at:


  git://bogomips.org/git-svn for-junio

for you to fetch changes up to bc93ceb7c5ec959ad275f575a3c49ff491337a8b:

  git-svn: Simplify calculation of GIT_DIR (2013-01-24 10:21:23 +0000)

(My old master is unchanged.)

----------------------------------------------------------------
Barry Wardell (1):
      git-svn: Simplify calculation of GIT_DIR

Eric Wong (1):
      git-svn: cleanup sprintf usage for uppercasing hex

 git-svn.perl             | 37 ++++++++++++++-----------------------
 perl/Git/SVN.pm          |  4 ++--
 perl/Git/SVN/Editor.pm   |  2 +-
 t/t9100-git-svn-basic.sh |  8 ++++++++
 4 files changed, 25 insertions(+), 26 deletions(-)
-- 
Eric Wong
