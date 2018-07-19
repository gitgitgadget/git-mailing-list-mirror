Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2AE1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbeGSTK0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:10:26 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54802 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSTK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:10:26 -0400
Received: by mail-wm0-f47.google.com with SMTP id c14-v6so7155353wmb.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ehLbGdPWOdKP/0zqmC0yHzRJkp784HsuXb9sPB7y7SQ=;
        b=iRjkUw153DIG63JUXp41EZMT9+M5bDDyBymmFzC6rwbVxGEMuZijf9tiS2nlZt70wI
         SP83zokJcChPjvnXovbU3j97xioE/28gHBuomwbmK/PWJFUoLr7p49V3uQBuiJFP3GQk
         WvbsSbKTrUgHgy6NVrBAq5Rqeyd9xzm7WmpsWC8CHjLPtTK58EV5Tl7SG7IpP7WDP/hm
         EtjbEYUXPrv0VyJRxuKe7l3vDBuzYOLYdx13bpM9ofiOeqj35wK+/WR0SgdrX+8RvMSp
         COzcMSogk390WuEH+J9oKVFW6F65Ue/XRXI/xerhCla8Gkas4dAZ57OrvpofWY3COhSw
         dMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ehLbGdPWOdKP/0zqmC0yHzRJkp784HsuXb9sPB7y7SQ=;
        b=l1YCrSZ4t5UZoyHb1gmzIt5v0ZFtU0WBgiaOl4sO4GZGjsj996dXIUw029YlaF5/v0
         lawDG/AsIUk9HiVQJMwQGz90JWsBsDtFD6KUqFXRAyWySiZWbqPCjT1CvitP5A4bB6kw
         jW6klr/S0a3eqH63495GC/AObmUzlPOmEESUZTm5Yd+3+gs600jEAhXwh7XxfETvZmiv
         cLupvQxxuubeR/+DqqRAB7KeenyOQFW1gajgnoX4VpqevVxLSyLXL/73HQm7MqyWufSp
         NEoxCNSbfV3X8loLDmvZ/9pnYDlLfJs2XyUtu9F+Y2afwjOxbgYquIQEchOU/27QlWVH
         8rQA==
X-Gm-Message-State: AOUpUlGN3UKc9DBSrrjpYEQbDPoRLzoIAbZxqAMuWkRdbYRoc+tvV/uz
        TWqrdqSUpOsY0vMpnMWYHag=
X-Google-Smtp-Source: AAOMgpcGIo8Nbn39yT1JPHxKfAsUHewq5FO94suwDfOXfvQR2rYNqXc0vC6xT5LU6TVbiZciBOfPag==
X-Received: by 2002:a1c:6c03:: with SMTP id h3-v6mr4698359wmc.38.1532024763075;
        Thu, 19 Jul 2018 11:26:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h1-v6sm7220747wri.90.2018.07.19.11.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:26:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/23] archive-zip.c: mark more strings for translation
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-4-pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 11:26:02 -0700
In-Reply-To: <20180718161101.19765-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 18 Jul 2018 18:10:41 +0200")
Message-ID: <xmqqin5bf5fp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -		return error("path too long (%d chars, SHA1: %s): %s",
> +		return error(_("path too long (%d chars, SHA1: %s): %s"),
> -		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
> +		return error(_("unsupported file mode: 0%o (SHA1: %s)"), mode,

The same #leftoverbits comment as 02/23 applies here.

> @@ -601,7 +601,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
>  	struct tm *t;
>  
>  	if (date_overflows(*timestamp))
> -		die("timestamp too large for this system: %"PRItime,
> +		die(_("timestamp too large for this system: %"PRItime),
>  		    *timestamp);

I suspect that this won't do the right "cross-platform" thing.  For
built-in PRItype formats gettext tool knows about, *.po files let
translators translate original with "%<PRItype>" into localized text
with the same "%<PRItype>" left, and the runtime does the right
thing, but for a custom format like PRItime there is no such
support.

