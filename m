Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A61520365
	for <e@80x24.org>; Wed,  4 Oct 2017 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdJDNeD (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 09:34:03 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46995 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdJDNeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 09:34:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id m72so22959957wmc.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=firWo+AAdqOXgVWMnZTq7JWf+yO8UZrp4gbG8Y0/bJo=;
        b=nwFw5cHQJybpITdpdpo4R2ty3sAyfySjz2TsmXoBDrNzj4LUlrRWAuTJroncN2X3Vu
         YvPio8QdNg4kgxdMjJDm2KVK01w3d3A7+2YbkoqjK6sBI6SXsTmda5ttRCrCkys3mqRS
         T0aeFzv6eZUJYWlhxsjuoS1ekrmKm4q063pq4OfzBSB4k/5voa0WUHc5H2OxLc9/lvn4
         eWL/G/Nf16AvSNKZCgSXycHiC60WqTRu3ulBHgRtBmK8JpaMXpXRncSbC71MWhNUmC99
         YeeR4uKTCruUU1XqMwDvABIU8QNTdzlbSRWAXDqmt/Jm6tTC9luZ2msN9oUqmc/8/Qlp
         7hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=firWo+AAdqOXgVWMnZTq7JWf+yO8UZrp4gbG8Y0/bJo=;
        b=OsIUOO9BIjxQzvd7g6Lkuc2NyBzPt3ezl/aCzdJmkm5Y+CE8di2ROLjRG5HlEQ5+52
         K/vcm0jGiXTzg7XrRsFMruUORTqKOQtrrNwaDj7hPgNGNcMyY9WiGmqu4e5s2g8HC7ph
         IIgrvfSczTDURMtpfbY4+mL63rqL6ci6s6YfLa2i1J7lELO4oxSAwH+KtNa/ACGlS/t0
         Yesdwqeo44iISEHQb4udvCNj9BoBFYKWLtXA8PmJjVBtBO1SCigbky1qixH3cRDlRaer
         U4qyoQHCc3abPSy/IgVSkffU/7nxe9QawQzevVdMtXWOq6vr4uCvXk0ZaotTtTrMBIcR
         81Pg==
X-Gm-Message-State: AMCzsaWuk6moXsOiyeUckfkf26zrYV9hwMnE0MjZHN6j4L2hXl1Leb89
        86atPr9fjgERA4ZdnkNXWkM=
X-Google-Smtp-Source: AOwi7QDIFpahb0QGAffjoGY8LrksSL28QjSUDYYRQnw8kXF/U85bQ7KE8hnaf/bk10/qcT8tMmcxpg==
X-Received: by 10.28.55.78 with SMTP id e75mr3696061wma.112.1507124040978;
        Wed, 04 Oct 2017 06:34:00 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 200sm17179166wmu.44.2017.10.04.06.33.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 06:34:00 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: display progress for filtered objects that have been delayed
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2uj9lfk.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 4 Oct 2017 15:33:54 +0200
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Transfer-Encoding: 7bit
Message-Id: <5625E29A-D24F-4A5F-AA52-58F2EBCA9648@gmail.com>
References: <20170820154720.32259-1-larsxschneider@gmail.com> <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com> <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com> <xmqqr2uj9lfk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2017, at 13:55, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> The delayed progress API is being simplified so I'll probably do a
>>> bit of evil merge while merging this to 'pu'.
>> 
>> I just realized that this patch got lost :-(
> 
> Really?  Isn't it 52f1d62e ("convert: display progress for filtered
> objects that have been delayed", 2017-08-20)?  It already is in
> 'master' since about 3 weeks ago.
> 
> As this is merely a new "feature", I do not think it is reasonable
> to expect it to be merged down to 'maint'.  In fact, I think your
> original patch <20170820154720.32259-1-larsxschneider@gmail.com>
> declared that its Base Ref was "master", and I queued the topic on
> top of the then-current 'master', so it is not mergeable to 'maint'.
> 
> It may be cherry-pickable, but I do not think it deserves to be.  It
> is not a fix for a grave bug or anything like that, right?

The original topic 2841e8f ("convert: add "status=delayed" to filter 
process protocol", 2017-06-30) is a new feature. That's why I was
surprised to see it in 2.14.2! The problem is that this topic
might appear "broken" to the user without the progress output
introduce in 52f1d62e ("convert: display progress for filtered
objects that have been delayed", 2017-08-20).

In summary: 2841e8f was merged to 2.14.2 and 52f1d62e was not.
Therefore, it would be great to have 52f1d62e in 2.14.3.
Does this sound reasonable to you?

Thanks,
Lars
