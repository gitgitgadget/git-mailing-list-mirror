From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: Re: How to always use --merge option in git rebase?
Date: Fri, 13 Apr 2012 18:05:17 -0700
Message-ID: <CAGAhT3nL0d_niOuu-jGziJadF1JH7Ujvq_FKKBo4W=FfueUpsA@mail.gmail.com>
References: <CAGAhT3k4Hztbn8139LBuRFxTJgKxDzZcJR=L2A5o9rQBVuVMEw@mail.gmail.com>
	<4F876666.7080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 03:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIrQb-0001ul-7C
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab2DNBFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 21:05:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41764 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2DNBFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 21:05:18 -0400
Received: by yhmm54 with SMTP id m54so1927254yhm.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UG4Bvq/S6xI4JmYH2PL8GeMBc0O7YhG+6messBkosHs=;
        b=ZEjWj5NQwrqAqvAVnxCJslQX4cTv4+oSJDwKnQG0P+JTWAvBYKCEMHNOxCuZ8dMGjN
         A1V7NX5SUT6FZIgtgVyqpQ5o2WKZsvR1YATEMPZHbS6WBEK5laTF/DItB21KylMWeaVQ
         es8cp8GTngDio2ax2rQyuyPr2Fz+Ng6aB+m4U/Ep3Zfn+ZYM/9a0V8Qn8SMyTb7XWBPW
         ZIbP207lSBYyX89ZykzmYPOsDc7huiXeKji5d2ckwCskPlxMxb/Tnt7XlxzAzjAabo3Q
         pfrjxTbtSpq66SfaFBOOVA5Zu5nyf08uKoPdElg7q7HmBTV03naemoJyU6ByDjgoCH/E
         w1eA==
Received: by 10.101.128.2 with SMTP id f2mr869252ann.20.1334365517901; Fri, 13
 Apr 2012 18:05:17 -0700 (PDT)
Received: by 10.146.84.15 with HTTP; Fri, 13 Apr 2012 18:05:17 -0700 (PDT)
In-Reply-To: <4F876666.7080501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195461>

Thanks.
I was hoping there is some config setting for that though.


On Thu, Apr 12, 2012 at 4:33 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 4/12/2012 3:31 PM, Alexander Kostikov wrote:
>>
>> Hi,
>>
>> We have a huge repository ~10 GB. After some integrations the following
>> happens:
>>
>>> git rebase master
>>
>> First, rewinding head to replay your work on top of it...
>> fatal: Out of memory, malloc failed (tried to allocate 55012353 bytes)
>>
>> There is a workaround to use 'git rebase --merge' instead. But I
>> couldn't find a way to make the merge-based rebase the default one. Is
>> it possible?
>> git version 1.7.10.msysgit.1
>>
> You could make a git alias like "git rebaser" that does 'git rebase
> --merge'.
>
> v/r,
> neal



-- 
Alexander Kostikov
