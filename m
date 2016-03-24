From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/GSoC 3/3] Nousage message in error
Date: Thu, 24 Mar 2016 21:58:09 +0530
Message-ID: <CAFZEwPOd2RyfF5eMqB5XZqNg5Oc_fbDmERcOAMpgR81pmPOPQg@mail.gmail.com>
References: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
	<CAFZEwPN2vp+zOMdGY51LwNpgNcYxsGD4GBXHNOA8_qJ8vtE5OQ@mail.gmail.com>
	<xmqqh9fvalpm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Diwas Joshi <dj.dij123@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:28:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj87N-0000TJ-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbcCXQ2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:28:13 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33956 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcCXQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:28:12 -0400
Received: by mail-yw0-f178.google.com with SMTP id h129so66275195ywb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Tfd5QjJHMHLCL+HtSjGBhEV1mtGQTsGDWgS9OH95JNw=;
        b=wKbnIX2EhiPUImAzn68DPm/mJg0Vwhlfv+oKPFlGunyU2w7kqp++PHrpgiro+mOKT0
         IPeug0jE+TeS9NG8GYwsQsDJlQLjyrJXfC+bteXSUMXCXIhl9wdTbhx5K8ZZptojaCKD
         is2YpD7GpEMY+ofiFcjE9ptDozkOlO6uoHvxeVjIvBa4V2y0rOVmPaf9uxE23uq5APX1
         g0lRouivlxiuULdZGuU4wEuVL/SJo+RXCPTuyilksvm3yYf3fdJnwi3xPBfLGwjzcPQp
         UlGyfUNM8Mu0ZOVGwD76KhuPC97Tb66UwgKFubnMvEYKuDEkeYe3+okwUqSRo9w65hzD
         rRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Tfd5QjJHMHLCL+HtSjGBhEV1mtGQTsGDWgS9OH95JNw=;
        b=FJ4G5tg1i75+6Jj2DBuwBUj0n3zhLXTYA3JymOQ1gzfOmNMkpR1yJYH4qQIbm8T0GZ
         zT+V9DDEWihXwX8ALLJOow0xI4rCl51CuIdzOr563H4Tw2ntd59HdypD0LSscAodVeoS
         jRN8wroRRk4v2XhqsLNS3hRh8N56piM09HC8bWWwCaStT84Fw5M+0eMqFWAWz5l3V6CH
         8cWZye6yzp0153aeQ4RXWUjEtTHmUznVtSUG2UJ9zi3Sdi2JmSjuyCWWOnQXR0dgmlgm
         zpsgWeTAyNXdD2WRN83lHev8ihxxf3N4JKFOgYVTwjBhtMFG6UhNgI94ZKdK6YTNWRUq
         zqVA==
X-Gm-Message-State: AD7BkJK0hDUoatCuaXXLdwlGmbiGvCnQbnuSFENkTt62SnGRWJf9zSaVp8eoTfFqNQCWlRABd/NHAMDQluqelA==
X-Received: by 10.13.252.67 with SMTP id m64mr5299114ywf.67.1458836889871;
 Thu, 24 Mar 2016 09:28:09 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 09:28:09 -0700 (PDT)
In-Reply-To: <xmqqh9fvalpm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289758>

On Thu, Mar 24, 2016 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> A general convention followed by git users it to write the commit
>> message as "What he did to the code?" rather than "What problem was
>> there in the code?"
>
> It is OK for other projects to adopt a different convention, but The
> project convention here is different.
>
> We tend to write our log message like this in this order:
>
>  - Explain relevant behaviour and code structure in the current code
>    to refresh memory of readers to help them understand the next two
>    items better.  This paragraph is optional and you see it only in
>    difficult patches.
>
>  - Desribe the problem.  What the end user would do and what she
>    sees in response to it, why that is not a good outcome, and what
>    would be a better outcome.  For a patch to only improve code,
>    replace "the end user" with "other codepaths that interact with
>    the code being changed".
>
>  - Explain the approach to implement a better outcome.  This
>    paragraph is optional and you see it only in patches that
>    implement tricky solutions.
>
>  - Describe the solution, as if you are giving orders to the
>    maintainers to change the code this way and that way.

Thanks for making it clearer to me! I tend to write bad commit
messages. Improving on it though.
