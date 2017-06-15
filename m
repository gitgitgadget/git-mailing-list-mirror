Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6337E20401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdFORb4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:31:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35878 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdFORbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:31:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so970035wme.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w2HKotNEampy38JcqS2jO5jcg6JRRDemA7j3BNjJy3o=;
        b=FA8FxGBB3xVpIWdvYNcA2gB2AhwDVcprUXfJjsvdCrTmPWsO+DJ1KZ3PSDVdYYYoQV
         MmHKd49JTDJkhn0qOVji3+R5ZLphRo8TpqYZ0pAik0eoEAMmi9DqaJOJSmvDZ9OGZ/zW
         UR8ROYGslOIveEFiG1osH3XqWQunVniCkuKD/vD4V0F98Lgnls4LfpTqJ/S13Y7AwmE2
         yC2KaiHqA0wSN5A7zjnqifn/9GOODlzMSYMJmq/J/FlthSU7lE+fCkq+OOOAqWl9bxUS
         ObCWdBgF3CkSYWJ3bKUoWAht3OKpgl5D4FYX2MJzDye1XWxpCPq9wa1VlupDHMIPnEvh
         h1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2HKotNEampy38JcqS2jO5jcg6JRRDemA7j3BNjJy3o=;
        b=V8O/a+rbU1ZeBLZAkCmntT3S0yB39gJBwQqHVs7pfBYFdKvf2CHXEs6KUVwRqXsz+s
         XK3leIfrwbikw0zMdKOTlfCh5i+89WM0Pit2CeBBn3bFvOLXdf436bLPDZRme7pD3rgM
         rh57fhooOz4dS9iFdUQTZRgdU1Q1M5nBKlvivFNX3MgG/AT8m4E6em3L8f4uDdK3FSc6
         8++z+7EYGZl2mEc5/83kkK8D+ZT6Okf4oHeIv9elsjFW4Rez6uxHLr7UTeRJU2IG8JTk
         Vrc3YO/MHKAAzomMdnOyGzIhXPD9uMngR+TDDutDhmuHAXa+sdKjd1zOVdeNOCLcjJ2H
         mSww==
X-Gm-Message-State: AKS2vOzuZEzd47bkuUW09mSYOqK/7SGdg+FVAFoAEuBrx8jOudm7FN/Q
        lSSVIP4YlMLktw==
X-Received: by 10.28.23.4 with SMTP id 4mr4536711wmx.119.1497547913665;
        Thu, 15 Jun 2017 10:31:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:3417:1500:9940:452e:1376:fee0? ([2001:a61:3417:1500:9940:452e:1376:fee0])
        by smtp.googlemail.com with ESMTPSA id 201sm732842wmr.4.2017.06.15.10.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 10:31:52 -0700 (PDT)
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
 <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
 <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
 <CACBZZX42JcqFAsWgi0bSuRv5CC8hiUF1Ahnx3nJL=LyHkk03Cg@mail.gmail.com>
 <xmqqk24d2oco.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <6e0de364-97a4-a2c1-eaea-8e9931cce6b5@gmail.com>
Date:   Thu, 15 Jun 2017 19:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqk24d2oco.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 18:43 schrieb Junio C Hamano:
> Another thing that may regress that you did not mention is that we
> would lose a convenient way to _count_ proposed changes coming via
> submitGit (i.e. you can simply go to the pull-request page), so that
> the number can be compared with the number of proposed changes
> directly made on the mailing list, which would be a good way to
> gauge how submitGit service is helping our community.  But even for
> that, you'd need to go to the list to find the denominator
> (i.e. total number of changes proposed), and by the time you do
> that, counting the numerator (i.e. those come via submitGit) by
> finding the telltale sign submitGit leaves in its output among these
> denominator messages should be trivial.

This numbers can be aquired quite easily if submitGit adds a defined
trailer to the converted commit message like this:

	Signed-off-by: Foo Bar <foo@bar>
	Submit-git-id: url-or-id-of-pr

