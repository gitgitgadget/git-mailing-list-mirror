From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Wed, 27 Jan 2016 10:03:00 -0800
Message-ID: <CAGZ79kZQ725ErqLseb_3Mp-Yyc=X6dhRfHwARynXUzQigw5dvg@mail.gmail.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
	<C1F7518D-3898-4F53-8BAD-60B5648D4B5B@gmail.com>
	<xmqqwpqw9cdk.fsf@gitster.mtv.corp.google.com>
	<53B46FC1-7E34-49F1-9955-AE87E27519F5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:03:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOURS-0005Gn-PC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 19:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934266AbcA0SDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 13:03:39 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36469 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934012AbcA0SDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 13:03:01 -0500
Received: by mail-ig0-f181.google.com with SMTP id z14so89480440igp.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3n04GKP8QjF007nPUWdN5e53tXekuzciVuT6d/v6VMI=;
        b=hqouAeuvuiZy1P1+CQPm11fp5pOSYBMdyoBO8bkI6KGeC1533LsrbP8RmnaFsOlyFs
         ARNoC2xsovJG/ASB+FRAuZuQlC9Hc1x2UitxJHcx2TVfG/YzsCljC+lA8aotlAsoJ6+T
         nPYCFt+Ae+WOILLF8jtKtw+qwg1UotmBwx9Cy2dTkpgx5mzb/W5CPSqWxq+7dAo91Tou
         f0fR4/w9/mBA4ohpfwzsyxZLsKdFq58gdhvKtZRak/chUaWPa/zcdLMyhnyqZWwIrXYE
         uMQWqVKi6zL+ck/z2S0i3JvBL2ZuAurLtOU6V3EIEM6HzDMCdRf9QmrHoO1KSA4Pga5l
         wkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3n04GKP8QjF007nPUWdN5e53tXekuzciVuT6d/v6VMI=;
        b=DAZjTBD7kXRpfnbC530XEQSN2qA4VifjfXBqgM1J7q4MFAXd8VW2sesLRlVBQOPK1M
         VjN8znUfe5ZIs0jODvlxK6lNZksZrXYELNlie9AmFt/wDasL7QSuTf8H0JI0xSmiCA05
         gIf3IW3Qx/S8nJ3Ge656HCJtmdeeqhPAw4AK8vS5ex74urFiZhdq6Bin3Ux7nQeiL+0i
         JNUXsjK75UySBl/ZDF6fL5n3es+eXq+ntd9ApObFCuxCQr7npUlB4WRW/Ep+MOY2E7re
         9SOzEc0BjHYLcmM23BjqEfAlVHh67HdTzlKHgvKhsAWclGJ1CsaTHVbNPMZdnovcsA4q
         NBJA==
X-Gm-Message-State: AG10YOTyV9l0eyFeqPZePe+VKnW2wGaa1Usjg2cBjHQFQI3RLauRnwkKkpFJzlaQOFQLQEZiiFBdT2TAcCgY0v8L
X-Received: by 10.50.138.76 with SMTP id qo12mr31023880igb.85.1453917780807;
 Wed, 27 Jan 2016 10:03:00 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 27 Jan 2016 10:03:00 -0800 (PST)
In-Reply-To: <53B46FC1-7E34-49F1-9955-AE87E27519F5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284944>

On Wed, Jan 27, 2016 at 12:46 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 26 Jan 2016, at 23:58, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> Hi Junio,
>>>
>>> Did you miss the topic "submodule: extend die message on failed
>>> checkout with depth argument" or do you not agree with it
>>> ($gmane/282779)? Stefan Beller reviewed the commits ($gmane/283666
>>> and $gmane/283851).
>>
>> No, these three are still in my inbox.
>>
>> Quite honestly, "test to demonstrate breakage" alone is not all that
>> interesting to me unless I get a firm impression that somebody is
>> (or will soon be) working on fixing the breakage--which would make
>> it worth keeping track of it in my tree, to allow the eventual fix
>> to be more easily verified and protected from getting broken again.
>> Also "these look good to me" without much explanation is not much of
>> a review, and such a comment on a "demonstrate breakage" did not add
>> to the sense of urgency to the issue, either.
>>
>> That was why it has been sitting near the bottom of the pile.
>
> OK, I get your point. I got the impression that Stefan is on to a fix ($gmane/281260). Looks like he is not and I need to learn more about Git to tackle fixes of this scope.

I was on it and I put it on hold as I wanted to prioritize
sb/submodule-parallel-update,
sb/submodule-init and the upcoming sb/submodule-groups (maybe that's called
sb/submodule-autoInit, its scope is still being bikehedded)

Coming back to $gmane/281260 with a fresh mind, I think
this is what we want on the client side:

 1) fetch as we always did. During this fetch we learn from the
    servers capabilities list, if it supports fetching direct sha1s.
 2) if the needed sha1 has been fetched in step 1, stop.
 3) fetch the needed sha1 directly if the server supports it.
 4) if the server doesn't support it, display a message like:
    "Please ask your Git server admin, to run at least Git 2.4.0
    and enable uploadpack.allowReachableSHA1InWant to have
    submodules working properly"

Currently we only perform step 1 and this yields the error when
fetching too shallow to have the needed sha1 included.

The server side should be ok as soon as uploadpack.allowReachableSHA1InWant
is enabled. I thought we would need to add another option, but it
looks like that
option is exactly what we need here.

If you want to give it a try, I'll be happy to review patches!
(with more than "these look good to me" ;)

Thanks,
Stefan

> Would it be an option for you to just drop patch 1/3 from this series and look at the remaining ones? 2/3 fixes an "&& chain issue" ($gmane/282776) and 3/3 prints a explanatory user warning instead of an incomprehensible error ($gmane/282777).
>
> Thanks,
> Lars
