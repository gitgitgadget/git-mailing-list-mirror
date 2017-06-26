Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F88620401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdFZJou (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:44:50 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35291 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdFZJos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:44:48 -0400
Received: by mail-wm0-f53.google.com with SMTP id w126so2571894wme.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Lx3w5vaDLYVrQr2rjqNm/UiNMkVbaK+DyZckge9WFVU=;
        b=HyUmbSPmi3AscUW6j55RYHN36vPc/Y0gVA7lg5PsY+syV99I6/FiN5tLdhd84Qfl++
         jS3ITH05IiY7OyRpEbVMT9vXC3H14IhmIwr6h7noUIzDdQc2nYDNudNbng4QsUYekF/I
         zzvaYd7AykQP5TSMKO02vCEzRfabcDK6rL7f6TYAqx+vLLPSHCME8CU+D9NmrbjtzDcP
         2WCwn2iZsVDPWz82lxtIWaAFLA7JZj9LGYWAGXYk2PjEZHY3GZ+lGlJtAwr7qwvi4jsM
         nw4TmhWh78/s5NRe0zn+UIhkQqOuqYEIDkRokwsm+LyIBnzmsAgjeyzNxZRT5FD/rYCY
         NCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Lx3w5vaDLYVrQr2rjqNm/UiNMkVbaK+DyZckge9WFVU=;
        b=J+FIuFxg4g+AS9xJOqIjEdsS7U892k8S/C932m5z30TzujaXHLW/IPJZjBmzUFHxxU
         KPS7lvQ+86eDuhjJKuHOcPPc/n0Ud3xYunGCPfPpzLTfUbjdAKS0bY5o1fAjcqfzfiAO
         a3MqsP3ij1Z+prr9WmeIs9D7vrp7Vd43LpCWLzf3e9BdVgLSkqF/dWEFsH/hlJxQbSaB
         Gbmupvy/34inr3PfkmjYlQ4pA3FFFrzdJFpAcbeSbSQX8Lw8jlX0CPfFVH40QrjQ9UZT
         ZIIXbke5kshd/qKY2CJK91401IKcU6PIhdXTQFCILBkccl7GPuLxF8MwGv9LQP8SURdQ
         EdYQ==
X-Gm-Message-State: AKS2vOw39LIZToeFyVhGalN78HwGa4qEuuy9p/EFZVE5UCAUucf+1WOF
        s/JT5odsK8adRw==
X-Received: by 10.28.93.197 with SMTP id r188mr2610597wmb.44.1498470286966;
        Mon, 26 Jun 2017 02:44:46 -0700 (PDT)
Received: from snth (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id 143sm1878086wmo.11.2017.06.26.02.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 02:44:45 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPQZZ-000568-Bs; Mon, 26 Jun 2017 11:44:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Users <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #07; Sat, 24)
References: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com> <BDD05B04-C845-43B5-8E22-D215403D2A6E@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <BDD05B04-C845-43B5-8E22-D215403D2A6E@gmail.com>
Date:   Mon, 26 Jun 2017 11:44:45 +0200
Message-ID: <87k23zccc2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 26 2017, Lars Schneider jotted:

>> On 25 Jun 2017, at 01:25, Junio C Hamano <gitster@pobox.com> wrote:
>
>> ...
>
>> * ab/sha1dc (2017-06-07) 2 commits
>> - sha1collisiondetection: automatically enable when submodule is populated
>> - sha1dc: optionally use sha1collisiondetection as a submodule
>>
>> The "collission-detecting" implementation of SHA-1 hash we borrowed
>> from is replaced by directly binding the upstream project as our
>> submodule.
>>
>> Will keep in 'pu'.
>> cf. <xmqqefuab571.fsf@gitster.mtv.corp.google.com>
>>
>> The only nit I may have is that we may possibly want to turn this
>> on in .travis.yml on MacOS before we move it forward (otherwise
>> we'd be shipping bundled one and submodule one without doing any
>> build on that platform)?  Other than that, the topic seems ready to
>> be merged down.
>
> What do you mean by "turn this on in .travis.qml on MacOS"?
> The submodule is already cloned on all platforms on Travis:
> https://travis-ci.org/git/git/jobs/246965294#L25-L27
>
> However, I think DC_SHA1_SUBMODULE (or even DC_SHA1) is not enabled
> on any platform right now. Should we enable it on all platforms or
> add a new build job that enables/tests these flags?

If we're cloning the submodule, which from this output, and AFAIK in
general happens with all Travis builds, but correct me if I'm wrong
we'll set DC_SHA1_SUBMODULE=auto due to this bit in the Makefile:

    ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
    DC_SHA1_SUBMODULE = auto
    endif

So if (and I think this is the case) Travis just does a clone with
--recurse-submodules then this is already being CI'd.
