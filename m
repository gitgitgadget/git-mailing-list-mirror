From: "Pavel Raiskup" <xraisk00@gmail.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Tue, 22 Mar 2011 13:32:48 +0100
Message-ID: <op.vsqvsyit2m56ex@localhost.localdomain>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=6z=4m8opfhy9pV1S6ySobSA+WEEESESOJ0MZ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 13:33:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q20mH-0007iF-H3
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab1CVMdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:33:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64813 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab1CVMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 08:33:19 -0400
Received: by fxm17 with SMTP id 17so6366940fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:in-reply-to:references:subject:to
         :date:mime-version:content-transfer-encoding:from:message-id
         :user-agent;
        bh=F+9OsFFT72nrqia52HzE2s98nk2qFiOIF1YbMi59rYI=;
        b=hCyGimZd3B+c9tdbs5ZP+zXNyArC5ZD0vPd6SdnXtc76/e3cW6BGMa5nF+OJ4JOpYv
         U/+dP854H9kCOiEY/QaHVEJisNOl4d+tr5JK51Ma1GMfCYX7GEaVt/4FdyC2sux/Nm2j
         e3bRY/Acwh28ouIVFsKwgBSCnN5TPaofYuY0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:in-reply-to:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:user-agent;
        b=SvDwdX3RapC6XZDOY95Ijau3O+xq9Eu+4DvVbi7hhP+xbrA4e1GS0keUlKayKm63tu
         F729cTAbw+DjghhzS1a8NzyHurzwrXg4Ubk1QHQosf/+evZ+lTApxy/w1DQ3CzJayp5b
         1SVahJqD2urd+21v8VZy2FdPe0wokB2gmHauA=
Received: by 10.223.101.72 with SMTP id b8mr2296056fao.15.1300797190516;
        Tue, 22 Mar 2011 05:33:10 -0700 (PDT)
Received: from localhost.localdomain (dhcps190.fit.vutbr.cz [147.229.179.190])
        by mx.google.com with ESMTPS id f15sm2517881fax.10.2011.03.22.05.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 05:33:07 -0700 (PDT)
In-Reply-To: <AANLkTi=6z=4m8opfhy9pV1S6ySobSA+WEEESESOJ0MZ4@mail.gmail.com>
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169726>

>> Histogram diff:
>> There is no mentor mentioned in [1]. Does it mean that there is no person
>> ..
>
> As the original author of HistogramDiff in JGit, and a contributor to
> C Git... I'm probably the best person to mentor this task. I'm really
> busy, so I didn't sign up to mentor anything else this year, but I
> think I would make time for this project.

Thanks for your answer and for your ability to be a mentor of this task.

>> There is a goal "Get this feature merged to the upstream git." -- but I have
>> one theoretical question -- what if the benchmarking/study of histogram diff
>> leads to conclusion that this algorithm will not be useful for upstream?
>
> Then the project doesn't merge. :-)
>
>> Does it mean "fail" in terms of GSOC? I have to think about it even if it
>> looks that there should be speedup quite obvious. I don't want to fail
>> a priory :).
>
> I don't think so
>
> I think the success of this project is if the code is of the quality
> that upstream would accept it, and if the final analysis data makes it
> clear whether or not its worth including. Its probably not worth
> including if its the same speed as the current Myers diff
> implementation from libxdiff or slower. But if its 2x faster, its
> probably worth merging. If the code quality is acceptable to the
> upstream maintainers.

I wanted to know exactly this kind of information. Of course
I don't want to make a code of unacceptable quality from any perspective.

And I think that you probably don't expect histogram diff to be significantly
faster in general :)

Thanks again - it is good to know that you as author of histogram diff are
here. And sorry for my latency ..
[ot] this is because of hectic school schedule now - which is actually not
good :( I need to study git source very deeply _NOW_ (I wanted to reply
earlier but..) [/ot]

Thanks to Junio C Hamano with almost the same answer here:
http://thread.gmane.org/gmane.comp.version-control.git/169498/focus=169516

Pavel

>> [1] https://git.wiki.kernel.org/index.php/SoC2011Ideas
