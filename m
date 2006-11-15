X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Troy Telford" <ttelford.groups@gmail.com>
Subject: Re: git-svn bug?
Date: Wed, 15 Nov 2006 16:09:31 -0700
Message-ID: <op.ti2yl5i8zidtg1@rygel.lnxi.com>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <m2psbocpbo.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 23:13:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=PhyT+1mOJzsfS19sSzV1TBbUtdyqf1hjsLvDzpHLlf3i9eulbjh/u2YfnamfnjA4Qbe9Fk/+pGKJe1Ju4sUhrYqTnpYl3Nf0rAhpN/DXowbMGvS6RMJGp9bj7li4ZN1dARlko10ck9hiPYlBINhbEQ0Bj8dmWUaW2yBjcB4SW3s=
In-Reply-To: <m2psbocpbo.fsf@ziti.local>
User-Agent: Opera Mail/9.10 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31526>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTwf-0005tZ-Q1 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162051AbWKOXN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 18:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162052AbWKOXN1
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:13:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:49325 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1162051AbWKOXN0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 18:13:26 -0500
Received: by ug-out-1314.google.com with SMTP id m3so294520ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 15:13:24 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr50686huf.1163632189547; Wed, 15
 Nov 2006 15:09:49 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2]) by mx.google.com with ESMTP
 id 37sm1407747hua.2006.11.15.15.09.45; Wed, 15 Nov 2006 15:09:46 -0800 (PST)
To: "git@vger.kernel.org" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

> I always send commits as:
>
> git-svn dcommit remotes/git-svn..master
>
> Possibly replacing master with whatever git branch I'm working on.

I get essentially the same error:
fatal: Not a valid object name 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1

> One nice thing about this approach is that you can sort of preview the
> commit as:
>
>   git diff remotes/git-svn..master
>
> [but that just shows overall diffs and git-svn dcommit will apply each
> commit in master separately to svn]

Since I actually checked out a branch, I assume that

     git diff remotes/git-svn..svn

should be empty, right?

And if that's the case `git diff svn..master` should be identical to `git  
diff remotes/git-svn..svn`?

If I write the diff to a file, it is about 294k in size.  Also worth  
mentioning is that I'm also tracking binary files in the git repository as  
well.  It's for an RPM tree, so I have the (binary) package source  
tarballs (in a few cases >100 MB tarball) and their corresponding (text)  
patches and .spec files.
-- 
