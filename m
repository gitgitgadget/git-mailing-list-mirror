From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 09:15:32 +0100
Message-ID: <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
References: <20070228151516.GC57456@codelabs.ru>
	 <200702281541.41164.andyparkins@gmail.com>
	 <20070301051323.GG57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Eygene Ryabinkin" <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:16:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgRr-0004Jc-CR
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbXCAIPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbXCAIPe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:15:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:16619 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbXCAIPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:15:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so314523uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:15:32 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sUvlzWkHRD3S/DPeXoGF9qm2eyFJyj+xHtqw2Bajyk/jDagNX6TF9C3oBNvQBTRtq/EughE2UcFjK46XVA6lut17WxTC0c6SLOxQlnZtHOQ+jyxLC6+N9jzse/t5XQxSO0r3XIv6NPLaUzlQMaTg+oQA03VrKhseeBjWDvcUVxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TJ40gBVuHWP8RLXlONf+oYEJyLg99oGMv5Px7Gov/Rjs2EDUEPVg4pB0BBGF77cw4HMoBt6BLaD+4N+uCaDMmC1KtGNbu4H3Uwg9OL1scskTKuwuZOTjPZfQozUAq949fw7+CpTf4zmTlVXW2G3CR2vYdBTychQpDMycSQyAk/Q=
Received: by 10.78.185.7 with SMTP id i7mr130376huf.1172736932052;
        Thu, 01 Mar 2007 00:15:32 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 00:15:32 -0800 (PST)
In-Reply-To: <20070301051323.GG57456@codelabs.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41048>

On 3/1/07, Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> As Johannes pointed out, old habits are still alive. And when some
> tool serves me the right way, I am happy with it. To make the patch
> with Git I should create repository, hack there, merge it to the

hacking on Git you already have a git repo, don't you?
It should have been as simple as:

$ vi http-push.c
...
$ git diff

:)

BTW, git diff works outside of a git repositories (well, very recent
git should).
