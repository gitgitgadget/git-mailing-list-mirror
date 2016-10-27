Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E54720193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbcJ0WYg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:24:36 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36823 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941570AbcJ0WYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:24:35 -0400
Received: by mail-ua0-f181.google.com with SMTP id 64so34780706uap.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFNMlmItTuMopDY1w7cAnfaGfjuK6HJNzrqEKmRzlOA=;
        b=qeuqPezUYR2TGZwsRy/KU6AThxGXLNn6rjcgH+J4AWYMVJQpnJ8pttq3mwNjYzhVGC
         tGqCD2wZk/jZmqOpX8UDhfwKkA08c5oIDhA2n0pfR1cTWrVVYxpBi6mXvsytuQc4DXKD
         LH6hEpZz8hrEBzay0wuAWEa4rVunJkOiPZwvA7DiGvyidl4jsQsJVA5vaQ+JQVLnv8E1
         JJlcAyCM4euKvbs+NM6xUCLTDF/zgwkP73YG04a0f6xiBGFudxhfj/ojCEfXt0lNMz4l
         p0XTRsjPTbQwP1DR7Edy+LJx9yDFo5j3qXzPMJWmoOGKgW/x5NM2i3Lf9j30kCtWz7UW
         3lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFNMlmItTuMopDY1w7cAnfaGfjuK6HJNzrqEKmRzlOA=;
        b=nKiH3TSetuRUVGdByOx63OkK5AAMmubZLcQAV88B9NqVZhKrNummNtZqO/RPddHFXA
         +8K0CNscxD+rlsudS/pi4IVwdNUzpnhk+T2rLLR8+oiOYFdbFDrIEE/cV2PMtIfFgISW
         5EHyk1U4kMUdMRoo/ZYAKf1HFMoCZR3gu1y699DDdAtf5J9OFLdU+5Y/l0gzRTbDsYsu
         ztvqD7BxBSrXhIAVmHrGy7sn6tkYUjrW/JVf9Eoj5wfpqpFjz9w6yWhNQWTyO2W7U9sc
         AgIwKJzOTLIBFNvR/CCKOgjkAejbsezVKcI8wte/cEF+YFfzCYKDv2kg8RyjCPjPR+zF
         Qhzw==
X-Gm-Message-State: ABUngvcsv2Ik0WcZX16TVxKdU0xXBVmrRE6kQDTZh3YHMoSifroj8zZxTtmIUseJZ9BB7osrB+gDaZY/uEnO9g==
X-Received: by 10.176.4.44 with SMTP id 41mr870495uav.96.1477607048826; Thu,
 27 Oct 2016 15:24:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 15:24:08 -0700 (PDT)
In-Reply-To: <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
 <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com> <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 17:24:08 -0500
Message-ID: <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com>
Subject: Re: feature request
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suppose I can do git config --global core.editor notepad
However, this really only addresses my second concern.

My first concern is that using a text editor at all seems like
overkill in many scenarios.
For that reason, I still think the other two options I mentioned would
be beneficial.

On Thu, Oct 27, 2016 at 5:05 PM, John Rood <mr.john.rood@gmail.com> wrote:
> Unfortunately, in my case I'm on windows (my company's choice, not mine).
>
> On Thu, Oct 27, 2016 at 5:01 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
>>> Users should be able to configure Git to not send them into a Vim editor.
>>
>> See https://git-scm.com/docs/git-var
>>
>> GIT_EDITOR
>>
>> Text editor for use by Git commands. The value is meant to be interpreted
>> by the shell when it is used. Examples: ~/bin/vi, $SOME_ENVIRONMENT_VARIABLE,
>> "C:\Program Files\Vim\gvim.exe" --nofork. The order of preference is the
>> $GIT_EDITOR environment variable, then core.editor configuration, then
>> $VISUAL, then $EDITOR, and then the default chosen at compile time,
>> which is usually vi.
>>
>>
>> So maybe
>>
>>     git config --global core.editor "nano"
>>
>> helps in your case?
