Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DCA1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbcFUH5n (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:57:43 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33323 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbcFUH5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 03:57:40 -0400
Received: by mail-lb0-f182.google.com with SMTP id xp5so5027384lbb.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 00:57:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5KAy6rmhzFjaxiNMV2Il/dvpATPy+Gr+wAgOYaptcBk=;
        b=ZB+XPHIEwZdMBc5P9nIujssZXhFw0AS3VxVwRnE+Bn1maqw2LVmdl12EwP/4fuxCix
         wnHnPgDtPFg25o+3oqGWljmuu4IYAdFZtm7Bst/nAw999I+zzfbasZrVbh7a0173ixt2
         eFZqKfGRo6TTRwWmjTg8twKTXkNs3YEQ2MmicMoceF1nbEsuqgrtSUMaRjwu2DVeKe4V
         PKpzV36TnalqTrrfpShRk9SYj7XkdNunkhG7T5/oxKV9deZOStr0F9ov6U9c8+1i7SCv
         it+e7u0gWXhm0SwIQ5SJcPoTHvZbFk9Yt8TKX9v+8YnoGYwk2huyTBSp1LVGPBgG4Ngb
         Hh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5KAy6rmhzFjaxiNMV2Il/dvpATPy+Gr+wAgOYaptcBk=;
        b=cKCB3qymNt0Qvx67/MnFTMOd3dlaE+UrW9BAfE4T+ip83aIrgIlZd4qpiFWf2ISUpa
         fBGrIy5CNPGFTpSPswDxPYHWjlrA/8/ifzZTdfeBt+NalsVJncQjLG6x8Djpaj8BlIHy
         EajU+DlDrf3deDX5guXBdtRVxyg/KWqABHrp39VKxeePsnHCNIoTZ+IsfowFdaWYDctw
         WtEaR37wjAqGVtjFzXc56yq0EKbv9FHLcZecGe+dEfxhV/Wx0M7RQSECEPMoZHSG04qj
         6vXdkUpQlz6HRWvVd72uFEO3PxOa/IRAb4SIgn0GXGKzxDhLPgRFUB35emrVyWKCnIEx
         9J/A==
X-Gm-Message-State: ALyK8tLHUTjWzWSeTtiqCcHvviTNQMISBf8gD5D8IgxbqUTe/Rb/D4xNtmnsaKQCsJ5K1w==
X-Received: by 10.194.78.147 with SMTP id b19mr18279332wjx.31.1466495858070;
        Tue, 21 Jun 2016 00:57:38 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4933.dip0.t-ipconnect.de. [93.219.73.51])
        by smtp.gmail.com with ESMTPSA id s67sm1653389wmf.3.2016.06.21.00.57.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 00:57:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] perf: accommodate for MacOSX
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 21 Jun 2016 09:57:36 +0200
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F67587B5-0EA8-4F2F-AADB-4343B4FEEA21@gmail.com>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com> <alpine.DEB.2.20.1606200840350.22630@virtualbox> <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 20 Jun 2016, at 21:48, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Sun, 19 Jun 2016, Lars Schneider wrote:
>> 
>>>> On 18 Jun 2016, at 15:03, Johannes Schindelin
>>>> <johannes.schindelin@gmx.de> wrote:
>>>> 
>>>> As this developer has no access to MacOSX developer setups anymore,
>>>> Travis becomes the best bet to run performance tests on that OS.
>>> 
>>> We don't run the performance tests on Travis CI right now.
>>> Maybe we should? With your patch below it should work, right?
>> ...
>> 
>> Yeah, well, I should have been clearer in my commit message: this patch
>> allows the perf tests to *run*, not to *pass*... ;-)
> 
> OK, Lars, do we still want to take this patch?  I am leaning towards
> taking it, if only to motivate interested others with OS X to look
> into making the perf tests to actually run.

I think we definitively should take the "perf-lib.sh" part of the patch
as this makes the perf test run on OSX and therefore is a strict
improvement.

If we don't run any perf tests by default on Travis CI then I wouldn't 
take the ".travis.yml" part of the patch just to keep our Travis CI
setup as lean as possible. Running perf tests on Travis CI is probably
bogus anyways because we never know on what hardware our jobs run
and what other jobs run in parallel on that hardware.

- Lars
