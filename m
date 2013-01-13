From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 13 Jan 2013 13:58:32 -0500
Message-ID: <50F303D8.20709@gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 19:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuSll-0001ZS-LC
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 19:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab3AMS6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 13:58:37 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41098 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3AMS6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 13:58:37 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so979270qad.19
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Kf/ehziVIecvO1Yf7CBOUPptgH8Doc1PZwRtpKQXp+s=;
        b=cKzRqGPLVKth/NDZmX75T0JTEHmW8KGFdQgVgIA04QjfOQuica6rNhSnDNTvWx5yfl
         /4KGOaxIZ4Or1Clh0wmgGgrcVUnMivQrwGAWqFf5afkIhQZlyK7jlmfl5IkpLWzJJMiE
         xB1N4Nl8yM0preOE0Lv/cLnFcZQqBhXW4CpgufudUHaDsPy3Ed7x7I6DHb5JgIL8t6tt
         SYHGDvWpSfLaICQBn5fzxAAFAVl8E7uzLK3HKOpI4XSJBR/TsG40aVORuC+jhbW3guZA
         MbDr/uafCtAAsOGIO7Pipn/zGwQA/1z4TEqFySi3/8/lQJ/X2JpHpsCBGaQ8Lq6RYe3U
         2Sbw==
X-Received: by 10.229.75.200 with SMTP id z8mr16686382qcj.85.1358103516185;
        Sun, 13 Jan 2013 10:58:36 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-109-151.washdc.fios.verizon.net. [173.79.109.151])
        by mx.google.com with ESMTPS id j20sm8261974qaj.16.2013.01.13.10.58.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 10:58:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213395>

On 01/11/2013 03:17 PM, Alex Riesen wrote:
> On Fri, Jan 11, 2013 at 9:08 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> This short discussion on GitHub (file git-compat-util.h) might be relevant:
>>
>> https://github.com/msysgit/git/commit/435bdf8c7ffa493f8f6f2e8f329f8cc22db16ce6#commitcomment-2407194
>>
>> The change suggested there (to remove an inclusion of windows.h in
>> git-compat-util.h) might simplify the solution a little. Might even
>> remove the need for auto-configuration in Makefile (worked for me).
> Just to be clear, the change is this:
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4a1979f..780a919 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -85,12 +85,6 @@
>   #define _NETBSD_SOURCE 1
>   #define _SGI_SOURCE 1
>
> -#ifdef WIN32 /* Both MinGW and MSVC */
> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> -#include <winsock2.h>
> -#include <windows.h>
> -#endif
> -
>   #include <unistd.h>
>   #include <stdio.h>
>   #include <sys/stat.h>
>
That change alone seems fine, no apparent change building on current 
cygwin. However, with that change the build still fails if 
CYGWIN_V15_WIN32API is defined, so unless someone can show the 
compilation works on cygwin1.5 WITHOUT defining CYGWIN_V15_WIN32API this 
change does not help. I do not have an older installation available, so 
cannot test. Frankly, assuming you can compile with that macro defined, 
I would suggest leaving well enough alone - an unsupported configuration 
is unsupported :^)

Mark
