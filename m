From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Tue, 10 Sep 2013 04:53:45 -0500
Message-ID: <CAMP44s09-WavPg=X8xOaOWzWZvoW=D=wBr6L2FUfY7qNaS8j2Q@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
	<xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
	<CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 11:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJKdr-0007LU-L2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab3IJJxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 05:53:48 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:43826 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab3IJJxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 05:53:47 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so5751717lab.8
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3zWPH09+CBgRKGWdtFCO8YX4BrHmxZ5YoRAYyKV1GUw=;
        b=PYvP+uYI4fc+BaX3Qv6B/xvH17xijK0PkFVYe8ylDWlgvxfAh2OmBtssnvGWWxEmVA
         gE1CSJd+9DhdRim5H8YEFSivY+YfGatS8XYk25334uT2fRMX8ENuTUy0vB4HoLmn9gie
         A26r8kkr8kMr3uP403u9geX1tZQHB0rufOn8qjUD1+VtYOvntd/ZWomYB+/tvu1oLwDo
         tcLbEQUoPRsDgrNFEqGEK7YEdv4upSW5deIcHL3DxS70+kKhKTFi518gkEGHTOS5OigG
         fHzZImeN8Ljjk4W8s8m11s2BSlzHi3knHVivHto3msoNO+EgrL2YYQSO8rY7OvTgmSBm
         rs1A==
X-Received: by 10.152.115.176 with SMTP id jp16mr20567943lab.17.1378806825685;
 Tue, 10 Sep 2013 02:53:45 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 10 Sep 2013 02:53:45 -0700 (PDT)
In-Reply-To: <CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234430>

On Tue, Sep 10, 2013 at 3:06 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Sun, Sep 8, 2013 at 7:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>>> a case where you have your own tag that points at the exact version
>>>> as I tagged?  In such a case, do you have a preference on which tag
>>>
>>> No. I always carry patches on top.
>>
>> That answer sidesteps the real issue; which one would you prefer if
>> there are two or more tags?  "describe" updated with your patch
>> would consider both and I think it favours the annotated one over
>> lightweight.  If it matches the preferred order then G-V-N with you
>> patch would help your workflow; otherwise you would still need a
>> different way, e.g. making sure what you want it to use is always
>> used by doing the ">version" thing.
>
> My answer sidesteps the issue because you were explicitly offering the
> sidestep in you original question ;-) Anyway, in such a scenario I
> would probably prefer my own tag instead of upstream's tag, to be
> honest. So you're right that in this case my patch won't help. But
> like I said, the case is not valid for me as I will always carry
> patches on top, and other people might feel differently about which
> tag (annotated vs. lightweight) they prefer if both point to the same
> commit.

Indeed. I prefer it the other way; annotated takes precedence.

-- 
Felipe Contreras
