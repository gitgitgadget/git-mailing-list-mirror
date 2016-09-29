Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C770A20986
	for <e@80x24.org>; Thu, 29 Sep 2016 10:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755635AbcI2Kjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 06:39:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755412AbcI2K21 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 06:28:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id b4so10042790wmb.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 03:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KCWHuRKAfF+rLWuhXzCKY1dccXHB+9jH6gOTlhNkiZQ=;
        b=I0hl5DiHYF6hH9Bf/vkxnUp66i2Kj/l6Rz7E/70nZJx8ZjOZcp/Ws+gw2UuHTQK4B5
         DwGrhed9+Rrquo2FycXotILh7Jqc1hDocrUKDUkapAN2l7PZ5FQbvbbDwZG4P0LaRwON
         d+kNoDSBDrwLYlk+bOuyp0idHdtWL7eLtg6fpuceaGqehgrIlOTrX5PQ9MubQl8Qaarv
         y4gdYAmQSJAiF6YANvu2DCvLp+OyPQMYlw8NnJJLTsuHFPXLvgETAOodzxws4vGirutB
         16+ah8aZoQjNS5O+9up+u603s9Z3ej5XJYZin+pAazkgYQ/e/+llWGbnGj567dmxU81Q
         ovhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KCWHuRKAfF+rLWuhXzCKY1dccXHB+9jH6gOTlhNkiZQ=;
        b=GmxL36xgqgU/oYyawEB/RZdHjk+GGEXHd0PniC19NPGPqmFpAtXOSKp0RJPIH7CvrQ
         EMs2KOkuY9tK3PeT7H4FqVm4glSlhbnWyhNZldQiSmafAKa1+r3TOU8rOrLJz7DbtDNH
         0dG22+iMHC+JX2qDShpkaMI/va1ZbFavQlGg3GiO9Q6gCfOgstot71jkbwETeODV+cWP
         P2l1ZpAMj08cio8aBPXVeCaDKJeZPci++ueWvdDZRl2998BRXl0XqFUg3rte2Q4x/0gT
         GJYNx1JODh54srPKPlkb9MrtisNPtg1zmxACEZ5Oqm8JdSYCZDMe6VoERCsgssdIJumh
         7JUw==
X-Gm-Message-State: AA6/9Rm7UhDjSqAoDiD5Rp2UpLBP2CYedCjSggiGln0afXOQ/JQggF+44nWg21Zf2i1GSQ==
X-Received: by 10.194.71.104 with SMTP id t8mr747290wju.17.1475144904822;
        Thu, 29 Sep 2016 03:28:24 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e12sm27390470wmg.17.2016.09.29.03.28.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 03:28:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 12:28:23 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 7bit
Message-Id: <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Sep 2016, at 23:49, Junio C Hamano <gitster@pobox.com> wrote:
> 
> I suspect that you are preparing a reroll already, but the one that
> is sitting in 'pu' seems to be flaky in t/t0021 and I seem to see
> occasional failures from it.
> 
> I didn't trace where the test goes wrong, but one easy mistake you
> could make (I am not saying that is the reason of the failure) is to
> assume your filter will not be called under certain condition (like
> immediately after you checked out from the index to the working
> tree), when the automated test goes fast enough and get you into a
> "racy git" situation---the filter may be asked to filter the
> contents from the working tree again to re-validate what's there is
> still what is in the index.

Thanks for the heads-up! 

This is what happens:

1) Git exits
2) The filter process receives EOF and prints "STOP" to the log
3) t0021 checks the content of the log

Sometimes 3 happened before 2 which makes the test fail.
(Example: https://travis-ci.org/git/git/jobs/162660563 )

I added a this to wait until the filter process terminates:

+wait_for_filter_termination () {
+	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" >/dev/null 2>&1
+	do
+		echo "Waiting for /t0021/rot13-filter.pl to finish..."
+		sleep 1
+	done
+}

Does this look OK to you?

- Lars
