From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to use @{-1} with push?
Date: Fri, 25 Mar 2016 13:11:36 -0500
Message-ID: <CAHd499BCciG5Udd_sj550jPKg_ahZmWOi-zUOU-cr_wYmri=Rg@mail.gmail.com>
References: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
	<xmqq8u164fjv.fsf@gitster.mtv.corp.google.com>
	<CAHd499B3Z58hj--Pa0uM36A2H3Xpmayrb+RiLeOBkmnu70yW1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:11:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWCz-0007Eq-UI
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbcCYSLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:11:38 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36334 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcCYSLh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:11:37 -0400
Received: by mail-vk0-f46.google.com with SMTP id z68so98520624vkg.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=fJMkMBZOhEdPnzVhVQU24BVfMuKNi0ruXjmvbzeJo0Q=;
        b=BdlFJ7M1iPZEvN9/YjRsHekE9PEUwhS0rK6aJH5d1IARDI2TfgPdltuc8z5eVb/dJT
         Wqud8wd5BSf5PSOM/KroJ3i8Yds6knspAXQrYaW/prRAyUKb34UDmouhfCHdaGuC7r2M
         CA7pzAvOkP4MuqOSRpIz2eCQFWwuXczuPME69Traa7cBTkIeUPUWVk8wBLEkqdoE5DZi
         cCc/7xftyKXjMsKMJZHTWOnhj0rWskibLFYhG61JTZxWHLa/AJVLE6PA5NrqgU8Eh94R
         7v2y6aKRHXeiVMPOHWx7v7IANb2do5BIu90K85UPGwnUZ2evH4zaXg3+RKpuDXE0aGIa
         q8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fJMkMBZOhEdPnzVhVQU24BVfMuKNi0ruXjmvbzeJo0Q=;
        b=WuxtefO5v4MUudkgspRhy3tNH4YUaTWEhDw/6fg2qIyRHu3iib9YIqd1xpIqeVkTij
         bjLbjiKZcb72ueH5RRRNrr3kKU2RLM4/zHuaBrpfph+kraIdzA7TL8pY5dIOLwPJW54F
         zYdvS1r0Ma2+ikID1J/Lhf8eE61j9YzvaKsGfdL4JlONQWq/6g68NV+P7lNhdKMnxYS8
         RF+Aw9Ha1bcmbEe9ejC9hGJMnfvxk+tTW5K4f7wB3HXLe35LpLvjIRyMxheqXR1B2FlV
         Oba+aVEXjppXXpw1tp7n3vETMt5BpYinlHpL+UDvO8Zbz3dPthKnz2VPjKhMj3rTXOi4
         lMRA==
X-Gm-Message-State: AD7BkJJ+Aq6ICtsIUX/7sHDzlRX92ksfHX36WFn99YetlfPgdOVB054j+n+x1t8tY9AlY1i+0ojq8mpYSEvf0w==
X-Received: by 10.31.160.150 with SMTP id j144mr8258655vke.59.1458929496641;
 Fri, 25 Mar 2016 11:11:36 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.66.68 with HTTP; Fri, 25 Mar 2016 11:11:36 -0700 (PDT)
In-Reply-To: <CAHd499B3Z58hj--Pa0uM36A2H3Xpmayrb+RiLeOBkmnu70yW1A@mail.gmail.com>
X-Google-Sender-Auth: 8WLvSlmhMb85KYS2uKW-zTFSROM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289926>

On Fri, Mar 25, 2016 at 1:02 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> You can ask rev-parse to give you --symbolic-full-name, error out if
>> it is empty (i.e. detached HEAD), and otherwise use the result, no?
>>
>>     $ git checkout next
>>     $ git checkout master
>>     $ git rev-parse --symbolic-full-name @{-1}
>>     refs/heads/master
>>     $ git checkout HEAD^0
>>     $ git checkout master
>>     $ git rev-parse --symbolic-full-name @{-1}
>>     $ exit
>>
>> And
>>
>>     $ git push origin :refs/heads/master
>>
>> would be the fully-spelled out way to remove that branch.
>
> Thanks Junio, I figured there was a command to do that. I tried to do
> this using '-' shorthand, but that didn't work. I guess because that's
> not really a revision, but a special function of git checkout only.

So the push works with the fully-qualified ref, but not git branch:

$ git rev-parse --symbolic-full-name foo
refs/heads/foo

$ git branch -d refs/heads/foo
error: branch 'refs/heads/foo' not found.

Any reason for this? I'm using git 2.7.4 on windows
