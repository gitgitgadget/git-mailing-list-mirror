From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: More information on git for Cygwin x86-64
Date: Fri, 2 Jun 2006 08:37:15 +0200
Message-ID: <81b0412b0606012337o3b005cd6wb88b0d1859d5369f@mail.gmail.com>
References: <20060601234410.GA3408@Zangband>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 02 08:37:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm3Hg-0003yU-Tt
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 08:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFBGhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGhR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 02:37:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:31782 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWFBGhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 02:37:16 -0400
Received: by wr-out-0506.google.com with SMTP id 36so523353wra
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 23:37:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfhHzUlXkna3yL+KKpt7RhJlA2HVNs7eDilUHcZsSWmHSMfCic2mF4BdZGYipAYr2xUxeurnn8y9kZw+IlkOrXakrguBKL63o/5HcgVMqdI1y2L4UUl65uL/QvuyIZIkK6plJeZ7eR+FUQPwouXJlo1TDcgQ2w6nDipGF+q2zPc=
Received: by 10.54.103.4 with SMTP id a4mr1621483wrc;
        Thu, 01 Jun 2006 23:37:15 -0700 (PDT)
Received: by 10.54.67.11 with HTTP; Thu, 1 Jun 2006 23:37:15 -0700 (PDT)
To: "Tim O'Callaghan" <timo@dspsrv.com>, git@vger.kernel.org
In-Reply-To: <20060601234410.GA3408@Zangband>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21148>

On 6/2/06, Tim O'Callaghan <timo@dspsrv.com> wrote:
> After some investigation, it looks like the problem is to do with the
> index.lock file. I think it may have something to do with with the
> rename function in index.c.

Does setting "NO_MMAP = YesPlease" in config.mak helps you?
The problem this option solves has to do with stupid open
file behaviour in windows.
