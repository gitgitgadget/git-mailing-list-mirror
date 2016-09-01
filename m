Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31B01F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934040AbcIAV22 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:28:28 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38524 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932849AbcIAV2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:28:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id 1so3323132wmz.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbYZei86Ip0teBUoz4QI9Ms+Hl6etJTJat49RfXYShQ=;
        b=Vud4V/lmjhfEdI6gOGGqLPZEpz/rPy6/WlET6Etyy1JXG6v/MkGXVbwxwgiK8eWZNr
         rxj8UxUlwjYe73N4mfbQ8++07SggCqpzERxsLUvVmCWhjfQlSg57vzC55fxxlaaInG73
         TNGJlISu8GcA0MAqvbWCydss40jJhirp1XnFWIUb5vVcTIQsQ7cuPj4YahCQ4XDFB4g9
         6hpyh9PGBGVxsEFiqIbdp40sWubOpBeeCF0AJnMYAitQDBbJkRMScv7TkgcmrRZqxrYC
         uGo/lQ9N3NLHJkpdzVMw5cxQZByEp+YAqf/lakvWCCKo4VCs1Vg8PDUuBCZ4O8pgihyN
         h33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbYZei86Ip0teBUoz4QI9Ms+Hl6etJTJat49RfXYShQ=;
        b=R2ivYteHYcQXWujysdE8rcK4NC7H2VQPBh5wcPPw/icCHQYwudvNy8cN8U7MrZMJlm
         SSBttTToKaPUeKMPP5FKY8tOPx66dUeq6xp6W/gKTD1KXS4VQn3u7BMz7IzBjX7Sj/LT
         dZhl5FZt89QsZep+5/oTRasqfaTF0vN96iug5OHaj45LTxVrEInW/f6rL58Z/LfJtWpr
         JXb+SjW2y6CJndr1e2BAYwbhUATmjWiAQguLd7xVepmKz/0RDHBKbGxt3JBNzEeKu5ZO
         4ve+f/vFMbPTQGxxHiqm2SMnL8EtMCShMtVnuXmvWivUfOiVpSdDAs24A49OsbDj7Lr7
         M0dw==
X-Gm-Message-State: AE9vXwPXfLOBMQmV7zZyg3sUmbrVFlNAq4OO8orlh2/2KMwI5IkKAbirWBbA1zunI/EN3g==
X-Received: by 10.28.9.194 with SMTP id 185mr27384391wmj.37.1472762081022;
        Thu, 01 Sep 2016 13:34:41 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id x6sm6986953wjk.26.2016.09.01.13.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 13:34:40 -0700 (PDT)
Message-ID: <1472762079.4680.44.camel@kaarsemaker.net>
Subject: Re: [PATCH] make dist: allow using an installed version of git
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 01 Sep 2016 22:34:39 +0200
In-Reply-To: <xmqq4m5zy0qd.fsf@gitster.mtv.corp.google.com>
References: <20160827102929.GA11769@hurricane>
         <xmqq4m5zy0qd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On do, 2016-09-01 at 10:43 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > b1de9de2 back in 2005 ensured that we could create a tarball with 'make
> > dist' even if git wasn't installed yet. These days however, chances are
> > higher that a git version is available. Add a config.mak knob to allow
> > people to choose to use the installed version of git to create the
> > tarball and avoid the overhead of building git-archive.
> 
> Thanks, but not interested.

Pity. Would save me quite a bit of tarball build time.

> We do not know what vintage of "git" happens to be installed on the
> platform, but we know how "git archive" we ship with the source
> ought to behave.

That's why I didn't want to make it the default, but merely make it an
available option for saving some build time for people who know their
git is up-to-date enough.

D.
