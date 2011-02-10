From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Adding default remotes to a bare repository
Date: Thu, 10 Feb 2011 13:08:52 -0600
Message-ID: <4D5437C4.6000401@gmail.com>
References: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 20:11:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnbvG-0002Cj-2O
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 20:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab1BJTLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 14:11:17 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43662 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab1BJTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 14:11:17 -0500
Received: by yxt3 with SMTP id 3so742386yxt.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 11:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RZGX/2NPoG9VqdPtGdJFvhrLi+RtSLUvt8qfqxh6Udo=;
        b=s8NgN6YiFDZJbNBgT4+Bsvdhw2nqr1m0K78lsRM2UsOp11hlgYVWZgmqSdtvFb8y0g
         JZt0/ypuf+FnFsLPOjPaTxmZac7IF+yFeQ+cSDsS4jinVG9fa6Yj0mUh8LVtFiPQLPkG
         u7ihE6Y4emIjTduRnnF28FWvnbLLpC6iQLwAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=XfLqFDw4Cc5onrpl0mc6C3p64TQqQSNtB+vc0K/lIsbeSf6cOmlvHn8ld6rWMJtf84
         S2eWYSvgFAJXjN3SWEs8NpoHy5GhAuP99pGnIKaOmYU6C838iqXSJQOjbthUljyMSPbY
         DCRzC75mvZLSEL7u6HTNo/5YnLu5A6YqhrsO0=
Received: by 10.100.96.5 with SMTP id t5mr12444264anb.258.1297365076660;
        Thu, 10 Feb 2011 11:11:16 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b27sm332429ana.28.2011.02.10.11.11.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 11:11:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166494>

On 2/9/2011 10:53 AM, Francis Moreau wrote:
> Hi,
>
> Is it possible to add some default remotes for a given repository ?
>
> That is when cloning the repository, I can use the default remotes in
> the cloned repository.
>
> Thanks
You could write a script that does the clone and then adds the remotes. 
  We have a "menu" written in bash scripts and it does the clones and 
adds the default remotes automatically.  So instead of just doing "git 
clone", people would run that script to do the clone and add the remotes.

v/r,
Neal
