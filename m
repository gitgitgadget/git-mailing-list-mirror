From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem with cg-merge
Date: Sun, 29 May 2005 20:17:51 +0200
Message-ID: <1117390671.7072.102.camel@pegasus>
References: <1117379092.7072.90.camel@pegasus>
	 <3798.10.10.10.24.1117384256.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:18:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSLl-0007BM-01
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVE2SSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVE2SSt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:18:49 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26810 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261384AbVE2SRv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 14:17:51 -0400
Received: from pegasus (p5487DF90.dip.t-dialin.net [84.135.223.144])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4TIJZSs021754
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 29 May 2005 20:19:36 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3798.10.10.10.24.1117384256.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Sean,

> > I saw that earlier, but I don't have any idea what's wrong here. If I do
> > a simple cg-update, I see something like this:
> >
> > Tree change:
> > cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
> > :100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38
> > fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
> > :100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739
> > 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help
> >
> > Applying changes...
> > Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 ->
> > 89a14a5bd2c880095d5c618a102319bb3dc03da9
> >         on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
> > patching file cg-diff
> > patching file cg-help
> > cg-diff: needs update
> > cg-help: needs update
> >
> > This is a little bit odd, because if I call "git-diff-cache HEAD" after
> > it, I will see that cg-diff and cg-help are modified. After calling
> > cg-cancel everything looks fine again.
> 
> Any chance you've installed a copy of git core in addition to your
> original install of Cogito?   That looks like a problem i saw when using a
> newer git installed overtop of Cogito.

no, I don't.

Regards

Marcel


