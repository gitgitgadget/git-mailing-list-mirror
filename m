Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1C41F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdLSWfF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:35:05 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:41946 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbdLSWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:35:04 -0500
Received: by mail-qt0-f170.google.com with SMTP id i40so26164287qti.8
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=USZEdnyltwmYP3kWoquyQXON4mal6cJQuonEg6R2tjc=;
        b=BDT3QbHB8A796WP/jRZ2wLCUItU5TwbZAsAUF6kXAiGj48twe0tnAN+f/RoIcrlWVl
         zHoOR5zu0GKRNj0SHLMzQ421epGnLg3BYxgDWvmDH0TBLYP6DoP0aC9K69wJOP89/da3
         18jYSkGa8KhcaWfxHcR/O8YgBXU63ZcoAB+yjCCOGfHhA+Tk1GhSmHiotXwHXOGzdgvs
         QkFmW9PmkdPkdLY9A1vhXiOMq/Y21/TWG2BfGqnOnGq9UkL4RqdvGLc81YUE4CJQXSez
         S2MQLnqp6vrGxcWS711F16L7iF0F/AGf2nc4uNUZN2Q67PUf5vU9Zg4pdgqxsfBdDI1e
         hHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=USZEdnyltwmYP3kWoquyQXON4mal6cJQuonEg6R2tjc=;
        b=YqsmWrx7643pwMVAhARlofFgPqn8Ihqh+LJ71luKFpb5+N7Wn95KG0KTYCHUrmoImx
         AKDPnMis8/t/iSMI2CX4Y2kMURc3XR4UrA41UTdxQPE59489TXl+HNg1DXIC8ez/xQUu
         goHfln6h7vBDvpTTn1GRHqJZOS9PPxkwx9za7jAdf9WzE2fWhhNG87f3kZm5FW+dZ98y
         qjfzfRjNdychN3uusFLloI1hYlh9JWSM1cvqIxyI6QwXyZIMmq0/wxHlWLm2j8+IAG8z
         DgKWc1mdgZDgSPmgffOkzO2agsE7rLv2siwMF7JNTv3buJ3z/uPhcb1/l/IOpOuedfUC
         N8mQ==
X-Gm-Message-State: AKGB3mKVrX+DgEN9tMnP+w4cF3B58KBX25KEOByW6NKS1lh02B/yIrHC
        vGZB/DizDvzPapheRxTpbor5T8YeSDJ0CLWfXPZGORYC
X-Google-Smtp-Source: ACJfBotkxktqVHq4RRRoQSzcCSFyrLNVIZZ00oOhBvJt+tI8y7b+/s41Ta0mK5P/QTTfE/+sM5ZFgpS4PH803AC9mtM=
X-Received: by 10.200.35.215 with SMTP id r23mr6934306qtr.174.1513722903550;
 Tue, 19 Dec 2017 14:35:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 19 Dec 2017 14:35:02 -0800 (PST)
In-Reply-To: <20171219223130.GF240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171219222636.216001-4-sbeller@google.com>
 <20171219223130.GF240141@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Dec 2017 14:35:02 -0800
Message-ID: <CAGZ79kZhiX8jqz-LxpeMp92caqU6urxS3T8gxoB4toDkGw0g6w@mail.gmail.com>
Subject: Re: [PATCH 3/5] t/lib-submodule-update.sh: add new test for submodule
 internal change
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> The test is marked as a failure as the fix comes in a later patch.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/lib-submodule-update.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>
> I think I'd find this easier to undrestand if it were squashed with the
> patch that fixes it.

ok, let's squash this into the last patch then.

> This is part of test_submodule_foced_switch --- does that mean it
> affects both checkout -f and reset --hard, or only the latter?

All of
  checkout -f
  reset --hard (and not reset --keep ;)
  read-tree -u --reset

Thanks,
Stefan
