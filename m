From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/7]
Date: Wed, 30 Nov 2005 22:27:36 +0000
Message-ID: <b0943d9e0511301427j28d64dd8j@mail.gmail.com>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:29:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhaQN-0006bs-Ts
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVK3W1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVK3W1h
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:27:37 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:59471 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750976AbVK3W1g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:27:36 -0500
Received: by xproxy.gmail.com with SMTP id i30so119781wxd
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 14:27:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AUSDgghKcb5/jPTVofQYE/c0QIq4hJHtKg/QhRMpqXM0afHXkBGBSd6Vha9hZSA4IWu2TQrQLRV66pLDmXiFzf/GojV16hFGKyQUNT9PTLycY0Ex1GtSxtTvSFCgE8ysHFJJiXQhWUJkqeN8/kOIwzmqtw4G52UxkRFCtkpm9lM=
Received: by 10.70.104.5 with SMTP id b5mr872903wxc;
        Wed, 30 Nov 2005 14:27:36 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 30 Nov 2005 14:27:36 -0800 (PST)
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13024>

On 29/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> + stg-in-subdirectories   | Use git-rev-parse to find the local GIT repository
> + fix-branch-description  | Align branch descriptions in output of "stg branch -l"
> + stg-series-description  | "stg series" option to show patch summary descriptions
> + stg-series-short        | Add facility to print short list of patches around 'top'

I applied the above patches.

> + stg-branch-clone        | Add a "--clone" option to "stg branch"

I'll comment on this tomorrow since I need to look at it in more
detail. One thing I would prefer is to be able to specify a name for
the newly cloned branch rather than generating one by default (which
can stay as well, as long as a 2nd argument with the name is not
given).

> Before 0.8, you might also consider addressing the patch authorship issues
> that come up when mailing out patches, as discussed on git@vger last week.

Yes, I will.

Thanks for the patches.

--
Catalin
