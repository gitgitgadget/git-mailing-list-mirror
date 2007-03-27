From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn, remote tracking branch question
Date: Tue, 27 Mar 2007 13:26:43 -0700
Message-ID: <m2ps6usa9o.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 22:26:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWIFu-0005Ys-Pq
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 22:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbXC0U0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934005AbXC0U0t
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 16:26:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbXC0U0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 16:26:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so8177uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 13:26:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=lAFuHmEaR5BhOhLu8+m63RjaoX1+TctlwkbLenX68Yr0FwmFW8IIQEDlcyCtw5Y4vcApQo/LVGjL00qHk8rcle9pBphgVNFuG4Sc2ohL8vBEz/k/BoT4A6E6wV4r1oonKcubE6JHwx3+FaeVNQhxtizKEtkXSu/UUyIK3Oo2aT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=CY3KF/Xb3RnPwWmKcRuedpAbA21t2r2sAXZq4yzN8JGyV1xzOXtEtjWn0Mq9dvPoauEwHLPNd4fjOpeQ9s8SOn8yrU42i47enbFbIJFGlmmIQx2RECu9ZRkcU5qbePU7QV+7H5AePqdRopbkPMemLXS1UvUkVaH3UQ0ssIw4tKs=
Received: by 10.114.161.11 with SMTP id j11mr3318707wae.1175027205592;
        Tue, 27 Mar 2007 13:26:45 -0700 (PDT)
Received: from ziti.fhcrc.org ( [140.107.156.111])
        by mx.google.com with ESMTP id y11sm1427550pod.2007.03.27.13.26.45;
        Tue, 27 Mar 2007 13:26:45 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43304>

Hi,

I've edited my <repos>/.git/config file so that git-svn is tracking
the main devel line as well as a release branch of a project.  This
seems to work well.

So I have:

[svn-remote "svn"]
	url = https://svn.url.com/root
	fetch = branches/release-2-5:refs/remotes/2.5
	fetch = trunk:refs/remotes/git-svn

I can checkout the 2.5 release branch like this:

   git checkout -b 2.5 remotes/2.5

But at this point, how do I ask git-svn to update it?  When working on
the devel line, I can do 'git svn rebase' and I would like to do the
same thing but relative to the branch.

Perhaps there is some config I can add so that I don't have to do:

   git svn fetch
   git rebase remotes/2.5

That isn't so bad except for having to remember where you are...

Thanks,

+ seth

-- 
Seth Falcon
