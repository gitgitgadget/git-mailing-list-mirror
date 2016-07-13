Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A142018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbcGMSQz (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:16:55 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34188 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcGMSQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:16:55 -0400
Received: by mail-yw0-f177.google.com with SMTP id i12so50522268ywa.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 11:16:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Q2wXYxVCu2IWHWJ+Yq6lWwVICrRo3pIPKPKTbF96i6Y=;
        b=bu21x+K//Xw9RTJ/YrPH830NvNbD/aqYR819cPRv3wZQnsEszReCNksccMCA5/fPo1
         lSN+1VNGgZvtXuQeA4mpcO6tdgCXnYEKKD1MBycdFLjAaHww27XyXN1dYzJ8ryokQ/Sf
         Vp5od92P+o39eZo7sbPjDr571jAL8NgDphlHLB/So8AlKVDiJTToQ7nUU10PDPTZI88Q
         pYyJj4OLopNnW9HE6yBs2mwW8RPVFq3xr2XrULpgPFwX4xYNi82xBAfFHUvmBsiObUdc
         pvmFojM1T0GRH1Q+bGtU8Tt1vEZDZX8aujkcCo9ylhlR3mo73B6UUNgGWhgfOL1Ay6Io
         HB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Q2wXYxVCu2IWHWJ+Yq6lWwVICrRo3pIPKPKTbF96i6Y=;
        b=gJP/ANnviPal64gSSPCt24HKF1BT/3+E8sM3/IM+fIPbcjPzNqTnY8GfQBa44jDDdB
         homhXLavsH6MOXH4LJFmhG98Wc0uR36A8q7uju81E98cZvYIGoxYXFxIxU3GOYZIVk4r
         5pozmvU9exs4CaUMlZNmvStf9oV5AEXZ5S83zsBzD7nbJ2P1FxAWgfK8X4wJLFC/Cl0e
         MUaJtDZqNVHs4VOMK3M0zoIhjTIgRlwz8h7e7MEDDSIRnZS/NkrgqC/vHy0t7fQfGWBz
         22qJXfwXNJPHrs9jx6S7MGQ6YJv8i6hZAwKx4hL8Dl4l8s8dVgMzkqTg8dhalhxZj+KA
         ggPw==
X-Gm-Message-State: ALyK8tIlT91HOlfRW4yYTKwJifeHYnjwfNVFqhFkK5FrW0b8ZEgPmteYqav6kVmc2mG1KwhOPDFKc6OfreDopg==
X-Received: by 10.129.105.136 with SMTP id e130mr6918981ywc.176.1468433807166;
 Wed, 13 Jul 2016 11:16:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Wed, 13 Jul 2016 11:16:27 -0700 (PDT)
In-Reply-To: <xmqqd1mh1kbd.fsf@gitster.mtv.corp.google.com>
References: <2908abd39c722c080ec37a987a79e32f@cryptolab.net> <xmqqd1mh1kbd.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 13 Jul 2016 11:16:27 -0700
X-Google-Sender-Auth: sNs7Wdm60JAZ2ZHUPo0rYD9Iof8
Message-ID: <CAPc5daXq-WBEYTyi2M7kMoZtQCYgucCRQ=GFVt8U_H_vRYyZPw@mail.gmail.com>
Subject: Re: Https password present in git output
To:	ervion <ervion@cryptolab.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ervion <ervion@cryptolab.net> writes:
>
>> Sometimes using ssh is not possible and saving https password in plain
>> text to disk may be desireable
>> (in case of encrypted disk it would be equivalent security with
>> caching password in memory).
>>
>> One possibility for this in git is to save remote in the
>> https://username:password@domain.com/repo.git format.
>
> Wasn't netrc support added exactly because users do not want to do
> this?

Interesting. Even with "auth in URL", I seem to get this:

$ git fetch -v -v https://gitster:pass@github.com/git/git  refs/tags/v2.9.1
From https://github.com/git/git
 * tag               v2.9.1     -> FETCH_HEAD

Notice that "From $URL" has the userinfo (3.2.1 in RFC 3986) scrubbed.

If you are seeing somewhere we forgot to scrub userinfo in a similar way in
the output, we should. Where do you see "present in git OUTPUT" as you
said in the subject? What command with what options exactly and in what
part of the output?

Thanks.
