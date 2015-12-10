From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Thu, 10 Dec 2015 15:55:34 -0800
Message-ID: <CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	<xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7B3j-0001Ht-QT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbLJXzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:55:35 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33602 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbLJXzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:55:35 -0500
Received: by mail-ig0-f180.google.com with SMTP id mv3so29291963igc.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q7pyMVxXOkiyXJ85z99pExyoyhmjhX0QWon6kmIPiqw=;
        b=eODdT78LfEMFIvlqz58ykI4uTPUczKNWvA+7pURjHoSAaGo9Ysq51mJqCQPe6fb79u
         VYkNw6E79LsGgoLwRZzvVUJyd1ndPfDPhuNmhzpPNIug9KHqvR7KsXdk74xV51oui4Ai
         4eF3Q5jmZllE6JySj9KBA30szAzmrc9Vl8Nk96wTdlIjdAVW3x2tA9kWmmSmyWhaY7YB
         a/NkC8AETu2TsU29XEnEzQBh7Z0i498wsnv7jnepJfVfVr3pyHvsYt4nUBRlWUxxsg9g
         YxKv0qLRdJ0VKSHE2upCOJedDeCaXHMs0U4scpiD48U3zpV0g5aOX0xnjI2hEYfqY1/z
         LDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q7pyMVxXOkiyXJ85z99pExyoyhmjhX0QWon6kmIPiqw=;
        b=O4R51Sk4dlrHsXzz4Q3XO1i1X99YVm89Rh81tGtVzdx5Gw91KipJOUaCL5JDgWwMTy
         55QHMnZsoPuByyMpN/gQQW0SliRk/fKhtcA+l2CbRvkMLOFug5kzjzjxGw5xdYDAIhVa
         sPFgO+rYXPCBBCOXrWVT3W+NGkMkiRTHd94xSY8QsgK7p820gHeX1V6bvu6MNakRkqS6
         526+DgGcFwcvGueQFPI/vB4KxuA03rogvNQgAjiuy36HeqOe4KRxtM+BcEz66MvYGUkr
         HR11I0kqv5AgtZmXoi2erpvsZnAROuhkqJs33eHZj8jnNqltZyI5MUD13/kotk9CSdOR
         7PzA==
X-Gm-Message-State: ALoCoQngJ4LpPl5XNd/YJqVmHncOrixTq4BxYjxAoupwg6cVropAQZSpIgZ7ivbDAor/s0eB/Koo5xqdGu168ciJOqgB1cN6KMnpnuaGluSPiwpgKBriAFs=
X-Received: by 10.50.109.136 with SMTP id hs8mr1828215igb.93.1449791734537;
 Thu, 10 Dec 2015 15:55:34 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Thu, 10 Dec 2015 15:55:34 -0800 (PST)
In-Reply-To: <xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282247>

On Thu, Dec 10, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>>> ...
>>
>> I assume you plan on merging this after 2.7 settled and then we can
>> also get the above sb/submodule-parallel-update going again.
>
> Yeah, thanks for reminding me.  I think that would be a good plan
> that gives us an opportunity to clean up this topic, some parts of
> which are have "an early patch that was too hastily merged to 'next'
> had to be tweaked by an 'oops' follow-up patch in the topic"
> pattern, e.g. "make waitpid the secondary and closed pipe the
> primary way to monitor children".
>
> Thanks.

This makes it sound as if you would drop it from next once 2.7 is out,
expecting a complete reroll, which does the right thing from the beginning?
That was not was I was expecting, but thanks for clarifying.
