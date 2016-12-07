Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D183D1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbcLGVYh (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:24:37 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36964 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbcLGVYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:24:34 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so187540691wmt.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BA8VgsNIzZk3U5vMTgQwEhae4ywPn4/G3wF1e7jwS7M=;
        b=U3nBSTXJVRZWVal33ek+tgvHci+oH+uzkJu4mBg6DVRNIW8nBIY90zlvlychL8RkaO
         ze4E36/3RSZrz9zkBfHzV5vWc1bUwobo/jJfwP6TmvMhw0joo17RKzsQNAmmFR2EPDAk
         PLcJe1FihbEzA6uMK+HNLKW8GbM0qdM6znVgIcwxZGgD2ENAWOJyE9niMI2PjN6JvVOP
         lcjX5EoWZk1qrP7ExMF5f18/aTC9U655bwxnUppo4xfK/o4GpnwF8ot+tgHxmrpix44z
         pCQrOLLS8XD0tyk09XCTt08y6daCasIO2kRF65UVjbtAruTHZJasBkdgrgChN0QZzrRo
         ex6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BA8VgsNIzZk3U5vMTgQwEhae4ywPn4/G3wF1e7jwS7M=;
        b=IcUWiUXZNUpbTJnil11qrlk94QLxgOY6VTfiYBrR3PnKUgsMdR2BFMExldklD3AcQb
         hYAKt52okfERKSCsDfVvXvjA1+iFNG3lfQ8J3+4kHeXitU3T2gs+Gsh4etIc6VAqlW27
         pHMKzLECtlyPgqeuUJXymQoj6keVZycUhT4Qw+uyn/LGAkjq6+T8s/gvISjIwvkkirll
         3xFVqh9WsOQy6haYEf0MaX+nLn5sgoP6GhHJrziQTX8y6H4GYdaPs6HkiwFklz48mO7X
         znhbgvannVrufGOlhN7lhJi88f7vAVstv4BdTFe6T3dR97lkjycPEf1s0eUbAMJhfz2Y
         2+cg==
X-Gm-Message-State: AKaTC02B01wJxHH3tjGnjyMsK/RaIulbpEKjVxy9Z6cRxgNqANbJwbpuxo86yAUcP1nxRQ==
X-Received: by 10.28.109.156 with SMTP id b28mr4544103wmi.116.1481145851272;
        Wed, 07 Dec 2016 13:24:11 -0800 (PST)
Received: from ?IPv6:2001:470:7bd6:1000::2? ([2001:470:7bd6:1000::2])
        by smtp.gmail.com with ESMTPSA id w7sm11643192wmd.24.2016.12.07.13.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 13:24:10 -0800 (PST)
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned
 submodules
To:     Stefan Beller <sbeller@google.com>
References: <20161207184248.6130-1-vi0oss@gmail.com>
 <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
From:   vi0oss <vi0oss@gmail.com>
Message-ID: <9493435c-16e5-d8af-9455-ec3f3cba390d@gmail.com>
Date:   Thu, 8 Dec 2016 00:24:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2016 11:09 PM, Stefan Beller wrote:
>> As submodule's alternate target does not end in .git/objects
>> (rather .git/modules/qqqqqq/objects), this alternate target
>> path restriction for in add_possible_reference_from_superproject
>> relates from "*.git/objects" to just */objects".
> I wonder if this check is too weak and we actually have to check for
> either .git/objects or modules/<name/possibly/having/slashes>/objects.
> When writing the referenced commit I assumed we'd need a stronger check
> to be safer and not add some random location as a possible alternate.
>
1. Do we really need to check that it is named ".git"? Although
"git clone --mirror --recursive" is not (directly) supported
now, user may create one bare repository with [remnants of]
submodules by converting reqular repository into bare one.
Why not take advantage of additional information available locally
in this case?

2. Is the check need to be strict because of we need to traverse
one directory level up? Normally this "/objects" part is added by
Git, so just one "../" seems to be OK. User can't specify "--reference
somerepo/.git/objects", a strange reference can appear only if user
manually creates alternates. Maybe better to document this case
instead of restricting the feature?

3. If nonetheless check for ".git/*/objects", then
a. What functions should be used in Git codebase for such checks?
b. Should we handle tricks like "smth/.git/../../objects" and so on?

4. Should we print (or print in verbose mode) each used alternate,
to inform operator what his or her new clone will depend on?

P.S. Actually I discovered the --recursive --reference feature when tried to
put reference to a mega-repo with all possible submodules added as remotes.
I expected --reference to just get though across all submodules, but it 
complained
to missing "/modules/..." instead (the check went though becase the 
repository
was named like "megarepo.git", so it did ended in ".git/objects").
