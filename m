From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git fetch,git merge and git rebase
Date: Thu, 10 Feb 2011 16:21:27 -0600
Message-ID: <4D5464E7.2010407@gmail.com>
References: <1297315789338-6010561.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Akash <bcakashguru@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pneve-0005mu-CK
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab1BJWXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:23:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48669 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222Ab1BJWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:23:53 -0500
Received: by yxt3 with SMTP id 3so815131yxt.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 14:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZvJ6jkZr9AGY6F2RHxIJAorCGwaTGhnzEbN/hvhfM2k=;
        b=NL5EhHQRNHjiBxBAX2LKkH2fdIIBhVKNp7y863uaPXRm8uFd7NCcyd0pkO96CJ/IqA
         qX1JyI96NICGbqGORJ9Z63MUhDN50ipW5jqGy7HQwRvpKxStENUyXK7K46VFOL8H1/qd
         J8GHJn3h0YYkA8hNKI9d5C4bhtN0RAWFAhWow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=ntZY/yXh+oJngduYW6/LSyW02DAF9BbOwMLdjIvCzNPfQJ1ZLnO/jXowLA1S39JHG/
         z/KIDbRPoN9EeYKCiziRLNKVWRFJtm9quQXb7sSUJX+5x1xezxBqcstdve47bCoJRbEI
         OGlUaCBgNORl2KGouuTpK4pq0Tjdc3lLLnoyE=
Received: by 10.150.196.8 with SMTP id t8mr3983203ybf.175.1297376632551;
        Thu, 10 Feb 2011 14:23:52 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id k2sm108004ybj.22.2011.02.10.14.23.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 14:23:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1297315789338-6010561.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166506>

On 2/9/2011 11:29 PM, Akash wrote:
>
> Hi,
>
> I am new to git .Can someone explain in simple terms what git fetch,git
> merge and git rebase do?..I tried googling but was very confused after going
> thro it.
>
> Also, can someone prescribe a link which explains git in detail right from
> scratch.
>
>
another definition of git-rebase:

git-rebase:  the MOST DANGEROUS command in git.  you can easily DESTROY 
your repo if you don't know what you're doing!  Until you get the hang 
of it, always make a copy of the before-image of the branch your 
rebasing (mybranch) by doing a "git checkout mybranch" and then "git 
branch copy-of-mybranch".  Then if you destroy mybranch you can recover 
it from copy-of-mybranch.

v/r,
neal
