Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D44209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbdIKUJS (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 16:09:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:43370 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdIKUJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 16:09:18 -0400
Received: by mail-wm0-f42.google.com with SMTP id a137so11587987wma.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TT09guP6D7Efgr1YgyPBcMUarb1+h3yPwUxTM+RxGiw=;
        b=iVXvYMo+SXR7UWJc5uVVZZEqvz/6wdrvKzooZg49thuG0M2SGtO1naq2Hz6WWgw4tQ
         SIFdE5QgVLL69tEpi5Zv7GlZ23m/U6lMoHQj5L0/0vchOBLnfDldnJZSDoac5XRTrQqK
         eInkUHN/eFUAkmwmcILMIgWsgJbDa6rMYeR3p16XbRmR/UmFR2h0naBn820aIiMEIlhb
         b27hsk7Vg3bpOOfZM+M9H1gpdlXoBVXaIfMXhK0SYNmP6V/3oRFf6Q6VhvboIvk3EbEe
         D6crV0ExueZ5Pyr5M0TBJbUz5RK64EOUhCLH5m/5ffCyH1JVnHUHGvkDZAZhLJdLsfAf
         U4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TT09guP6D7Efgr1YgyPBcMUarb1+h3yPwUxTM+RxGiw=;
        b=tuuC3WwkkA0v2XEmCCsteMsX4cXFOR0Yy+bfDzkP+YuL04jI8Wv8xda4mzuiFvReOV
         vWDK0z6z5nHD9qmcVNZPJAq4ZNcBZb0w1CQ87QyqCkgHh+RhRRrooA9Rn1pyOzP/nRtf
         NtINmye1JRrsRsd58+TI0QcN9bq52PyvVnNU+3WqCJ8FSwlllCi9CaXGf0XqW9dV4SeE
         g67WCuaouyboVfzERpEmM8Sz74n8girv7I/lk60A9xJcyGRzB948VrTyXmxm7HMsD7MI
         8WNjSDPUt/ZvQqOaWDuD1eeHC4tNRv8KI8KkGiNnLdBLavo3zWBLUG3MJUrfqmaH8Qay
         e/OQ==
X-Gm-Message-State: AHPjjUixUhcR3/9OpT7nj4+QixVvDCwJ01OivR4V71NLzkteD1JhFOBU
        RfHKISc/Zz0OtzApg9Ej5Er9l4DN
X-Google-Smtp-Source: AOwi7QAoMIsoP820WSpgLF7CLpQEdqqqapEev1SrpwVHgfCJVkTvrqkcyig2hK7GdGwTLY4xxak/aQ==
X-Received: by 10.28.21.205 with SMTP id 196mr8647786wmv.77.1505160556627;
        Mon, 11 Sep 2017 13:09:16 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id h201sm1627696wmd.27.2017.09.11.13.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2017 13:09:15 -0700 (PDT)
Subject: Re: [idea] File history tracking hints
To:     Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <774426e0-24c9-320b-a593-b3d0865cfa68@gmail.com>
Date:   Mon, 11 Sep 2017 22:09:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pavel,

On 11/09/2017 09:11, Pavel Kretov wrote:
> Hi all,
> 
> Excuse me if the topic I'm going to raise here has been already discussed
> on the mailing list, forums, or IRC, but I couldn't find anything related.
> 
> 
> The problem:
> 
> Git, being "a stupid content tracker", doesn't try to keep an eye on
> operations which happens to individual files; things like file renames
> aren't recorded during commit, but heuristically detected later.
> 
> Unfortunately, the heuristic can only deal with simple file renames with
> no substantial content changes; it's helpless when you:
> 
>  - rename file and change it's content significantly;
>  - split single file into several files;
>  - merge several files into another;
>  - copy entire file from another commit, and do other things like these.
> 
> However, if we're able to preserve this information, it's possible
> not only to do more accurate 'git blame', but also merge revisions with
> fewer conflicts.
> 
> 
> The proposal:
> 
> The idea is to let user give hints about what was changed during
> the commit. For example, if user did a rename which wasn't automatically
> detected, he would append something like the following to his commit
> message:
> 
>     Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
> dev-vcs/git/git-2.0.ebuild
> 
> or (if full paths of affected files can be unambiguously omitted):
> 
>     Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
> 
> There may be other hint types:
> 
>     Tracking-hint: recreate LICENSE.txt
>     Tracking-hint: split main.c -> main.c cmdline.c
>     Tracking-hint: merge linalg.py <- vector.py matrix.py
> 
> or even something like this:
> 
>     Tracking-hint: copy json.py <-
> libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
> 
> If file transformation cannot be described by a single tracking hint, it shall
> be possible to specify a sequence of hints at once:
> 
>     Tracking-hint:
>         split Utils.java -> AppHelpers.java StringHelpers.java
>         recreate Utils.java
> 
> Note that in the above example the order of operations really matters, so
> both lines have to reside in one 'Tracking-hint' block.
> 
> * * *
> 
> How do you think, is this idea worth implementing?
> Any other thoughts on this? 

Here[1] you can find Linus` reply (from 2005-04-15) to "rename 
tracking" discussion, usually quoted to explain the Git philosophy on 
this point, even referred to as "one of the most important messages 
in the list archive"[2] by Junio himself.

[1] https://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
[2] https://public-inbox.org/git/xmqqr30qflk9.fsf@gitster.mtv.corp.google.com/

Regards,
Buga
