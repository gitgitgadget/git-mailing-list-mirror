From: =?UTF-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>
Subject: Re: [issue?]'git branch -D' case sensitive issue
Date: Thu, 14 Jan 2016 21:28:30 +0800
Message-ID: <CAB4fgE-UbTD6AkTaxyknJ+3ggtzRdYN43wgsamTXOYmGqDQ3_A@mail.gmail.com>
References: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
	<56978BA9.2010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 14:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJhx5-0007aZ-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 14:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbcANN2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 08:28:32 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34772 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbcANN2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2016 08:28:31 -0500
Received: by mail-qg0-f42.google.com with SMTP id 6so401188318qgy.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Sqp1J+zPM8bZgmfCuxo04tRwcQctkadct3lhoqDxpYE=;
        b=wNZFLaD7Wp8pDue2ejz0m3rFL0w6Xo4j7yRZC81pqjthB0ZYnHbMtCxxOMy4uKSIkT
         gQwhDmb6jPnd02Nv1Ek0eTqTLg3uiWAyqgaRi9IhwMeONDRvQBm7TnQt18d++9JZJX0J
         aE3pC4dn9JktJM3WWhMevX60oIzFj34SemeJO5RQf4qeRjNdg3kvnFZGTVKQEq6NW6Bm
         +dTz0IcNgyNSPxTTmQ56TNUFH6+XQqjGT9JWYs00XhmCgnLiqA3V/H4/DUV13gDMueFJ
         Etm3o2baZf9ES9HcrBc+NrH7Bbr1n+BUuHLqqTXwTUXIsp/IH4+MS7+I5EM6jnBqbOUv
         2FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sqp1J+zPM8bZgmfCuxo04tRwcQctkadct3lhoqDxpYE=;
        b=MtM68DpPGdxK2fs1NcmZS9sNJHZSdwi7IAeHENjbAM23916o4laDy+meVtLBdyYUqp
         QIIVZXbk4SUCri2aNujv/fLRx8/2FUt4IbLQi0b1WVlPR4FvztuYXGpyjGFPSouSA8vp
         wA7pTxEE/3Xd21oCJ1TBNe/pJZuQQn8NvgKSnHnpEWM7OUgIwemxm1q/WMIwQ375dLCA
         83n91tRrcm+YhMpV6KIdXZ91FauhAibqdx6B4pGaDUsidzXUbGqcKu/Dy97l6rCjpcBI
         ZLmi8gOVnMcHQUcgmwLAQCo78hvMq0xFcKsAPuavGqf0cp4WZqNj8u/lryVyv9KaTQlM
         9sLg==
X-Gm-Message-State: ALoCoQmD24Fqw0ebENM3aJURW9THIqoIInkFaNy1nmGqlvD8Xl/zrwqVFDQjIa7/P1jOYnE6bnEjyZ7nhpbNoumrjm4oMOXIKg==
X-Received: by 10.140.221.70 with SMTP id r67mr5840208qhb.84.1452778110519;
 Thu, 14 Jan 2016 05:28:30 -0800 (PST)
Received: by 10.55.181.70 with HTTP; Thu, 14 Jan 2016 05:28:30 -0800 (PST)
In-Reply-To: <56978BA9.2010005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284033>

Hi Torsten B=C3=B6gershausen, thank you for the quick reply.
I'm working on Mac OS as I have mentioned in the previous email.

=E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 sw_vers -productVersion
10.11 OSX

And besides, I use a case sensitive file system in OSX through the comm=
and
'hdiutil create -volname 'case_fs' -type SPARSE -fs 'Case-sensitive
Journaled HFS+' -size 100g ~/case_fs.sparseimage'
Is this a known issue?
Thank you!

BRs
terry3

2016-01-14 19:51 GMT+08:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
> On 01/14/2016 08:52 AM, =E9=83=AD=E8=85=BE=E9=A3=9E wrote:
>>
>> Hi All,
>> I encountered some issues when using 'git branch -D'.
>> It's strange, the command 'git branch -D' is case sensitive.
>> Here is the operated log.
>>
>> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -avv
>> * NIce                  fed5d9c Update js2-mode $ js-beautify.
>>    master                fed5d9c [origin/master] Update js2-mode $
>> js-beautify.
>>    remotes/origin/HEAD   -> origin/master
>>    remotes/origin/fake   8ec9cad fake.
>>    remotes/origin/mac13  13ae483 mac pro 13's config.
>>    remotes/origin/master fed5d9c Update js2-mode $ js-beautify.
>> =E2=9E=9C  my-emacs-conf git:(NIce)
>> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NIce
>> error: Cannot delete the branch 'NIce' which you are currently on.
>> =E2=9E=9C  my-emacs-conf git:(NIce)
>> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NICe
>> Deleted branch NICe (was fed5d9c).
>> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git branch -avv
>>    master                fed5d9c [origin/master] Update js2-mode $
>> js-beautify.
>>    remotes/origin/HEAD   -> origin/master
>>    remotes/origin/fake   8ec9cad fake.
>>    remotes/origin/mac13  13ae483 mac pro 13's config.
>>    remotes/origin/master fed5d9c Update js2-mode $ js-beautify.
>>
>> Hope someone can give me a hint.
>>
>> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git --version
>> git version 2.6.3
>> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 sw_vers -productVersio=
n
>> 10.11 OSX
>>
>> BRs,
>> terry3
>> --
>
> If you can give us a hint, under which OS you are working ?
>
> I assume that you are on Windows or Mac OS ?
> In this case the file system is part of the problem,
> which treats NIce and NICe the same.
>



--=20

________________________________
Guo Tengfei
