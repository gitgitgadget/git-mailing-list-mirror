From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 7/7] Use a separate directory for patches under each branch subdir
Date: Wed, 30 Nov 2005 22:32:50 +0000
Message-ID: <b0943d9e0511301432m10b25887r@mail.gmail.com>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
	 <20051129220951.9885.59702.stgit@dexter.citi.umich.edu>
	 <b0943d9e0511301423h2885d442r@mail.gmail.com>
	 <438E2797.2020205@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:36:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhaVT-0000Yw-LB
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVK3Wcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVK3Wcv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:32:51 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:14454 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751114AbVK3Wcv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:32:51 -0500
Received: by xproxy.gmail.com with SMTP id i30so120681wxd
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 14:32:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tJjKpI1sLIkAF0HeH6nlfB41w1txWBXx8aT+RO/DsXVJaxxzYMc25VlpIJWHA+sSfCpUtGFlub4PkSmdh1gpd0gfiHJfdNu8TjwOiWub3/yMgftviMdMtdAqJsneCSVy7ajlLOJwESxXcE26eFrFaiIsuR7XGfelzaYqX8sLjWo=
Received: by 10.70.116.3 with SMTP id o3mr907785wxc;
        Wed, 30 Nov 2005 14:32:50 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 30 Nov 2005 14:32:50 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <438E2797.2020205@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13026>

On 30/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> Catalin Marinas wrote:
> > This patch doesn't fix the already created branches. It would be
> > useful to upgrade the branch structure automatically if the patches
> > directory is not found.
>
> the reason i didn't do that is because i wanted to allow older versions
> of StGIT to continue to work on existing repositories.

You are right.

> what if i added a migration tool to allow a user to switch back and forth?

A separate stg command for this would be useful. Anyway since the
repository structure might change again in the future, I think it
would be better to have a version string saved somewhere in
.git/patches/version for reference.

--
Catalin
