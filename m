Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099182021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbcKFOnn (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:43:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbcKFOnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:43:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so12066033wmu.0
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qi/TWzzSKrceUA96e9wPlHRYZXKaQqC7nwRwCye3ZtQ=;
        b=rXJsMDg0aH5wFDlAxLCYFefbOOfelliVt33iJ1ds7pInfcnltkjX9hJcNAq5s/NJXV
         P40igy07tNssI2LddLmtCB+14Ma4Za9n7/2rBmlPZfd9JHNU/8bR/YgCCjyIkftj6hdA
         vEkUk8Ju5dccAhGsHgyZZ7jyp4gZjI3OndKLx7wFq5wKzG2vZxC3JGBU7r7jHeaqrFZR
         4hBOiNrZHyTHdAJAhyNkOc7y8q+pL3HGk4sVbDw+QA/dSU5Yyd9Q/lTEM8stkfMKrmnF
         45jZwP/YTczwYKHITDCe4c9sj+Unu5hMwHdB11dIYx9J3kfn0AKH+m7iRcOyneZugsoT
         Zu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qi/TWzzSKrceUA96e9wPlHRYZXKaQqC7nwRwCye3ZtQ=;
        b=NvDW/IS53F8RtOV5puIVjqD3A8mMOMd2Cehy5dJeMZPtVb5jfxEGV1TqAoiQyAgeXq
         d7wUGtjTomuT0Y4pabc/E75CAe8SETx9VJh4i/YdXYv376j+tzd/os/0GnRkCiWky4ux
         0O0ilccg6eUU8JqTeqDESjodyvAfyVq+ueMxGARb3xW4DEc7Iz+/a75v8aPrJ4wuqX6E
         Hk4a2reoiFxwNEfXPXYkylTo3D3SNXfK+g1739/mEXxMfv7T7p7x2rQukkgK/Bh55mdS
         mEi+h5YvsvOXbf1FTMj5qMMrG0sbLsmK8K7oZEngBjFvIHqms9H/uU1GXP3fXLZEDCZY
         VaXg==
X-Gm-Message-State: ABUngvcIASBkax0kArwmMcYhjH+s9B3c3wYGt36TVPNRvbWYM48msIewy06esWAaqS5wcA==
X-Received: by 10.194.119.162 with SMTP id kv2mr1948019wjb.182.1478443421771;
        Sun, 06 Nov 2016 06:43:41 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id l2sm618831wjy.39.2016.11.06.06.43.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:43:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] t0021: use write_script to create rot13 shell script
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161106142957.52wx2llanw5bis4i@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 15:43:49 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <65249E23-8685-44A8-B2AC-9C414658540E@gmail.com>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net> <20161102181751.trxsns5pxqk73ukc@sigill.intra.peff.net> <22DAA280-1857-4E22-914A-1208D784DA98@gmail.com> <20161106142957.52wx2llanw5bis4i@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Nov 2016, at 15:29, Jeff King <peff@peff.net> wrote:
> 
> On Sun, Nov 06, 2016 at 03:25:33PM +0100, Lars Schneider wrote:
> 
>> This looks good to me (and it works on my machine).
>> However, I took a look at the "write_script" function and found this,
>> added by Junio in 840c519d:
>> 
>> echo "#!${2-"$SHELL_PATH"}" &&
>> 
>> There is some kind of variable expansion happening with the "2-" but
>> I can't quite figure out what is going on. Plus, I can't find anything 
>> about this in the sh docs.
>> 
>> Can anyone help me to understand it?
> 
> See the section on parameter expansion in "man bash". Basically:
> 
> ${foo:-bar}
> 
> expands to $foo, or "bar" if it is unset or empty. Without the colon:
> 
>  ${foo-bar}
> 
> expands to $foo, "bar" if it unset (but not if it is empty).

Ahh! The missing colon tricked me. For some reason the version
without colon is not mentioned in my docs (GNU bash, version 3.2.57)
or I overlooked it.

Thanks for taking the time to explain it!

- Lars

