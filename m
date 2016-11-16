Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8355C203C1
	for <e@80x24.org>; Wed, 16 Nov 2016 09:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbcKPJxW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 04:53:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbcKPJxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 04:53:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so9273575wme.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CQCnzHNSS/Z1aDoRAEDRsjzdM9KL5v44rDCrqjuXslE=;
        b=fDJY7Jcs9SqiSsGKip/XmSOfOQzBLpadwVESE9RbyPrIGXVEEBIivlS1YAmaxsh2U1
         FsNxWvmErVoFhyfZSsmMI64ek2j86sW7JxKPQiZpTq1ePJjYp9QxSu2kY/P4CrpI3Hby
         YSno8sAp8N+aU1ZaP/+DWF01doAi3LsFc3mDWefYsBw4UNb13WsHIb49DImoRy0JkEg0
         Dk/CMO3RjPCzfWkXY0VkhFV/TkGrImaCwCTxGiXEgfYFxZHtzJnhiREmnNlxUYGOb+yh
         iiZpDASwWO2QTgPxechkMedwISq1k8SiRzSgq0I2kZ8rchPhCJ7k15A48tKNCVC9Gawb
         5HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CQCnzHNSS/Z1aDoRAEDRsjzdM9KL5v44rDCrqjuXslE=;
        b=i3pQxgT6nHbwVwz17ME3oskr6KCY6elxuaXzsDK97pqeIN/H7Qr1YsJ2dKsfXK0wrr
         MuN5l0+HbZVHnvW6IYvYvqGbhnjIMGJ3KmMV0bTXNMAKXXGDVs5UkqB5KRpX7j1cFFu3
         Cst0sol2M6yd6xgkdNLvwna8fmKU8JbpCxwMONCDN7R7ff0Vm8M944CWKfoPz3LS2cB0
         UVUKOklCqTU99W0JXsO/0JaCWRNy1IebyIEyhz+tvtIlSGvmUmwf4FzSO5iYbdWKEF+E
         moZuZimvRa3SwDicQYS8fE+zLNCgjjtJ8I12Oaif96BB3T+dL5YJIbrotY1wOiFzzGFK
         G12w==
X-Gm-Message-State: ABUngvd3z8fskbp/Fc3/AGX+aKJNISRVc2m9oKCcNorHeYevqAz/taRR08bZAKFcGJTL6g==
X-Received: by 10.28.143.20 with SMTP id r20mr8461814wmd.2.1479289997089;
        Wed, 16 Nov 2016 01:53:17 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4EC0.dip0.t-ipconnect.de. [93.219.78.192])
        by smtp.gmail.com with ESMTPSA id i132sm9131275wmf.14.2016.11.16.01.53.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Nov 2016 01:53:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 16 Nov 2016 10:53:17 +0100
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <20161115010356.GA29602@starla> <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com> <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 15 Nov 2016, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> The filter itself would need to be aware of parallelism
>>> if it lives for multiple objects, right?
>> 
>> Correct. This way Git doesn't need to deal with threading...
> 
> I think you need to be careful about three things (at least; there
> may be more):
> 
> * Codepaths that check out multiple cache entries do rely on the
>   order of checkout.  We checkout removals first to make room so
>   that creation of a path X can succeed if an existing path X/Y
>   that used to want to see X as a directory can succeed (see the
>   use of checkout_entry() by "git checkout", which does have two
>   separate loops to explicitly guarantee this), for example.  I
>   think "remove all and then create" you do not specifically have
>   to worry about with the proposed change, but you may need to
>   inspect and verify there aren't other kind of order dependency.

OK


> * Done naively, it will lead to unmaintainable code, like this:
> 
>   + struct list_of_cache_entries *list = ...;
>     for (i = 0; i < active_nr; i++)
>   -    checkout_entry(active_cache[i], state, NULL);
>   +    if (checkout_entry(active_cache[i], state, NULL) == DELAYED)
>   +       add_cache_to_queue(&list, active_cache[i]);
>   + while (list) {
>   +    wait_for_checkout_to_finish(*list);
>   +    list = list->next;
>   + }
> 
>   I do not think we want to see such a rewrite all over the
>   codepaths.  It might be OK to add such a "these entries are known
>   to be delayed" list in struct checkout so that the above becomes
>   more like this:
> 
>     for (i = 0; i < active_nr; i++)
>        checkout_entry(active_cache[i], state, NULL);
>   + checkout_entry_finish(state);
> 
>   That is, addition of a single "some of the checkout_entry() calls
>   done so far might have been lazy, and I'll give them a chance to
>   clean up" might be palatable.  Anything more than that on the
>   caller side is not.

I haven't thought hard about the implementation, yet, but I'll try 
to stick to your suggestion and change as less code as possible on 
the caller sides.


> * You'd need to rein in the maximum parallelism somehow, as you do
>   not want to see hundreds of competing filter processes starting
>   only to tell the main loop over an index with hundreds of entries
>   that they are delayed checkouts.

I intend to implement this feature only for the new long running filter
process protocol. OK with you?


Thanks,
Lars
