Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9B31F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcHLQES (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:04:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33679 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcHLQEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:04:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so3696226wme.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:04:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dLtG5KmIbf8IHknedkUhbKY/zkZnaZ3hJOirmA8MDHg=;
        b=jzT59q1TTU+JQdqqrf/uD/Lt3PC+cPt+p9OrYVBR/WoojoWk6wJL/9NeA/K4sip6So
         o+Bv/y+iDtI/02/V4AvcJHHoOC5h5jJAz2YimZ64NQwbm9mrZz6u/WxAh6gX3o6IB6f7
         rJiGtIk/qUaciUjHbIa+0x441eeIkgs98u1v359Hs7RBkgcJZEBO+Pd2RaVnFoadGs1l
         vLfOqoGiUYnX0YrXyqFtLHJTfIPpcMZYib6egwyYaRrxSGIf40ylKLwN286vNGgGvA1v
         xLu18nzalCK4ZQA7Bqv01yawCbkSIi3JJ2S6z7hi+djwIzhgz8h1ae3nCy1+CxzXof8j
         2HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dLtG5KmIbf8IHknedkUhbKY/zkZnaZ3hJOirmA8MDHg=;
        b=GasZYc9TVuiW4SCpNE8sP/wUWR+uRGvycSBuk8gZsIblm5j6FqYZ9wojZ1Vrl+hTiR
         4YskNhCVJj84I2d019v2hlCElDl63j1cRSsvYx1c9hUQvnqArKzsgYzS/r96XvjcsmnT
         yqSJXqepEYUipxpKFTA2lTxXrzU4ym5MK4QlJcJUlYkP2IgKDTxEE4HdYQ0tnqo+BmjF
         Hs/MoLJketGipWftGBH9mvATIgwHPhUWKUAwvAxWzXU1nZD/GbduaefWeSf1a2xzK2eS
         3r0wgZJ3762swcRLNUYKUKFJZn0vokCo0zDxeHrZueqyGP+s2D0rlanybbbX9CYQAKuG
         uV8w==
X-Gm-Message-State: AEkoouuzKQLmRJMktqrndB+NAZC7AMU31OvStjKE5WYgNnTkM8EVXVVvBFLxGnyZ6OLgkQ==
X-Received: by 10.194.23.166 with SMTP id n6mr19813255wjf.36.1471017840005;
        Fri, 12 Aug 2016 09:04:00 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id va3sm8154668wjb.18.2016.08.12.09.03.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 09:03:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: `git stash --help` tries to pull up nonexistent file gitstack.html
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 12 Aug 2016 18:03:58 +0200
Cc:	Joseph Musser <me@jnm2.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A7A176B0-08CE-4D92-9756-51A59DF3B9D7@gmail.com>
References: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com> <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Aug 2016, at 17:48, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Joseph Musser <me@jnm2.com> writes:
> 
>> Looks like a simple typo.
> 
> Unfortunately this does not reproduce to me (built from source on
> Ubuntu Linux).

I tried it with the latest released version on Windows and OSX (2.9.2)
and was not able to reproduce it, too.

- Lars
