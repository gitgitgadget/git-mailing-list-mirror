Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D09120401
	for <e@80x24.org>; Thu, 15 Jun 2017 15:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbdFOPyp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 11:54:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35588 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOPyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 11:54:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so2209258pfs.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qgSG4eBm7d1PyRZyi4AcijEc0fUVTxnGAoPy5AxRgUI=;
        b=aRq3LclCFTJTu1vlJUA/KBvBX2gu1paxRQhUw6TnNbvD7fAk/Fa4qoTZt1gSK4B0/g
         OeMDr3vtz+yC7G0XwQt+KLMXgrDmtUr3xmXm9vANWaRp5+dgACmC6lyl+YocljFtb3wx
         WD73mhHXKJdO/Klcn5Iktdb6gUen3fsWinq89rN59jrdETKjlcCsRfUdaPZR09lil3/G
         4W2jTG+pAeIAY7d11+1LKAn5ZxtUhHCdVxpEV0imjD40gBA0CQ4ebcrJ8+sRCJPqubuP
         jn+kpGLH9XUO/PGEasEcSXLgqUMaeodMMej+pKKT2Yc2KyiAJY6P6GdbnQEkW3jVf9WA
         ++5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qgSG4eBm7d1PyRZyi4AcijEc0fUVTxnGAoPy5AxRgUI=;
        b=J8LokQulLTgW6o1E7td4xCRRoDcEOknE8Mbnn7BstX6qXkWc9HE0yXEn7BkkDaVcZf
         4U1KUdfJxRWWFeGRu0Focb/6SEyVFb22ZaR+7hFkyalaFL++Ey5xTlI1ZG0y8D5keH6p
         6xtXIhtepZE/+ZMLU9hc5Hn16enGmg5whtILGTcGIOLFgTJT/dEpTHgVgX+HYe7E+Nkf
         KNkWWgOubRhmTXy+Gpc7JJAvp6dt9ENvzxlaWqvutyZLSpi2o81QV7ds73ItMpnvwvBE
         Tm66Wmjw8ewG4D/tItzkOl6ap4FE61bqzUO+ZvXcqcf2xsCkZW3QouX5KVR7smp2Ky5j
         CRyQ==
X-Gm-Message-State: AKS2vOzJUAicYGdfctHBy0alhJiGgEJt8GJRiPkDpSw+wPN/mnlFRaDE
        HZaziyD3LkiecQ==
X-Received: by 10.84.208.236 with SMTP id c41mr6840665plj.95.1497542083033;
        Thu, 15 Jun 2017 08:54:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id 186sm1088795pfv.15.2017.06.15.08.54.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 08:54:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2017, #04; Tue, 13)
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
        <20170614005247.GT133952@aiede.mtv.corp.google.com>
Date:   Thu, 15 Jun 2017 08:54:41 -0700
In-Reply-To: <20170614005247.GT133952@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 13 Jun 2017 17:52:47 -0700")
Message-ID: <xmqqo9tp2qm6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  It is not known if a simple "yes/no" is sufficient in the longer
>>  term, and what should happen when --recurse-submodules option starts
>>  taking "recurse into them how?" parameter, though.
>
> Any pointers for where this has been discussed, if anywhere (e.g. was

If this were discussed, then the answer to the question we may know
by now ;-)  I do not think anybody gave a serious thought to convince
the public why a boolean is enough, hence this comment.

>> * bw/config-h (2017-06-13) 4 commits
>>  - config: don't implicitly use gitdir
>>  - config: don't include config.h by default
>>  - config: remove git_config_iter
>>  - config: create config.h
>>
>>  Code clean-up.
>
> Patches 1-3 are good to go IMHO.
>
> Patch 4 in pu is marked with my Reviewed-by.  I think it's getting
> there but not there yet.  Did some script pull the tag from my reply
> to the cover letter?

No, nothing that elaborate.  

I go through each message in Gnus newsreader and feed the article to
a shell command, e.g. "Meta/add-by -r jrnieder@ | git am -s3c".  The
UI remembers the last command I used when I choose to feed the next
article to a shell command, and after running it to first three, I
forgot to remove the 'add-by' bit from the command line for the fourth
one.

