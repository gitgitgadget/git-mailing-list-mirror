Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C275B208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 13:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdHaNfX (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 09:35:23 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34489 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdHaNfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 09:35:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id l87so2018961pfj.1
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=epJQugluPqEKGW3z+U/+DhFBntnJhjNTo8LU6Ye8iuQ=;
        b=G41HdElQ8EqCC/5MJmBaEPAItJ/FUWT+ftw+N+nzk7DUtqhLllq3aVzwvcq0P4i8aI
         e+FcdyQAYP6tKhsnxvA1kRSwNPR6z4FJRCefYb3UEGeKO5k07P6LE57NnvAjk1uQvt7f
         zq0DteUmr707y+mwg22FacDcl5Wz62GKTXItGKNVZPpuc+ZwbV93W/PDogVuQQOwxqry
         Xn/Jdvo1nYy+u4WLAbQ9Ol8LylDqLKpYSIfOVpHk5APMXkiNtqA+mt0wUfrOjxTLajYd
         LkBL1l1AUfBpSY7/u9XwDf3scZpY3pW1H/1AnPjOpnnjmx0CqRHoY1tc6IxPrbzo3Vum
         3xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=epJQugluPqEKGW3z+U/+DhFBntnJhjNTo8LU6Ye8iuQ=;
        b=gUirsPAT4OuQFeEfNga25w7Y5+0+9AoWLDh3gGtzC6KFUEod4uonNChYveXQn9/k4k
         HeS1jRub5cu01OB3UIKJgGNC5ZcR7yrETqWSwA4P7PWIsmPxELA5XOpbpG7E5ijPHyHw
         128Buid5V5s8Tq8dMwdJM4fChKWgo1nl+KRNgcU7PwnfRuw2WhB6hvj/yoWMMitdi+7h
         zEWcE1kKm+VoQeFfL8MgDSqwxilTN7RL/7KO/TL6QOtfsuR0wrWh5JyjV3HXrtuYLAy6
         +2CjMRRoxZgiUZOBduvfIGrmBi1SUGkO/36/fUe/bDBXuyyvItPOT95SLE64uatwrGIq
         voKQ==
X-Gm-Message-State: AHYfb5jHaPJwEd/oW+XDBvYgmNextvlJhRBj3qnugWSwjJRCHNzywubW
        SgUdEnzhokUQrw==
X-Google-Smtp-Source: ADKCNb57hdfD4j4ddbsZOZuy+F0VbLsYTRTxif9o3kfyaCnPD/hYJUV0H6Err2lieLUy08mwVYt4iw==
X-Received: by 10.98.59.11 with SMTP id i11mr2276396pfa.237.1504186521826;
        Thu, 31 Aug 2017 06:35:21 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id u31sm3372949pgn.72.2017.08.31.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Aug 2017 06:35:21 -0700 (PDT)
Message-ID: <1504186577.1826.9.camel@gmail.com>
Subject: Re: [PATCH v2/RFC] commit: change the meaning of an empty commit
 message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqo9r4vhv0.fsf@gitster.mtv.corp.google.com>
References: <1500107583.1850.4.camel@gmail.com>
         <20170821140528.7212-1-kaarticsivaraam91196@gmail.com>
         <xmqqo9r4vhv0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 31 Aug 2017 19:06:17 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-08-24 at 13:19 -0700, Junio C Hamano wrote:
> 
> The latter is easier for me as we do not have to worry about 
> breaking people's scripts and tools used in
> their established workflows at all.
> 

In that case, how about doing something similar to what was done to
'set-upstream' option of branch? We could print a warning notice when
the commit message is found to be empty due to the presence of a sign-
off line. As usual we could stop warning and stop identifying log
messages consisting only signed-off lines as empty after a few years of
doing that.

Note: I have no idea how good an idea this is. Let me know if it's a
bad one.

-- 
Kaartic
