From: Jon Smirl <jonsmirl@gmail.com>
Subject: Linus kernel tree corrupt?
Date: Fri, 8 Jul 2005 11:57:11 -0400
Message-ID: <9e473391050708085756bd463e@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jul 08 17:58:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqvEV-0004Lh-1Z
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 17:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVGHP5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGHP5i
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 11:57:38 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:35470 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262692AbVGHP5h convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 11:57:37 -0400
Received: by wproxy.gmail.com with SMTP id i1so487676wra
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 08:57:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ri4y/3LB2wbHFXYj/FAkBxT/UzdgJ+LmNd8hCHnLePHFVThnRSMSBZqYZO7CSPwD31iyih9us583vPG2yBnYsel0RQbUdOWKneEYJvpoS6IiYoI08xmPwC1ywgrw6z58zIK5ib84rOQNq8Iy6OoYTfn7R6glGHDnN+GvdmIYhaE=
Received: by 10.54.8.9 with SMTP id 9mr1724385wrh;
        Fri, 08 Jul 2005 08:57:11 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Fri, 8 Jul 2005 08:57:11 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

What happened in this session...

[jonsmirl@jonsmirl linus]$ cg update
11:52:32 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.g
it/refs/heads/master [41/41] -> "refs/heads/origin" [1]
progress: 34 objects, 102329 bytes
error: File 9cd17004869977026b473030ebb5b6fb71bfcebf
(http://www.kernel.org/pub/
scm/linux/kernel/git/torvalds/linux-2.6.git/objects/9c/d17004869977026b473030ebb
5b6fb71bfcebf) corrupt

Cannot obtain needed tree 9cd17004869977026b473030ebb5b6fb71bfcebf
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
[jonsmirl@jonsmirl linus]$ cg update
11:53:26 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.g
it/refs/heads/master [41/41] -> "refs/heads/origin" [1]
Up to date.

Applying changes...
Branch already fully merged.
[jonsmirl@jonsmirl linus]$ cg pull
11:53:33 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.g
it/refs/heads/master [41/41] -> "refs/heads/origin" [1]
Up to date.
[jonsmirl@jonsmirl linus]$ cg diff
error: cannot read sha1_file for 9cd17004869977026b473030ebb5b6fb71bfcebf
fatal: unable to read tree object 7fd73e9f39bf6003cc3188a10426b62d8c47ab40
[jonsmirl@jonsmirl linus]$

-- 
Jon Smirl
jonsmirl@gmail.com
