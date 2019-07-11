Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3931B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 09:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfGKJvS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 05:51:18 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39629 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfGKJvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 05:51:18 -0400
Received: by mail-wr1-f48.google.com with SMTP id x4so5544185wrt.6
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C6oVCnFML5yLnU1sxCzVe5S+1wtPXlaO+oRY5PjdBQQ=;
        b=f7F2vGQfepglqfT6SG942TQL6D0N9Rxp6BK281AVOgPlv0e28NlHXl7aDdxt9mBMR+
         /bQERUdEKfgAJqxm1P9/iXuzW/Q7HfOfQN8yV7Md99uRpc6H0hnWVgaZS9mP66PKkJNt
         EgeSpqHxX4psuxdq119sqgMU9G/c7GjqCqkCPPi843NSW71F936wk7SlqYiDGgQPA07h
         EiVv5MJfBkmdCobXPw7iO2lnuIo3Bniixdrht75rpn39zCblMOr11rQT/ysUIJlLquEk
         H70MSjtQODJfgn/f/BtkugjiAwNR9SowfPg7Bd9yijADJr6tnK11b8IM/hFfg7moRVd8
         CdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C6oVCnFML5yLnU1sxCzVe5S+1wtPXlaO+oRY5PjdBQQ=;
        b=E7i6NRH1Ez166w0YXf+koaZwxcJh6rFMo/5gDphQLWKkBIVTvPXVTBA92sK93GHi88
         WEK4+kikUX+Q/ohOwRP8sVaxQEPDVDJISUWI7kYnmUbgEc8f5o2mJVxGxS8J4Z8BSeaa
         CbkfKWS9KBXfGZWsMPB9Xdq3IBjSvWePEmwBLxPfVA6m4K8jPXvGH/XbNHdzHx9C1izo
         5NPWdHQCGM7TgKnGzhseUCxWOPtg/fRDqQNwSuQeQzwJCUI2n19DTiIYW1/Af0lTtfDc
         ptxb4NyekeoJkl4Zhbc+xOHQGtfu6FudxxjTG/anVjkcusEh+tQCVDOQD94P7RQbEanC
         FtCA==
X-Gm-Message-State: APjAAAVxadLZHlEGgWmLVQ3gG1NG05fpGH2u4dWxsE9AFXSxXszUvzmD
        xmox7Vmiq37uiraOA9mAqbrvyLGR
X-Google-Smtp-Source: APXvYqyrJYFcZ56QEpmTATyZlB6cBD44sCF2JLZhNGN+6EHTWgQopaIpmiG70qxz1c79KZGV9HeU2w==
X-Received: by 2002:adf:db07:: with SMTP id s7mr3979211wri.10.1562838675691;
        Thu, 11 Jul 2019 02:51:15 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id c78sm5442533wmd.16.2019.07.11.02.51.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 02:51:15 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2019, #01; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
 <9b0fa396-6aae-ff4b-afee-0310a4f601f9@gmail.com>
 <xmqqzhlow5gg.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <709484e2-599f-db83-190b-9bd0203cc7d7@gmail.com>
Date:   Thu, 11 Jul 2019 10:51:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqzhlow5gg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2019 23:02, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> * pw/rebase-progress-test-cleanup (2019-07-01) 1 commit
>>>  - t3420: remove progress lines before comparing output
>>>  (this branch uses sg/rebase-progress.)
>>>
>>>  Test cleanup.
>>>
>>>  Will merge to 'next'.
>>
>> I've just posted an update to this which avoids the repeated printf calls
> 
> Thanks.  Picked up the one from "Date: Thu Jul 4 02:47:02 2019 -0700".

Yes, that's the one - sorry I forgot to add a link to my original email

Best Wishes

Phillip

