From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: add (failing) test for a git svn gc followed
	by a git svn mkdirs
Date: Tue, 22 Dec 2009 22:18:42 -0800
Message-ID: <20091223061842.GA4323@dcvr.yhbt.net>
References: <57d579150912222008j19b16b1aq88ebd0938c2553e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 07:18:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNKYa-00050F-El
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 07:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbZLWGSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 01:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZLWGSn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 01:18:43 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45099 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbZLWGSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 01:18:43 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E2F1F525;
	Wed, 23 Dec 2009 06:18:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <57d579150912222008j19b16b1aq88ebd0938c2553e9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135614>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> git svn gc will compress the unhandled.log files that git svn mkdirs reads,
> causing git svn mkdirs to skip directory creation.
> ---
>  t/t9152-svn-empty-dirs-after-gc.sh |   41 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9152-svn-empty-dirs-after-gc.sh

Hi Robert,

I actually got impatient over the weekend and committed a test case and
fix.  I believe I Cc-ed you on it...  But your test case might be
cleaner, but yes, same things Junio said.

-- 
Eric Wong
