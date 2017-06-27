Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710D02082F
	for <e@80x24.org>; Tue, 27 Jun 2017 12:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbdF0MHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:07:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36379 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdF0MHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:07:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id y5so5380572wmh.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jpZ2eatQJPc6+WJps7AHOk750HdeDfyySCJ7DuF8XNw=;
        b=SzvCqVuYGOJv3hp/nPQeA1xpw4YAvKqU89nZk5ge6luVWtLgHbTWAbtxeq2Iq4w/Rh
         FbPmukzkkKJKD2aaqsLhFPLZRo4WvRymE2mVXGFrg4fmej84iDJuXDkckhVfy7lF/c6v
         H7JrfMYBTG7cs8QaxYp8mGyADO4g8+y2BOJLYdoj6suGLGFf7T073xPwz2wmpUlHfxyz
         558wKqUrxmLG2+sgINPgCOOH3ymVFYlpk4ex6UwkzmOV8PaAFmi6iRXFUI2D6U02wRpp
         9Ab9eEiOZYMYuNihDRtqg+8x8jyjKcapvokA4Mp7h/sJEIoRWfqlzPZ1V4T7PsH1lCx3
         IPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jpZ2eatQJPc6+WJps7AHOk750HdeDfyySCJ7DuF8XNw=;
        b=mSFiR2lnQol+SfQR0vakv7Rlb8JYvwkc1cTrZRe9v+CPBp+FIAwYz33UZ2/cpYFEt6
         4LhPtn3ZJLwDgCd/TIRkUKUcUJAldbmZyrTAzF/trPU6QipTv79fjQzY3CiCKxAjcGMW
         Tz6q3c8/lgZYxfMjLcLNshdqXbYJU998Zaj0PeJ7WyoA4gWQk+C/NeJW8acjxM1SjW6k
         ns+5KwFHfre+LyyG5GSuevpsRlqSKcrS2J4vFyJ2A1UMEwDlidQoidA2ginK5paZ3ViG
         du1rT+xVKZUSxh9xLTTchzwTYj4msg1UN9H5P4kNUe5rnowVlQkE2Xq+WSpCwVBOcvth
         6+Xg==
X-Gm-Message-State: AKS2vOw3aa9EWJG3vtXVooRVCnlVZaC38V6MrpbnvRISwg4fUFz6ZWhy
        gONhPN9SGBjxnQ==
X-Received: by 10.28.20.76 with SMTP id 73mr3258342wmu.118.1498565227404;
        Tue, 27 Jun 2017 05:07:07 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y35sm12372511wrc.51.2017.06.27.05.07.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:07:06 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqa84u4cuk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 14:07:01 +0200
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>,
        peartben@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <22F3047C-F2B2-4327-97B4-3C2347E1DD0E@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com> <20170625182125.6741-7-larsxschneider@gmail.com> <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com> <F72755BA-6296-4C37-9EFA-4D7BCE9F1082@gmail.com> <xmqqa84u4cuk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Jun 2017, at 00:13, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> ...
> 
>>> I am wondering whose responsibility it will be to deal with a path
>>> "list-available" reports that are *not* asked by Git or Git got no
>>> "delayed" response.  The list subtraction done by the caller is
>>> probably the logical place to do so.
>> 
>> Correct. Git (the caller) will notice that not all "delayed" paths
>> are listed by the filter and throw an error at the end.
> 
> I am wondering about the other case.  Git didn't ask for a path to
> be filtered at all, but the filter sneaked in a path that happens to
> in the index in its response---Git should at least ignore it, and
> better yet, diagnose it as an error in the filter process.

Agreed. I've used your implementation suggestion [1] and added two
test cases to ensure we signal a proper error in case of a buggy filter.

Thanks,
Lars


[1] http://public-inbox.org/git/xmqqzicu2x4a.fsf@gitster.mtv.corp.google.com/
