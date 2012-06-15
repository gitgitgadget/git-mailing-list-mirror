From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [git-users] Re: how to get the formated patches from the merge
 id
Date: Fri, 15 Jun 2012 15:11:59 +0200
Message-ID: <4FDB349F.3080507@lyx.org>
References: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com> <9579793f-d72f-424c-9546-f2caa1fbf847@googlegroups.com> <CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com> <4FDB239A.9070803@lyx.org> <CAHsH0E8MzMW8SEFGB_X80qH_5btnmvLWFxjQ-EBSaGbHSUz-Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lei yang <yanglei.fage@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 15:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfWKD-00011r-P9
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 15:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2FONMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 09:12:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60135 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab2FONMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 09:12:01 -0400
Received: by eaak11 with SMTP id k11so920105eaa.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=5szxo93/Lt+MabZHmDhQFy9ojdLPBzOa4HRNbXHYHm8=;
        b=Nnuq5zJd3MyUxzTGD+WtYplUSy2zMPz1M/koVqHITFOa5WfqfocWVsN4zsrm+whT/Z
         2PO3xF/h4ZrSr6Tza7GJm2vYqjCOUUxwlIqZlS8Kb7nKBk1Q89basD2TTnw/m6Gu1GFD
         LbmhhLHUgKi/Ek5Zfoazu+DoYkFuGTf8TjvcEguYPMVG9M5WTOPXPn13vAhQhtyC4xo3
         gcm+DNcKuoQIoeOT8tWtlFfWdhMCSIG7oylc7YKD25AEChezAxfNWgTqLjCmRet83V78
         s2kQCz72aG6Zx9RF31+6gGEO5sWveWfgdjMlne6DKsjQvZO+JBvUJErcIVJBxFHwrZI6
         9Kiw==
Received: by 10.14.28.77 with SMTP id f53mr1314483eea.98.1339765920393;
        Fri, 15 Jun 2012 06:12:00 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id v16sm29239727eem.17.2012.06.15.06.11.58
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 06:11:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAHsH0E8MzMW8SEFGB_X80qH_5btnmvLWFxjQ-EBSaGbHSUz-Sg@mail.gmail.com>
X-Gm-Message-State: ALoCoQlaFY06+6jWiZK/QQAlvGB3AUIDzh87kT7wazaD5WuRfp5o1S0JdejVr9teX6ruIFUzeFGn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200050>

Op 15-6-2012 14:56, lei yang schreef:
> On Fri, Jun 15, 2012 at 7:59 PM, Vincent van Ravesteijn<vfr@lyx.org>  wrote:
>> It is still not clear what you want to accomplish.
>>
>> Your proposal: "git format-patch b724cc1..51bfd29" only gives you the
>> commits that were in the branch 51bfd29 that weren't yet in the branch
>> b724cc1. This just reflect the commits of one of the branches, but not the
>> "work done by the merge commit".
>>
>
> but,git format-patch b724cc1..51bfd29 do the same work as what you
> said "git format-patch 0e93b4b3^1..0e93b4b3^2"

Yes, that's why I said "If this is _really_ what you want, you can do ...".


> and I don't understand what you
> said "branch 51bfd29",51bfd29 is not the branch

I assumed that the merge commit, merged two branches, but I have no clue 
how they were named. That's why I refer to the branch as the branch 
which had 51bfd29 as the last commit before the merge.

Vincent
