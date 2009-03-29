From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn init --username ignored
Date: Mon, 30 Mar 2009 10:50:49 +1100
Message-ID: <FB93BF8D-836A-4A40-8B82-E32561007A52@gmail.com>
References: <9FB623A2-03A6-4B35-B631-DF4745971DB9@gmail.com> <20090329224137.GA20675@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 01:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo4nk-0006XH-Vk
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 01:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbZC2Xu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 19:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbZC2Xu5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 19:50:57 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:27875 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbZC2Xu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 19:50:57 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1444141tid.23
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=SHgIHi9x2FJTwOhJODrEgFbYfZlBqfbAQq/BVQd4iGw=;
        b=R/petWztUPyk0ksOdlJ1qD1jYXyxIFuVXcJPrwMQj6sVyJErZlvrFRLqIV6I/2iRdi
         s+GNR4PnebK8Vyin/0zrGGV3mZHAvz4gOy8adl6HUrchFia2qiDV7H2xHMiG/iDX6vZf
         AgAcA+b5bKexHvgCERRCT6Yrjs+unfSLBW4rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=lsoSdVRXtFrgybMDDW120QQSEXHCFprXABFMRHP5uEKkwxIhuUKgzHaNHAxC1XTdSm
         7+jF4WYP0vDEGRO3U77VfJ6JU6LG1q4xdPfmiXvr5aaYnaKoPqRREJHRGYoMPENmevcS
         ZSUz1FfUjeZJ+07FcbeIMt9HU8+Qn80xt/ltQ=
Received: by 10.110.62.4 with SMTP id k4mr6166812tia.54.1238370653798;
        Sun, 29 Mar 2009 16:50:53 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id i6sm7080170tid.19.2009.03.29.16.50.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 16:50:53 -0700 (PDT)
In-Reply-To: <20090329224137.GA20675@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115048>

On 30/03/2009, at 9:41 AM, Eric Wong wrote:

> Lachlan Deck <lachlan.deck@gmail.com> wrote:
>> Hi there,
>>
>> Is it a bug that the when specifying --username=foo for either git- 
>> svn
>> init or git-svn clone  that this isn't stored in .git/config?
>>
>> It means that for http[s] urls you need to specify it each time for
>> git-svn fetch, for example.
>>
>> Is there any way to specify it manually in the config file - or would
>> that have some bad consequences?
>
> Subversion already stores credential information in ~/.subversion/  
> which
> git svn should respect and use if available and allowed to.  Did you
> disable set "store-auth-creds = no" in your ~/.subversion/config ?

No, it's still commented out.

I simply started by doing:
git svn clone https://somedomain/repo repo --username=lachlan -s
cd repo
git svn fetch // failed without --username

In case the initial passing of --username is tripping it up, I'm  
trying again without specifying it.

with regards,
--

Lachlan Deck
