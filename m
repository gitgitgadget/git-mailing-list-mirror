Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4CF20226
	for <e@80x24.org>; Thu,  4 Aug 2016 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbcHDIDo (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 04:03:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33260 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbcHDIDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 04:03:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so41306961wme.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 01:03:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4m/B9BCmHoXUuVebVGEqdu9QYa3lFq6FkkVsbf8DVNk=;
        b=wMlJa4vmZEgePxXWe3DQtWZGz0CmrISyDO90TFPVTtUaa5e9Z8gBUz0hyyclBz0Civ
         9h+iiK7Cpi/hmG1REvskJdBxVqlsdmyRcWQO3dRMFI7X8qp35apYdjCuJxy7DK+k/+kS
         LFU+E5pHuuIZMeDQzc0piy+TTbnCY3b7QZ1z6f1q6SE/Ris9ZAq8W1tdERUraO7whFHK
         e2ceIyVPuxVzacrTx0a91qF8CZzf7D7TcxJyRBafQ1S8TWdY5IqRlqyxJzzSacD7GxpL
         eFifqjhMnrUnlTjCMcAacl3l8gaHl8R/X8nDj+ECUaTROK5K/tTLtpSM4zOBUe2jF2g5
         6pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4m/B9BCmHoXUuVebVGEqdu9QYa3lFq6FkkVsbf8DVNk=;
        b=cN5P9wcED987FmH2Ncc/AuJxJBaInrVo3oJrKmoMQVfAa+4lj/oB7whmN+B3BdG2a0
         ITfoe5XoJ7frPUPD/cjxBFL8uN3rDwtAJBkmcoq+aBWh5LW0r75H5rvaquP9PpbvqVM+
         kopuD1L7OJUEn5XKa+gz9+ASX3AofZgz+KwZY4DriVXvvP/y17S5AHbTPy2hXDUHJsCE
         2KYXlitWjoqWQQjx721g1eEVapzQe26xwK8VcmEdlGBSQfxEzFxEWHxZaX3CBprCgVIp
         fcwqAkWlwgOhlxJBqwabGMTsHEXa1Jz6QKkNuJg1SpVgtNAm9gtNZ47kIut+ELyBvq36
         fTtg==
X-Gm-Message-State: AEkoouvxFBTUcAYi6eKSG6oIb+D7OIWioNLaKds1sD1v3UjNSzaxa+pja+3r2j6DJb+/nQ==
X-Received: by 10.28.22.70 with SMTP id 67mr29870857wmw.52.1470297820756;
        Thu, 04 Aug 2016 01:03:40 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6740.dip0.t-ipconnect.de. [93.219.103.64])
        by smtp.gmail.com with ESMTPSA id n131sm2329254wmd.3.2016.08.04.01.03.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 01:03:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 4 Aug 2016 10:03:39 +0200
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com>
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>, john@keeping.me.uk
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> 
> * jk/push-force-with-lease-creation (2016-07-26) 3 commits
> - push: allow pushing new branches with --force-with-lease
> - push: add shorthand for --force-with-lease branch creation
> - Documentation/git-push: fix placeholder formatting
> 
> "git push --force-with-lease" already had enough logic to allow
> ensuring that such a push results in creation of a ref (i.e. the
> receiving end did not have another push from sideways that would be
> discarded by our force-pushing), but didn't expose this possibility
> to the users.  It does so now.
> 
> Will merge to 'next'.

t5533-push-cas.sh "16 - new branch already exists" seems to be broken 
for OSX on next. Git bisect indicates that "push: add shorthand for 
--force-with-lease branch creation" might be the culprit.

https://travis-ci.org/git/git/jobs/149614431
https://api.travis-ci.org/jobs/149614431/log.txt?deansi=true (non-JS)

- Lars
