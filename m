From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list --merge-order hangs
Date: Wed, 8 Jun 2005 17:22:04 +1000
Message-ID: <2cfc4032050608002258e58897@mail.gmail.com>
References: <42A69550.1030105@gorzow.mm.pl>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:20:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfupO-0006M2-0t
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 09:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVFHHWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 03:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVFHHWK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 03:22:10 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:30848 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262129AbVFHHWG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 03:22:06 -0400
Received: by rproxy.gmail.com with SMTP id z35so66998rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 00:22:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aZyfLUjioC7yafA1zhrhsdn75r9gvVuCLBSt0toJYUkTc18rQ1cFTuleJBhFIyzeo11zMEIR9ivdadZncy1XP07jMdX6kFzUR4lx7mQxsKlj54ajWVfHa4+EBeVRYnUPJl5O9Fq3s0TfstwJbCxVMzxDuI0TrsrreWJWxB0xa44=
Received: by 10.38.11.34 with SMTP id 34mr3541943rnk;
        Wed, 08 Jun 2005 00:22:04 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 00:22:04 -0700 (PDT)
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <42A69550.1030105@gorzow.mm.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/8/05, Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
> I've got a Linux git tree with some merges and some other commits
> interwined.
> I want to print all my changes in merge order, so I do:
> 
> git-rev-list --pretty --merge-order v2.6.12-rc6-astorm1 ^v2.6.12-rc6
> 
> It prints the first 3 commits (linear), but then hangs, eating all
> available CPU.
> Without --merge-order it works fine, but obviously lists the commits by
> parent.

Can you git-rev-list >/dev/null without arguments, then do a
git-rev-list --pretty --merge-order again and see it works any better?

If it still doesn't work, can you send me the output of:

        git-rev-list --parents v2.6.12-rc6-astorm1 ^v2.6.12-rc6 

I may then need to request a tarball of the related git objects so
that I can reproduce the problem on my end, but I'll send you the list
I need to see.

Regards,

jon.
