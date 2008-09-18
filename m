From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add git-svn branch to allow branch creation in SVN
	repositories
Date: Wed, 17 Sep 2008 23:55:16 -0700
Message-ID: <20080918065516.GA28905@untitled>
References: <1221142839-29624-1-git-send-email-rafl@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:56:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDRD-0004Vu-Bc
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYIRGzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYIRGzS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:55:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34208 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbYIRGzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:55:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 184832DC01B;
	Wed, 17 Sep 2008 23:55:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1221142839-29624-1-git-send-email-rafl@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96172>

Florian Ragwitz <rafl@debian.org> wrote:
> Signed-off-by: Florian Ragwitz <rafl@debian.org>

Hi Florian, Sorry I haven't checked the list (nor a good chunk email) in
a bit.

The patch looks good, but can you add a test for this functionality?
It'll make maintenance easier when other people (myself included)
introduce changes that can potentially break something.  Thanks.

> ---
>  Documentation/git-svn.txt |   24 +++++++++++++++++++++++-
>  git-svn.perl              |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 65 insertions(+), 2 deletions(-)
> 

-- 
Eric Wong
