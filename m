From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 11:25:42 +0200
Message-ID: <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Jun 01 11:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3OJ-0002DX-2m
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXFAJZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755704AbXFAJZo
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:25:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:65255 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbXFAJZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:25:43 -0400
Received: by nz-out-0506.google.com with SMTP id n1so457605nzf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 02:25:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZVG3zh1EFlPO4rvuxCLZS+MZSBvVHfw/QYsGmfma1Fj4ODNBB6VIYVm8pFJVl3pPGphFvrTn4Tas1nOZlz7HDrgqDn2UvDpofL2Ai9GIpNclXuZDU6uTgqP6HtTgKxFpyOMURvfdzF3dsHx2/RghR8tMFujyMA/u2Ki5NAVE0Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DTM4VYf0IpaCqf82pSXRAWF33RsCd0EbrdLtDFZFoxhDdmaaE9jGVAdTv4PEeE0Mdv916rMtqNsM/hZyHH1iIZPhNGRHGN67plZfTo9JXPLRpTX2CokOcw/kAnGsBYMmd8FtEH3tgfMACkysTVoy10UvL/oExQij8vZ0VK87xaw=
Received: by 10.115.75.1 with SMTP id c1mr1592628wal.1180689942522;
        Fri, 01 Jun 2007 02:25:42 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 1 Jun 2007 02:25:42 -0700 (PDT)
In-Reply-To: <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48859>

On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Thu, May 31, 2007 at 02:17:30AM +0200, Lars Hjemli wrote:
> > 1. 'git-submodule init' saves submodule name and suggested url from
> > .gitmodules into .git/config (submodule.$name.url)
>
> Could you please document the proposed .gitmodules first?

The man-page for git-submodule found in 'next' mentions how it uses
.gitmodules, but there isn't (yet) a separate man-page for
.gitmodules(5).

But: when I implement the proposed plan, it will change the current
layout of .gitmodules from

[module '$path']
  url=/some/url

to

[path '$path']
  submodule=modulename
  url=/some/url

Is it ok if gitmodules(5) appears as part of the planned patch-series?

--
larsh
