Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B221FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164185AbdD1ImX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:42:23 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35384 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035458AbdD1ImN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:42:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id w64so36226715wma.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sggKJQjZovt95HJsufAGFaJlB17LcB+LKXqnbVd3lSU=;
        b=fT1VNzTrMMmAEd0vQHGUQAIgmPTyCufgXfhrh3fscqQ0LTgv04/0UnhXWwweFi9tfd
         YT9+78LHTBLBN72B5H7PB7Jbb8f2uv3aw7oS5dYNNtV0778ah3N/WmUlrzIE1bSU0/V3
         xqR9x5ZJOTRI4nRo732ITVWZDtUiaEMeEaBTfwLGE32GRIGd6Q3eAFeO92HKr+77QJ6B
         To5nakQuEHBEWGGkEo2c6pZrGRjmRe+HRaW5UCGK2rjTy7GoL3STPAlAmRTfQM40vDyX
         7H4kogfDZGMNBOpyvSBtsHmq6m3og7ur6U5/tfqscc3DntviiDCq+v2p9LKN6FhefiWY
         4TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sggKJQjZovt95HJsufAGFaJlB17LcB+LKXqnbVd3lSU=;
        b=CiCXRphBALeD1xp7xprmsNa3j/CZtO3v9aewtEt1xmcAjc4EPWn+KMGvsSSXCd7VU0
         WuG3jnCEmTxbgip6X1DTcONc6al+zZC6Zl5I3tVTjoQ0VS8Vq99PCuhNT9KWHhQGuwZz
         s+7OGESvC5GtSzl0au4jhmq4y16ZwMT3LGOBPSqIhq/CzmJSQPBlPWj/VqKUphT2kCMx
         0BW2EIt6eAiahXeKHvPQlW3EKSa11ZDY3WF/HCiAlXiy9ljSEhEI09YPKjJZLSk125H6
         Pwpgcv8QypqSJxlE12+WTrVxOnAIcqOrHtNvZnyT4sHzD2s9eMtg+Bl+iDVKXDQkLSIJ
         N2Ng==
X-Gm-Message-State: AN3rC/4+CH3ay9SSD0kwylc9jWiI2WMb5da0C8WSHFulsV/zzlTV2nLE
        gtURNvNOPVNlfgdRagI=
X-Received: by 10.80.195.24 with SMTP id a24mr8223613edb.44.1493368931940;
        Fri, 28 Apr 2017 01:42:11 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b30sm2636597edd.19.2017.04.28.01.42.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 01:42:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170425100155.zvfxyvd3egw463xe@sigill.intra.peff.net>
Date:   Fri, 28 Apr 2017 10:42:10 +0200
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <73F100B8-776A-4FF8-B23B-8DF413AB3288@gmail.com>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com> <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com> <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com> <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net> <054E67A2-56B0-4C91-89F5-F33E8C00ED61@gmail.com> <20170425100155.zvfxyvd3egw463xe@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Apr 2017, at 12:01, Jeff King <peff@peff.net> wrote:
> 
> On Tue, Apr 25, 2017 at 10:51:20AM +0200, Lars Schneider wrote:
> 
>>>> Off topic, is it possible to receive mail notifications from Travis
>>>> when a fault is found in either 'pu', 'next' or 'master'? I know how
>>>> to do it in Jenkins, but I'm not familiar with Travis and there's no
>>>> obvious button from the web page..
>>> 
>>> I looked into this a bit for my personal builds. Notification config has
>>> to go into the .travis.yml file[1].  So I think the best we could do is
>>> send a notification email to some mailing list, and then let people
>>> subscribe to that (or it could go to git@vger; I don't know how noisy it
>>> would be).
>> 
>> A separate mailing list sounds like a very good idea to me!
>> Maybe "git-builds@vger.kernel.org" or something?
>> What would it take to set something up like this?
> 
> I suspect that emailing the vger admins is the right place (or that they
> can point us in the right direction, or tell us to get lost). The best
> address is probably postmaster@vger.kernel.org.
> 
> (I resisted just cc-ing them here to see if other people had opinions on
> just sending the output to the regular list).

OK, I'll send them an email. I just realized a strong reason for a
separate mailing list: I haven't found a knob to make TravisCI
send plain text emails.

- Lars
