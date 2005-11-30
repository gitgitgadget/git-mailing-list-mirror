From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/7] Make "stg export" save the base commit in the output directory
Date: Wed, 30 Nov 2005 21:53:21 +0000
Message-ID: <b0943d9e0511301353p5b8a3b82i@mail.gmail.com>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
	 <20051129220938.9885.37456.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 22:57:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhZtE-0007OG-SK
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 22:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVK3VxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVK3VxW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 16:53:22 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:28469 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750857AbVK3VxV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 16:53:21 -0500
Received: by xproxy.gmail.com with SMTP id i30so112606wxd
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 13:53:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eIaOcAo8/lk+QldQO7p9EkiF6fn/XJehu4uwkCBGdmtIENJbx4O3GL1VvXW0sPnAGr9V2CDadAVJ0YCr3yG9fxcup3C+TaDDIf21K9J1e0ClPdul4tuh8OBkWVj24Bpf0uGkZUgQr/hfLDK1+qgqxxcnafXgxPXAwcqroaCmzUY=
Received: by 10.70.118.12 with SMTP id q12mr829886wxc;
        Wed, 30 Nov 2005 13:53:21 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 30 Nov 2005 13:53:21 -0800 (PST)
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <20051129220938.9885.37456.stgit@dexter.citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13018>

On 29/11/05, Chuck Lever <cel@netapp.com> wrote:
> When trying to apply a series of diffs that was exported from an StGIT
> series, it can be convenient to know exactly which base commit the
> patches apply to.  Save that commit in a file patchdir/base.

I would rather save it as a comment ('#' prefixed) in the series file.

--
Catalin
