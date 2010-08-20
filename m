From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Tags, Grafts, and Clones, oh my!
Date: Fri, 20 Aug 2010 11:45:04 +0530
Message-ID: <20100820061459.GB12794@kytes>
References: <29380346.117285.1282264933599.JavaMail.root@mail.hq.genarts.com>
 <15347445.117294.1282265669453.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 08:17:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmKuS-000079-8L
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 08:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab0HTGQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 02:16:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50532 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0HTGQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 02:16:53 -0400
Received: by iwn5 with SMTP id 5so466113iwn.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FgSHujIKWi+56yzHwz0H7ncIlSY1YX2qL601JV75Gs8=;
        b=ZgDt1rpGEwm0Y9RqDa9UPQccp72DS/MkgJ7HiXSJkZKKHSP2RuJLa3QyU6qlmC3RxY
         9THBokgK6QInzye6ZbUb02PIdKkb7VAMnAvdZDdiDfJbFJiQPLtiWE367o66lgHv8JVU
         J+1qyn6sgQbR31W5PkAwMnyMFb/ErNKMkFy0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vtfDM57C2ShxUJNXfk6lEW3NlAPwarzelncPClA57v81rVO7sGrwxrKfIFR0DBwsOf
         ltpGR0RXW84033sWqF/xWGXcHFxIZlTozNM8bgqBc+dc89qDaIh3WFCW8xGU26N4khSk
         6NZhlTvBBi9ItVJbI1tKNMh0myJ8Nfgeto2vc=
Received: by 10.231.31.135 with SMTP id y7mr1045836ibc.139.1282285011355;
        Thu, 19 Aug 2010 23:16:51 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g31sm2256243ibh.16.2010.08.19.23.16.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 23:16:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <15347445.117294.1282265669453.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153975>

Hi Stephen,

Stephen Bash writes:
> Unfortunately I'm running into a problem with cloning the resulting repository.  Any git tags that are not associated with a live branch are declared invalid:
> 
>    error: refs/tags/tagFoo does not point to a valid object!
> 
> I've now reproduced this issue in micro (much easier to work with than the 20k commits in the real repo), and it does go away if I git checkout -b branchFoo tagFoo before cloning the repository.  I've examined the source repository, and the tag appears valid to me, as does the commit it points to.  The first error I see is during the clone.
> 
> Does this situation make sense to anyone?  If it's a potential bug (rather than user error), I can submit my testcase.  I'm currently working with git 1.7.2.1 on MacOS 10.6.4.

It seems too vague to me. Can you submit your testcase? Perhaps we can
work from there?

-- Ram
