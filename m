From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 21:26:07 +0530
Message-ID: <56E6DF17.2040106@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
 <xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
 <FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUqv-0002y5-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbcCNP4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 11:56:13 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33074 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcCNP4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 11:56:12 -0400
Received: by mail-pa0-f45.google.com with SMTP id fl4so159197001pad.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Wso4dHcLS+FaFhEbc7vfPaoPBVgvNG50P6CMW+wZ47k=;
        b=aAzdyKyfIUenoX+zWK0ptPP6dv2PDcNWXr7B5uRO/tgA+dT3KNEnRYhhLIT+XEDs3/
         tGBaAGHCxAplaUUPyNCM+ILyf79BjpW4cdPGk/yzTRCSnKUsTlBnb3x0+Fl1Wwjh04PO
         24LSOLkkm5XPgP9PqwDaCeZMXLCJD+7DA933IiG6HgUocVemNJk5zavV649D/omU6Peg
         B2/fvyFedGGETgh3PFGXvDznlA6z+m/d7xb/XlISnAhN3Kh+YVO7dC/FuF0fT4x+yVOe
         U9tal46AYgLFP0vCqG8mqTy53GBAwMDFXlLB/bWAX/BGmKWNRDl28PTg9T3d5WSL/xCB
         mU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Wso4dHcLS+FaFhEbc7vfPaoPBVgvNG50P6CMW+wZ47k=;
        b=A9mfaqK6vbSzEUrpBqD3eCQiII9lJeSbbyhSAIiQeFwGaoaEJaCaNgAof1gZB84A01
         EhxEW5QmyBCVt+NVDN1zScYqy1FnqP6Hj336pbXAT/rFxaq2ZRnQooIEVtngkC8QVsaa
         DlB+dxFHkNaDQDUS0ZXIyTmc81JZG///FSXqqqrAiuZIqWg/wpv2xPKUd/y3vOAFauru
         lGgd/XK7M075kpP6MEgUMB9Km7TAn+DEnJvrfE9Mk2qP9PpJHEoL7TERrsHat2EMg8OU
         UBmURZS6ipdOhB5/F4WQuo7MDtp7w5Pvtqi9XAdQypBfezQlkdmKdQUO78Q6xnIS+zLu
         NEIA==
X-Gm-Message-State: AD7BkJJZCCG1r8R0a1rtjpGLNX65qAbxWBtRoWuIS4MvfKq3Os1EDc0AiTYiSLS4HipVJw==
X-Received: by 10.66.163.40 with SMTP id yf8mr38820397pab.148.1457970971592;
        Mon, 14 Mar 2016 08:56:11 -0700 (PDT)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id m89sm1005224pfi.12.2016.03.14.08.56.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2016 08:56:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288785>

On Monday 14 March 2016 01:46 PM, Lars Schneider wrote:
> On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>
>> If "ggit" is made too limited, there is an issue.  Beginners may at
>> some point need to transition to the real thing to fully exploit the
>> power of Git, and they may need to unlearn "ggit" and learn Git.
> I think a "ggit" wrapper should not introduce any new commands or new
> parameters. Everything should be passed unmodified to Git. The wrapper
> would only add additional warnings such as "You are about to do X which 
> will permanently destroy Y. Do you want to continue?". Therefore
> a transition from "ggit" to "git" would not require any learning effort.
>
> Maybe "ggit" could also be interpreted as "guided Git" (sounds more 
> friendly than "guarded Git"). I have the impression that many Git 
> beginners make mistakes because they don't have a mental model of Git,
> yet. A "guided" Git version could explain the commands a bit more 
> detailed as they use Git (e.g. with ASCII graph examples). I know
> that's what man pages are for but I've encountered many users 
> (especially on Windows) that are not aware of man pages.
I too think that the wrapper should only pass on commands to git if
they aren't potentially destructive, and not itself introduce
new commands, unless there is a need (I doubt if there will be).
>
>> This approach, if it wants to become successful in helping users,
>> would take quite a lot of thinking and work to avoid omitting too
>> much to necessitate users to migrate to Git.  But I can very well
>> imagine that a new "Cogito 2" project (I am not saying that the UI
>> Cogito tried to achieve were superiour or anything of that sort--I
>> just needed a name, and picked one name that came to my mind) may
>> get done by those who interact rarely with the core Git community
>> and may live as one of many independent and viable third-party
>> projects you find on GitHub.
>>
>> There however are two questions I do not offhand have good answers
>> to: (1) if that kind of effort is of suitable size for GSoC, and (2)
>> if it is suitable to be supported by the Git project proper.
> Good questions. I have no previous experience with GSoC Git projects
> and therefore I am not qualified for an answer. However, my gut feeling
> would be that a proof of concept implementation of a "ggit" wrapper
> that does not add any new commands and only adds warnings for destructive
> commands could be in the GSoC scope. However, Sidhant must be aware of
> the fact that this is a controversial topic and therefore any future work
> on this topic might be never merged into Git.
>
> I also thought about (2). The obvious advantage of having something like 
> "ggit" as part of Git core is that it would be shipped with the standard
> Git distribution. That would especially help beginners. However, 
> maintenance is a very strong counter argument. Maybe "ggit" could
> start as a separate project and if it picks up then Git core can still
> decide to merge it?
>
I understand that this endeavour may or may not be merged into
the official Git distribution (though I'd really like it to :)), but
I still wish to attempt this. I'm also eager to continue work on this
even after GSoC is over, so maintenance shouldn't be an issue ;)

Thanks and regards,
Sidhant Sharma
