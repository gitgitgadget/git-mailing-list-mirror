From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 10:21:47 +0100
Message-ID: <81b0412b0703010121s59884556ha36e5ff72010f96c@mail.gmail.com>
References: <20070228151516.GC57456@codelabs.ru>
	 <200702281541.41164.andyparkins@gmail.com>
	 <20070301051323.GG57456@codelabs.ru>
	 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
	 <20070301091058.GA63606@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Eygene Ryabinkin" <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhU0-0006nu-BV
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbXCAJVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933198AbXCAJVu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:21:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:63764 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933192AbXCAJVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:21:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so322436uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:21:48 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ropTrNxq5Z/SM8P2yr6tqNuPExu7Lsi3PRShDb2Mo6m9FIXeGdAjsQRJmHx21l0uMAQyuNmXatfEHv3y/zCzsD5GPdeltrRZN2w+IychIWt7vp1274n1cTTpmmMg7vpAut6zpIrlql2nTLHLLyHWuYODzOBL18xAPaVeCko9CEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M5LM7RwgQdm9BILeXIv903UeX2rTdwBsE7Ht8gNT0YFBxFenkg0pExYjxF7uDwLiVrgDV3e8Wx+jaWN0JqYE5Ip6v6tSu1A5qg8aVhHRSUtNocJKT7cbdxyhdAXJmIk+bXnmNp+mxvMNw77wmostANXeNuEssYf17CwoJ8QgB98=
Received: by 10.78.83.15 with SMTP id g15mr137780hub.1172740907934;
        Thu, 01 Mar 2007 01:21:47 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 01:21:47 -0800 (PST)
In-Reply-To: <20070301091058.GA63606@codelabs.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41061>

On 3/1/07, Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> OK, I've forgot to ask in my previous letter: will the issue with
> '+11' instead of '+1' be fixed (or its already fixed)? Or 11 is 10 + 1,
> where 10 it strlen("git") trice plus one just to be sure? ;)))

Your patch is already commited.

http://www.kernel.org/git/?p=git/git.git;a=commit;h=2c46759db757eb742590e8547cb0c63e8bdb1da1
