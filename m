From: Petr Bena <benapetr@gmail.com>
Subject: Re: BUG I can't start git on Windows 7
Date: Mon, 8 Sep 2014 15:23:26 +0200
Message-ID: <CA+4EQ5e4==-eZDw7y4yj-vQS1dZsQig3xZc7eTkoCWF=SxU9cg@mail.gmail.com>
References: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
	<540DAD4B.9000208@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:23:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQyut-0004Ra-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 15:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbaIHNX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 09:23:28 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:52940 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbaIHNX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 09:23:27 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so15422293vcb.11
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5er+BysXKl8BCUBOvPWv+fn+OfU0LYYUp8E8kgs3RpM=;
        b=LOGDbioruge6r2yoSGFsz/ffKkf5k+nMpbO8ZkNFrIWOYfIR9asTh+Oevun3r+XcLD
         mtZv/IcOgRZ4nl5WutHZBmGyqC3ShBu23CQ/AvYF/5NVupxmvHEhvRPdWkgiBcEGKJqz
         RKgX6zaztPmoRunhZ4RLKPl49uyxKZ+6nlw/74IRkyK40iw8fPsywgnKV5B8V4E+PTDd
         Ywq2vYDfhppto3652yWOLJD6l05LwiAaMDqDg7AOGIV3+wZiK4nf3Q9Kzit4aUzMF533
         1QVbTqeobWpiaDvbFLL3hJJI8skr97Kemordc9zBZv7CT8aOx+zk8tbrtH2gtEf9pvNP
         3HCg==
X-Received: by 10.53.6.132 with SMTP id cu4mr205503vdd.62.1410182606261; Mon,
 08 Sep 2014 06:23:26 -0700 (PDT)
Received: by 10.221.10.69 with HTTP; Mon, 8 Sep 2014 06:23:26 -0700 (PDT)
In-Reply-To: <540DAD4B.9000208@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256645>

Hi,

Windows 7 enterprise (Windows [Version 6.1.7601])

I mention it because IMHO windows git is based on cygwin and because I
can see cygwin mentioned in error message. I didn't install it by
hand, I think it was part of git installation package.

On Mon, Sep 8, 2014 at 3:21 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Am 08.09.2014 um 11:15 schrieb Petr Bena:
>> I installed git on my system using official package from git-scm.com
>> but I can't launch it, I am always getting this error:
>>
>> C:\Users\petr.bena>"C:\Program Files (x86)\Git\bin\sh.exe" --login -i
>>       0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
>> AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x40000, State 0x10000
>> C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
>> cygwin's heap, Win32 error 0
>>
>>
>> At some point this could be an issue with cygwin, but I am not sure.
>> Did anyone had similar issue?
>
> [CC'ing msysgit]
>
> Do you have cygwin installed, or why do you mention cygwin?
> What windows are you running?
>
>
