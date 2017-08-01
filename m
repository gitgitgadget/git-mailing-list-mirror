Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31D92047F
	for <e@80x24.org>; Tue,  1 Aug 2017 16:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdHAQA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 12:00:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34703 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdHAQAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 12:00:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id y192so3293213pgd.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Q2Pxkkw8fEuPd8C4yGu6vlkZVl33cHI0kG+SvOMDbU0=;
        b=qEXPGN8L2wC16jK8eJLFGysWYQu0Op2vaGwCqC4x23khWO/2lf+cuqCLU3v52h36C4
         kq8v+94+3VFuvV+9TV5ytjNPJeb0/zWIj0nPlMuAzkSALcge9SC+lF18sv8XMuYwknt6
         PSo9GYYjU6FTvQccWBKzds4cMASOwmi37X79vxfUznVWoe3GFl4szZMoo9n50PZ+rTKj
         RLl7eb79CEkj0VhYGCQpq5yHttbbWNFXpYeCSpjwCQJcB2qX9mw42kCkWEv7YPXAs8Cf
         mfVy2Fagp+5FxjgomSFJt9GMtwweHfTCRavknq4S1NHUrh07DbbhiUDeEhmdcJNTEOAQ
         0fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Q2Pxkkw8fEuPd8C4yGu6vlkZVl33cHI0kG+SvOMDbU0=;
        b=SLz/ELbBedBzsFTxfKUdeameUgjxVTiTTywhQMI/uHxBZoy7Y6hLRq4QnBZ7h+YKHD
         Ad3d0opQ37mRdBgrUOaXY/pw83Ur7v5frUa9NQqFV9OlN9NZdT3PuOo7id+VqjbeqXPo
         7lLfUFUvHBQaWg0hoe4qrMOAXLJORZpiMaS6BVEjuE9xRJiD6f4xjixS7BKMYwYFt/KG
         3XKIBfynl9bVhNWKSh+US4bONezGIVpsuWTVjG0LjQb82uMvmwbglGAcdbxC3Za98uG9
         roZKOJ/FJvZFdQHMC94lgDtZJbJ1Wqi4QoagkwwN1X1H+cNTSp5y4JtYTPOja+mEqiBS
         QASA==
X-Gm-Message-State: AIVw110IDeGukbIgGg48JpDSjjWahgS7AbeUvHl7Edk/dN3gDYgkt55G
        Xe/1csWcFrp1TQ==
X-Received: by 10.84.232.6 with SMTP id h6mr22326238plk.173.1501603251964;
        Tue, 01 Aug 2017 09:00:51 -0700 (PDT)
Received: from unique-pc ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.googlemail.com with ESMTPSA id m190sm33424374pfb.102.2017.08.01.08.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 09:00:51 -0700 (PDT)
Message-ID: <1501603171.1671.8.camel@gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
         <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 01 Aug 2017 21:29:31 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-31 at 13:23 -0700, Stefan Beller wrote:
> On Sun, Jul 30, 2017 at 9:18 AM, Kaartic Sivaraam
> <kaarticsivaraam91196@gmail.com> wrote:
> > Replace the dashed version of a command with undashed
> > version and quote it.
> 
> I like it, but similar as below, we'd want to go for
> consistency.
> 
I assume you mean the consistency in quoting i.e., you're expecting the
patch to use (") instead of (') for quoting. Correct me, if I'm wrong.

> > 
> > Further, remove duplicated space character.
> 
> https://en.wikipedia.org/wiki/Sentence_spacing
> seems like a globally controversial thing. (I assumed
> it was some sort of local dialect before researching
> it properly)
> 
Man, I had no idea about people using two spaces after period.

> I personally do not mind one way or another regarding
> (double) spaces after a period, but I would think we'd
> strive for consistency throughout the project.
> 
Consistency is crucial. I'll just remove that part of the patch.

-- 
Kaartic
