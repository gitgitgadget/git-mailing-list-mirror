Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A721F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbcHZMAq (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 08:00:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38434 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcHZMAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 08:00:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id o80so115800766wme.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BTd63uneNEfHSOiLcicsAr8qf1B7BRMYB8cSKaeHxQE=;
        b=pIgemSzVNYD+Hhgrpg/WeCT8Sc/bveRhtg5dgVJluvloJwBgdbbU7c+Wb2A2kRrQKC
         dJeEt9mR3V+XdivXcqCM30J+DmEkZGgQbJJro01+QidU6CoMGQqb/eGh1e9xtcNurPtb
         t9dSk2D/UzgPdlN8SM+0LAuVctd+9mCrQYB+LHEamooLbubRpb+VA7UZhAi4aGyNLCXN
         ZlBHyoWJyQKEeYQZMHsNXz0SIJgF0MZ4lUN906Ujd1VkQkZ46cfd708UZlh9QPSGh9Ha
         FrLKAUfzuL4ZZnWJx4xwFGxNfAfKgTCsTjwRmAc3YegJsDJhv16/7iUND6xKKxJajQxg
         hnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BTd63uneNEfHSOiLcicsAr8qf1B7BRMYB8cSKaeHxQE=;
        b=UWii7auxqghAi1XjgeOXetT5ZH9neFI7gmIm5caU9EQ6r6TM9c/A9XLAwmrbLF7cOe
         whhKF+55Vbm0h0efiFEsQIwXfniLdvr2LAKlcERjE26vMsr+GlQNKWGTDmw6un4N6g2H
         EjTRRormOQy4veKrzjYoyOW6Si3sQhjv5PMsfTBBbNalC0AtMN3jHrslxqRdxVpNi/YW
         vAbwYmieqMI3iEVyl3xapVC3eTijvnE6FMTVrJepTcwnz10lRunSZ1jUnkIncfvjQLk2
         2JIxuTSsWS9BS/kl9t2jLG4t/ZDH4HFcetNSpQmRbstgTA1THkBhEZ1Q9kdmKyIYUdjQ
         5fkg==
X-Gm-Message-State: AE9vXwNnkC65rJH3AeJ1uVHe/sSSEuHfwcjKt/Wph1sJJeoUFutdQXmvwvkdaiGH6j9Scg==
X-Received: by 10.28.48.71 with SMTP id w68mr3720246wmw.4.1472212375293;
        Fri, 26 Aug 2016 04:52:55 -0700 (PDT)
Received: from [192.168.1.26] (elj39.neoplus.adsl.tpnet.pl. [83.21.203.39])
        by smtp.googlemail.com with ESMTPSA id jv9sm19681314wjb.45.2016.08.26.04.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 04:52:54 -0700 (PDT)
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     Eric Wong <e@80x24.org>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <20160826061500.GA22213@dcvr>
Cc:     git@vger.kernel.org, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <6d171c23-65f6-5f67-7d80-051f2dfe8678@gmail.com>
Date:   Fri, 26 Aug 2016 13:52:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160826061500.GA22213@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 26.08.2016 o 08:15, Eric Wong pisze:

> Not directly-related to the survey questions, but can you ensure
> it's accessible to folks without JavaScript/graphics, and
> perhaps also ensure it is on a host that is Tor-friendly?

I plan on using Survs.com (where we have Premium account for free,
thanks to Survs admins).  It has good online analysis tools, allows
to download results in easy parseable format[1], and has support
for multiple channels.

[1]: https://github.com/jnareb/GitSurvey-scripts


It is possible to have a channel without JavaScript and without
cookies (anonymous), at the cost of having to fill the survey
in one go (without cookies and JavaScript you cannot go back
to fill more questions, or change your mind about answers).
The main page of survey would have a link to JavaScript-free
version, and all announcements (by me) would include it.

There would be no graphics that are not purely optional
(decorative); probably there would be just a logo.

I'm not sure how Tor-friendly is this host.
 
> Graphics setups often require non-Free firmware or drivers for
> acceptable performance; and there are also visually-impaired
> users who will need screen readers or Braille.

A question: would it be better to have the whole survey one one
large page, or have it split into pages (with fever questions
per page)?


P.S. With from 3k to 11k responses (I hope for at least 5k)
Git User's Survey is outside of the free tier of most if not
all web survey sites.  I guess I could cobble something together
out of Google Forms, but we would loose online analysis (and
probably some of data that Survs.com makes available in download).

Best regards,
-- 
Jakub Narębski
