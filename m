Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B01F1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbcKVRSQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:18:16 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33616 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755617AbcKVRSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:18:15 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so9547711pgd.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:message-id;
        bh=7pUP42O8OZ/1ly36WN7YKSnvb3FGDnEIyFnod0ADp9Y=;
        b=yqcOyZ2jg3Fv6gjY+JUrxWCMZvQQlQGGgTR+KIUQ8+aVznD25f9aU5rxyLiqELL59/
         gQ4aQ4VGJeZHVQ4dxnWNU4fF6kTjIOqaNGfxieazJRaApATTA394pQelyMR+tpjF3y1s
         0YnKZlbx9f+EQpJ69Gn7xBaxQvRBxrBOVtk9MDuPMQwqo/YMxHzUzdnwbQjAn0CRaGGl
         PZPw7/YiijYdMeKc9iWHIdbrsGLd8/p5yGdOTRAgsTv2XFq6BqgF46zEZkfeS5BSepKa
         nLaTRPPb7U1RE7BvOJoLK8/kfh6PcSGge/YJtMeHNxWataXAo2fDWp+A7DG1m2JsnSry
         Dlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:message-id;
        bh=7pUP42O8OZ/1ly36WN7YKSnvb3FGDnEIyFnod0ADp9Y=;
        b=ARlCs6kHuaO8pjDe6xmBL/VE52+xXCa4P4EOqNyi//UtskgeivyxDP8Hx8+mC9MIXt
         tlHoG9y8H6y3gbXnyXzvZwqeiGrsRiG88t2k4Ned3RuWljhKRtI9TTP6Gl/w/bCA9sqj
         ZmIJAIGs3CNwAIzF+3WVaAPCG1hA0JF6ESyAyBPdlXUC1Pm8BLtOBVmC8eLhb3HWeLz1
         PUmiOwGJmmmkpLem6xhvS432lwtPPNUbC6F/P/KmeTtTYsk4Wt6mJmmRdZLf6VKYdA2M
         6rkI9ZpZAzQGkh8WPV1IS/v0Or/W3FYFXFDKCMkuxJSpws88ChYuVLwl4CBZpmKxXy0e
         knzw==
X-Gm-Message-State: AKaTC01n4F5kr/TCN1/UHFYMFjupF+0Ioobt5BFItPOpvhKwtDLmXfGWVcW6X9Hccb+rtw==
X-Received: by 10.98.202.211 with SMTP id y80mr26758096pfk.154.1479835088786;
        Tue, 22 Nov 2016 09:18:08 -0800 (PST)
Received: from [192.168.42.82] (50-1-222-2.dsl.static.fusionbroadband.com. [50.1.222.2])
        by smtp.gmail.com with ESMTPSA id 65sm46593503pfn.12.2016.11.22.09.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 09:18:08 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
References: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: v2.11 new diff heuristic?
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 22 Nov 2016 09:18:05 -0800
To:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Message-ID: <502984B2-1ADF-4BEC-9C5D-057AADAA7C61@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 22, 2016 6:42:36 AM PST, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>The release notes mention a new heuristic for diff:
>
>* Output from "git diff" can be made easier to read by selecting
>which lines are common and which lines are added/deleted
>intelligently when the lines before and after the changed section
>are the same. A command line option is added to help with the
>experiment to find a good heuristics.
>
>However, it lacks information on exactly how to use this new feature.
>I dug into the git diff documentation here:
>
>https://git-scm.com/docs/git-diff
>
>It mentions a "--compaction-heuristic" option. Is this the new
>heuristic outlined by the release notes? If not, which is it? Is the
>compaction heuristic compatible with the histogram diff algorithm? Is
>there a config option to turn this on all the time? For that matter,
>is this something I can keep on all the time or is it only useful in
>certain situations?
>
>There's still so much more about this feature I would like to know.

Hi,

Yes for now the compaction heuristic option has an undocumented config. (I forget the exact name off the top of my head). Currently it is being evaluated and likely we want to make it default in the near future once we are certain that it helps and doesn't make any difference worse.

So long term you will not need any special knobs to benefit.

Thanks,
Jake

