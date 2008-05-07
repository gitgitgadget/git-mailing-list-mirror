From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 16:15:47 -0500
Message-ID: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 23:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtr0a-0002g9-4y
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 23:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764734AbYEGVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764446AbYEGVPv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 17:15:51 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:53487 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764329AbYEGVPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 17:15:49 -0400
Received: by mu-out-0910.google.com with SMTP id w8so380597mue.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=hafqLgQeQNFNOCnRD5oRyjCtDlddAcg4bboEFbLfusA=;
        b=EhkvdmSFmLAUrexsv6jwbL36R8XWoFN56oe82vxEnAuhPR87t2M6z81PCuWjCzZH36e9B9QiDu1saJ03s/r3coEFJXXqFBmVU98BOay7+D28QYT+v0WfYxBcZKDovEtd5E8xEIliJe75N2LUyuIqJ/gCNmI7gg9sgh9bKgcqa4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yulut1Yqp+/VsHDzbH0hdn5ZexudEmTwDcLKYDuK4Q+f9UazBetQLrg1aA49pVSiV9olwQ1Yoeo8MPHwR1Gg+pQ2DotGm6GRL5GGKxu/FjVspLeCVe5G/H1bahFpuOVy/jdLDa736w/FBxvapUv+pTO5eB2lx0rdbkLNa73kH9o=
Received: by 10.86.62.3 with SMTP id k3mr4718934fga.32.1210194947392;
        Wed, 07 May 2008 14:15:47 -0700 (PDT)
Received: by 10.86.62.15 with HTTP; Wed, 7 May 2008 14:15:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81479>

How can I specify multiple refs on one line in the config file? For
example, I want "git push" to push all heads and all tags by default
so I tried this:

    [remote "origin"]
    	push = refs/heads/* refs/tags/*

That doesn't work, of course, but I imagine it is possible, and I just
can't figure out the syntax.

Thanks,
Steve
