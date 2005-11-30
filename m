From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 7/7] Use a separate directory for patches under each branch subdir
Date: Wed, 30 Nov 2005 22:23:05 +0000
Message-ID: <b0943d9e0511301423h2885d442r@mail.gmail.com>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
	 <20051129220951.9885.59702.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:25:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhaM4-0004Ou-H2
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVK3WXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVK3WXG
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:23:06 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:43307 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVK3WXF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:23:05 -0500
Received: by xproxy.gmail.com with SMTP id i30so118963wxd
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 14:23:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aBMym2E82FfJuk0P10jR+1ql4d0aVCRsSSYV7EZWjFV6GpxCFzWL+/MofkrtDslfxNMwlTsmQdAd0E9bCzFFFpNls5OA384akJJ3b+qtuVcI863gKBWNjw7BRIYV5JvMsHtjVeNy90EWhQ4uLmZMzCN2qYAvSV9sjC6D4g6Cmi8=
Received: by 10.70.118.12 with SMTP id q12mr864195wxc;
        Wed, 30 Nov 2005 14:23:05 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 30 Nov 2005 14:23:05 -0800 (PST)
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <20051129220951.9885.59702.stgit@dexter.citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13022>

On 29/11/05, Chuck Lever <cel@netapp.com> wrote:
> Currently you can't specify a patch name that matches the name of one of
> the stgit special files under .git/patches/<branch-name>.  Let's use a
> new subdirectory under .git/patches/<branch-name> to contain just the
> patch directories to remove this limitation.

This patch doesn't fix the already created branches. It would be
useful to upgrade the branch structure automatically if the patches
directory is not found.

--
Catalin
