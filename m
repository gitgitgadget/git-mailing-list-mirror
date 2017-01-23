Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A89520A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbdAWSfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:35:31 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34302 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdAWSf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:35:29 -0500
Received: by mail-wj0-f193.google.com with SMTP id ip10so2648547wjb.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pmFeK2ID3wL15eCN/03wJtmfufNjqiWcsPdt0AeZ84Q=;
        b=DNJHuuF2J9+nTo7zR3uupkIXsIjR4Rzjnrzu9a8Lg30a0bQSSOIUbiNiUNGn5IwkhL
         TGfq0OPzNOqEcCk8V05QxwgERD2XNgtZLO1ssKth6GHG06Bx2F8D6uwTV87kjHBJdZSD
         uv9Cr24YXhq2x1fauBdPx901HBbjnLc5LMD71tW6sAoWh9pah1y3Jd0ZYnmauUMZRXr+
         rBRy8mwfJQx3rBkcQj9lKIc5jwmgtJqcZzXdAbfS0vOO27RcddvQHIskOmSEBhl78ObM
         u7/XYY91wkLzDZ5AqesRAkil+r0ZIdlVnjxXFwxD4LCnLwkOwuiH+UupvZ15qfuNyRuZ
         ahKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pmFeK2ID3wL15eCN/03wJtmfufNjqiWcsPdt0AeZ84Q=;
        b=mUMiMtpwkshr2M55GlevYP+G8TNn1V9bFLnbXpODpSfmLXgfIUMLb4d71F0kaB2UJX
         nii8ZxlGFCCgc4YkHFXU0IrdiEFj6HYEeJtZvgvCYapxtUicmBX0Nr/zKYUYVZSUrMRJ
         Gn7lL6YYu59YDutui7VV0sX7sQjyPW8+LAEuSVz/vXSCrid0aEKzHeKYbseIGZSwxuyo
         f8pCqxlpNKkNm8JEgS6vdIb7/ssNLpBS76A5n9SHWDmIx6GrW0mfspp0pYTTsWtUDpkc
         NutCjtnkpLBImkdK33nx3IG6ONB7Gy9VHUg5IKg4RNfmGyC/pu+os+HKdsjdZKReIqu5
         MN5g==
X-Gm-Message-State: AIkVDXLDeDZC8qy1fVYwradDf6de6o8brpZlGWWOeXAqjIFYrYp62NbscyCQ0xb1E+BwGQ==
X-Received: by 10.223.177.130 with SMTP id q2mr25425224wra.39.1485196528360;
        Mon, 23 Jan 2017 10:35:28 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l140sm22483701wmg.12.2017.01.23.10.35.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 10:35:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: fix Perforce install on macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tq1tz49.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 23 Jan 2017 19:35:26 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <56F3C5E4-0E50-453E-BF47-AFF38BC7906D@gmail.com>
References: <20170121144245.31702-1-larsxschneider@gmail.com> <xmqq8tq1tz49.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Jan 2017, at 19:22, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> Could you fast track the patch to `maint` if it works without trouble on
>> `next` (as it should!)?
>> 
>> Notes:
>>    Base Commit: 787f75f056 (master)
> 
> I do not think there is any difference between 'maint' and 'master'
> for this file right now, but I still would have appreciated if this
> line also said 'maint', not 'master', if you want it to go to
> 'maint' eventually ;-) As https://travis-ci.org/git/git/builds seems
> to be doing 'pu', too, hopefully we'll catch any issues there first.

You're right! My own automation betrayed me :-)

I made a tiny change, though. Can you queue v2?
http://public-inbox.org/git/20170122225550.28422-1-larsxschneider@gmail.com/

Thanks,
Lars

