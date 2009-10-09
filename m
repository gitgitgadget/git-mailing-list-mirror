From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] Documentation: clone: clarify discussion of initial
 branch
Date: Fri, 9 Oct 2009 05:18:25 -0500
Message-ID: <20091009101825.GE16558@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwCcQ-0007cM-3M
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760633AbZJIKRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760538AbZJIKRS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:17:18 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51820 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760617AbZJIKRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 06:17:17 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2009 06:17:17 EDT
Received: by yxe17 with SMTP id 17so510012yxe.33
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=W+dWpuFTcuWjxplYDrXkH/VlHFGfipnFM53E1lJHqSQ=;
        b=NYV94myKPmvSKqyFc00pT28EZ26ywKf1gtS9nrCnFtX84KPSayT3xN9UX2iR+s8Rr/
         IPx/uHbc+TFE6ARdgjGAjJaHNqkaL7bSDhvTBoXS7FDqUUGqosOMEELnhxrn2Up1SyeZ
         xsFqYzDDhOiGIg1OJB0sCYgxq9BfCl5a1SSIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lL82Lq6fyyIgd7JBvIZduNtmT+0Ncq/gyZT3edwI+9OC5C0aiLdTHA71WzPxe2x7VT
         Er8YjPEr6qOKGDMZa9B5c7t13VEqKGp9D3s6OVVzZIMrXL3K3pinaGXYFRHBN/hwXeIs
         V+L6zbWY5bEVt8++ElZLKtyY/Hte2qkczba3w=
Received: by 10.150.113.3 with SMTP id l3mr4451993ybc.90.1255083012787;
        Fri, 09 Oct 2009 03:10:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm446391gxk.13.2009.10.09.03.10.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 03:10:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009101400.GA16549@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129766>

When saying the initial branch is equal to the currently active
remote branch, it is probably intended that the branch heads
point to the same commit.  Maybe it would be more useful to a new
user to emphasize that the tree contents and history are the
same.

More important, probably, is that this new branch is set up so
that "git pull" merges changes from the corresponding remote
branch.  The next paragraph addresses that directly, but
clarifying the initial content of the branch should make it
clearer why a pull is required at all (that local and remote
branches each have their own history after the clone).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-clone.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index aacf4fd..7cd06e2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -20,7 +20,8 @@ DESCRIPTION
 Clones a repository into a newly created directory, creates
 remote-tracking branches for each branch in the cloned repository
 (visible using `git branch -r`), and creates and checks out an initial
-branch equal to the cloned repository's currently active branch.
+branch with the contents of the cloned repository's currently active
+branch.
 
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
-- 
1.6.5.rc1.199.g596ec
