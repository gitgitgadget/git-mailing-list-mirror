From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Git/SVN: die when there is no commit metadata
Date: Sun, 8 May 2016 01:00:29 +0000
Message-ID: <20160508010029.GA11559@dcvr.yhbt.net>
References: <1462604323-18545-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thierry Suzanne <thierry@yellownemo.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G . Schwern" <schwern@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 03:00:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azD5P-0005i6-48
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 03:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbcEHBAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 21:00:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33877 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcEHBAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 21:00:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A791FAB2;
	Sun,  8 May 2016 01:00:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1462604323-18545-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293906>

Christian Couder <christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks Christian,
Signed-off-by: Eric Wong <e@80x24.org>

...And pushed to my svn/bad-ref branch for Junio.
(I don't think I'll have other git-svn-related changes
 immediately pending)

The following changes since commit 63a35025b11bf0e7ef39693aeea3b639a066b7b8:

  Sync with maint (2016-05-06 14:53:45 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn/bad-ref

for you to fetch changes up to 523a33ca17c76bee007d7394fb3930266c577c02:

  Git/SVN: die when there is no commit metadata (2016-05-08 00:50:19 +0000)

----------------------------------------------------------------
Christian Couder (1):
      Git/SVN: die when there is no commit metadata

 perl/Git/SVN.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
