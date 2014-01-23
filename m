From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-svn: memoize _rev_list and rebuild
Date: Thu, 23 Jan 2014 02:58:07 +0000
Message-ID: <20140123025807.GA4370@dcvr.yhbt.net>
References: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: manjian2006@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 23 03:58:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6AUh-0000Md-4A
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbaAWC6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 21:58:10 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57616 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbaAWC6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 21:58:09 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D8920972;
	Thu, 23 Jan 2014 02:58:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240900>

manjian2006@gmail.com wrote:
> According to profile data, _rev_list and rebuild consume a large
> portion of time.  Memoize the results of _rev_list and memoize
> rebuild internals to avoid subprocess invocation.
> 
> When importing 15152 revisions on a LAN, time improved from 10
> hours to 3-4 hours.
> 
> Signed-off-by: lin zuojian <manjian2006@gmail.com>

Thanks!
Signed-off-by: Eric Wong <normalperson@yhbt.net>
Pushed for Junio.

The following changes since commit d9bb4be53bc5185244b4be9860562a012803bacb:

  Merge tag 'gitgui-0.19.0' of http://repo.or.cz/r/git-gui (2014-01-21 13:16:17 -0800)

are available in the git repository at:


  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to ab0bcec9873f1fcef6c4b8825cc9e762c636ca9e:

  git-svn: memoize _rev_list and rebuild (2014-01-23 02:54:26 +0000)

----------------------------------------------------------------
lin zuojian (1):
      git-svn: memoize _rev_list and rebuild

 perl/Git/SVN.pm | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)
