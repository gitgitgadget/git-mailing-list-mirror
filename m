Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B74020281
	for <e@80x24.org>; Wed,  4 Oct 2017 11:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdJDLz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 07:55:26 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47375 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdJDLzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 07:55:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id t69so22264414wmt.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xsIkTWM7rJvdT4YFFf7dPYHwkw7cl+sVdsIqwXrJOeA=;
        b=F13WnxeC4W0Bil08Rp/4X0tduupO+TvQPeVkyu6OvF7KbIB16L57piLrfKcFn2isNP
         ycQi49V98oKpxRw++GbF6aH2i2iM7Quq0tqf8kR+0DA2FFxKEaYKrZ4Ua65vYQns2pzp
         BUGt3Jzre4REhyuH+rqu3ATNI+OShSwPuQ6Dxr00bXsd9dFs+ZrN0I2ugAF5EGesl0P5
         Bm6lsu/Tga1/8f6HPCmTz25ySAmc5IfO++/0QiYFTn4FYUdYncYgPzogyzg7cdSdOKz4
         pikqb91N60738mCoaceAq+yXkOgWf7Jd5hZbGeWZHxuUqj/TZfUdeVCyJlTX6Nl58p8S
         SQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xsIkTWM7rJvdT4YFFf7dPYHwkw7cl+sVdsIqwXrJOeA=;
        b=MZcms7IWN7XczMFlok8s6HDYj6bKRJH/rXBx0SFvI8xVs06VNVApPD4EsLJXZo01ag
         blrBT+saAzkQ1rsFoJezjuA30iM0A59pJAgkPzsSchwhdI+7q1zwDsBTV2T2WCJq1970
         P58OhEC2kC8TyI84SWmwig8ANIJWZy5z9WPiSODzdI5Aj5CeuHQHwHiiCvRdy9eB3vY7
         DfXnakspkbKG01vDsj7WpaQPfamEJsRom9sW6FbT4TgtaWeYVEY+qJ8ZKiK9yVr825yh
         qqCtVx5NIprG2OI/nTI4dBtvvmQxOZhTTL22e5qlkbxhmxBpAlJrtKuRmzlDyT+Ztvat
         C3GQ==
X-Gm-Message-State: AMCzsaXq1hPOVzQX3Z0YpQPe7CtmUzusZUYYN6tYabjbcNV01/oGJ/Tn
        yNXo2CDRBoMv0ViMC4PszmY=
X-Google-Smtp-Source: AOwi7QCUAb9RALRXCvnNBDb4zI+SF+FxvXsu5P1lW8uqp1MNvFAVk7yZIOskMB0zksKEfPwHVd8xyA==
X-Received: by 10.28.209.200 with SMTP id i191mr8170847wmg.156.1507118123535;
        Wed, 04 Oct 2017 04:55:23 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x73sm5045631wme.34.2017.10.04.04.55.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 04:55:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: display progress for filtered objects that have been delayed
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com>
Date:   Wed, 4 Oct 2017 13:55:21 +0200
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Transfer-Encoding: 7bit
Message-Id: <C5857D7A-4B8E-4DA2-B2BA-EFE6373011E2@gmail.com>
References: <20170820154720.32259-1-larsxschneider@gmail.com> <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com> <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2017, at 12:52, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 24 Aug 2017, at 21:40, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>> In 2841e8f ("convert: add "status=delayed" to filter process protocol",
>>> 2017-06-30) we taught the filter process protocol to delayed responses.
>>> These responses are processed after the "Checking out files" phase.
>>> If the processing takes noticeable time, then the user might think Git
>>> is stuck.
>>> 
>>> Display the progress of the delayed responses to let the user know that
>>> Git is still processing objects. This works very well for objects that
>>> can be filtered quickly. If filtering of an individual object takes
>>> noticeable time, then the user might still think that Git is stuck.
>>> However, in that case the user would at least know what Git is doing.
>>> 
>>> It would be technical more correct to display "Checking out files whose
>>> content filtering has been delayed". For brevity we only print
>>> "Filtering content".
>>> 
>>> The finish_delayed_checkout() call was moved below the stop_progress()
>>> call in unpack-trees.c to ensure that the "Checking out files" progress
>>> is properly stopped before the "Filtering content" progress starts in
>>> finish_delayed_checkout().
>>> 
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> Suggested-by: Taylor Blau <me@ttaylorr.com>
>>> ---
>> 
>> Makes sense.  The only thing that made me wonder was if we want the
>> change in unpack-trees.c in this patch.  After all, the procedure to
>> finish up the delayed checkout _is_ a part of the work need to be
>> done to populate the working tree files, so stopping the progress
>> before feels somewhat wrong at the phylosophical level.
>> 
>> I think our output cannot express nested progress bars, and I think
>> that is the reason why this patch tweaks unpack-trees.c; so I am
>> fine with the end result (and that is why I said "made me wonder
>> was", not "makes me wonder", the latter would imply "this we might
>> want fix before applying", but I do not think we want to change
>> anything this patch does to unpack-trees.c in this case).
>> 
>> The delayed progress API is being simplified so I'll probably do a
>> bit of evil merge while merging this to 'pu'.
>> 
>> Thanks.
> 
> Hi Junio,
> 
> I just realized that this patch got lost :-(
> That means 2.14.2 supports the delayed filters but does not show
> progress to the user. To the user Git will appear hanging.
> 
> Can you merge this this topic for 2.14.3 / 2.15 ?
> 
> Thank you,
> Lars

I should have expressed myself more clearly:
The patch made it into master with 52f1d62eb44faf569edca360ec9af9ddd4045fe0 .
Therefore, I think it will be released with 2.15, right?

The patch just did not make it into 2.14.2 and I wonder if you could
merge the patch for 2.14.3?

Thank you,
Lars

