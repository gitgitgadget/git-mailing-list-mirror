From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Fri, 19 Aug 2005 21:48:32 +0200
Message-ID: <20050819194832.GA8562@fanta>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 21:47:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Coz-0004cu-J2
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 21:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVHSTq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVHSTq2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 15:46:28 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:26719 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965084AbVHSTq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 15:46:28 -0400
Received: by wproxy.gmail.com with SMTP id i2so675644wra
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 12:46:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MZKvwR0xOsbsCMQhx9nPM0piimpqSp5cCT+xW7ZWIphQm+6L+lPhSPpqiBMPq5+NcxSWY9iGy3HbmNQIsQ67fQdtb3Dp1X0xtMHBfJp2w+f0LzncRKCNIBen3nl3x17dpb8wgBb7DHwE66sRpq6Bcvwyl662B79P7U+PxqLDhYw=
Received: by 10.54.158.19 with SMTP id g19mr2120615wre;
        Fri, 19 Aug 2005 12:46:20 -0700 (PDT)
Received: from localhost ([84.195.185.241])
        by mx.gmail.com with ESMTP id 11sm1311650wrl.2005.08.19.12.46.18;
        Fri, 19 Aug 2005 12:46:20 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnx64u2p81k.fsf@arm.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

> 
> The patch history feature was available in StGIT 0.1/0.2 releases
> where you should have run a 'stg commit' before 'stg refresh'. The
> commit was handling all the history changes, with separate commit
> messages and refresh was updating the main commit with 2 parents. I
> removed it in 0.3 after some people (I think it was Paul Jackson and
> Daniel Barkalow) convinced me that this would make it yet another SCM
> interface on top of GIT, which wasn't really my intention.

I've quickly reread the threads about stg commit. Am I right to assume that
_all_ history was being recorded? Because this is not what I want. The
person controlling the archive should specify when to record the history.

So for example, you only tag (freeze) the history when exporting the
patches.  When an error is being reported on that version, it's easy to view
it and also view the progress that was already been made on those patches.


Best regards,
Jan
