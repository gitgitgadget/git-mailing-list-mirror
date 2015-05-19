From: Yuval Greenfield <ubershmekel@gmail.com>
Subject: Re: Hanging "git mv" on Windows bug report
Date: Tue, 19 May 2015 10:11:58 -0700
Message-ID: <CANSw7KxvG29k28jp8Aq2ZeeNr2i=mWuirC6Ypno=_JXs7+TPqg@mail.gmail.com>
References: <CANSw7Kw7A_kn6yue9TnvGSO9dFzvX8AUZkn0W98Euf384CbnFA@mail.gmail.com>
 <b4a67dd0e303e009a02055e2cb8785d5@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 19:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yul44-0000Vo-Qv
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbbESRMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:12:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34664 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbESRMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:12:19 -0400
Received: by ieczm2 with SMTP id zm2so19077528iec.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3sBPxNAJT7QJusZivuKE/NrpGzwWqReViW8E0BNr2VU=;
        b=Y7iCgNCRDcSbf8xMtGYyntpX6wLtkvX4YoCMeabrreqvNj1ayUCDkXADLGkzCUwqjK
         j+rLzwoEsFyns5Cp3cXCPlocKOxbdN8WZ3yqtOTAY/4URVkKnqa3tM/b3FxO2lU4l6dw
         +Pvd5WtALbzQgkmijapqewmkDA8i8pXNuXXV0bACKgS8wpdHSnbgKQkSXZa2LrSMuf+/
         eUaTr7uIyhKUGLGQmxxIqCN7B53l15D9HmJtSKOO/7jzzgq6nNo9lPSjnwLQEACyjsOU
         cG3CiLynfhYWS1cntZqvQ41jF7//al9aQZXI7uHG1OGPFDGpPIs9sXCnufV4y34aw9DG
         UKiA==
X-Received: by 10.42.100.15 with SMTP id y15mr41781547icn.16.1432055539117;
 Tue, 19 May 2015 10:12:19 -0700 (PDT)
Received: by 10.36.110.11 with HTTP; Tue, 19 May 2015 10:11:58 -0700 (PDT)
In-Reply-To: <b4a67dd0e303e009a02055e2cb8785d5@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269373>

> $ git mv tmp Abc
> fatal: bad source, source=tmp/myfile, destination=Abc/myfile

It works. Thanks.

I'd say this page at https://git-scm.com/download/win should point to
https://github.com/git-for-windows/git/releases but sadly I don't have
time to give you guys a pull request.

https://github.com/git/git-scm.com/issues/537

Cheers and thanks,

Yuval





On Tue, May 19, 2015 at 6:41 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Yuval,
>
> On 2015-05-18 08:50, Yuval Greenfield wrote:
>
>> Here is the command sequence that causes git to stop responding:
>>
>> mkdir mynewthing
>> cd mynewthing
>> git init
>> mkdir abc
>> touch abc/myfile
>> git add abc/myfile
>> git commit -a -m "whatever"
>> git mv abc tmp
>> git mv tmp Abc
>>
>> I wanted to change the case of a committed folder. Since windows is
>> case insensitive that's a bit harder. Perhaps with this version it's
>> impossible?
>>
>> Here's my git bash banner - "Welcome to Git (version
>> 1.9.5-preview20141217)". I'm on Windows 8.1 Pro.
>
> I just tried this with Git for Windows 2.4.1.1 (developers' preview) from https://git-for-windows.github.io/ and it did not hang here (currently on a Windows 7 box). Could you try that and see whether it works for you?
>
> Ciao,
> Johannes
