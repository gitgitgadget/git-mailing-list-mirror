From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: make use of svn auto-props optional
Date: Thu, 24 Jul 2008 22:50:58 -0700
Message-ID: <20080725055058.GA14756@untitled>
References: <4885024D.2070402@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 07:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMGDl-0000UE-Mn
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 07:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYGYFvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 01:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYGYFvA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 01:51:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34640 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbYGYFu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 01:50:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 277AA2DC095;
	Thu, 24 Jul 2008 22:50:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4885024D.2070402@kitware.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90001>

Brad King <brad.king@kitware.com> wrote:
> 
> In order to preserve existing default behavior, dcommit should use svn
> auto-props only if instructed to do so.  This commit creates a config
> option 'svn.autoprops' to enable the behavior.

No need for this.  auto-props is the correct and expected behavior for
users coming from the `svn' client.

There's no backwards compatibility issue, either, since this only
affects new commits that git-svn makes.

Thanks.

-- 
Eric Wong
