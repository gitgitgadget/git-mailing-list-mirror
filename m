From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: question git & branches
Date: Mon, 29 Aug 2005 14:15:51 +0200
Message-ID: <81b0412b050829051514bf02f2@mail.gmail.com>
References: <4312C24E.4000803@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 14:17:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9iYQ-00073x-BV
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 14:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVH2MPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 08:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVH2MPz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 08:15:55 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:12117 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750822AbVH2MPy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 08:15:54 -0400
Received: by nproxy.gmail.com with SMTP id x37so300332nfc
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 05:15:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+fO0ZbYC3HsrdbNV8JmLFuhWE+caVGQyicttuvTzhjk44FnyfqNdRarF/k/t0Xs92z3reA7kXYC2DJ6NtWN187/7Rz4rM6fni6trN4Xt5uTy9bePEkjWaZDW6wwkDpUaqTdbRS4z9x5UpWFBwOkgpKofUc9ccQ3GLbPUImjkEg=
Received: by 10.48.49.19 with SMTP id w19mr284012nfw;
        Mon, 29 Aug 2005 05:15:51 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Mon, 29 Aug 2005 05:15:51 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <4312C24E.4000803@candelatech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7901>

On 8/29/05, Ben Greear <greearb@candelatech.com> wrote:
> I think I'm missing something fundamental though...  I wanted to
> change to the ben_dev_rfcnt branch to build a kernel without my
> additional patch.  git branch ben_dev_rfcnt seems to change
> it fine, but all of the changes for repository 'foo' are also
> still here.

You probably looking for "get reset --hard master",  which should bring the 
working tree in sync with cache, but being new to git myself, I'm not sure.
