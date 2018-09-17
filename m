Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6031F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeIRAE3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:04:29 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34624 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:04:29 -0400
Received: by mail-pl1-f170.google.com with SMTP id f6-v6so7836768plo.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=sKlk4NcF8NS0y6xaR3HktIpEv9CLPLPSYXd8VK2NLG8=;
        b=iJ5cilHajJsQTNtJUGSPbCh83lOkSHx4KcR+mD/mygMCtOr0yw1Aumi0sRODu5IuPG
         u5/aai9G5ErGws4n5UzTD4Mx8DKfyCozltwpyfzfTCUX7duIyi9RSh7LDKIQcFF4DGcm
         udVJOSZenQW60rIwG5i0jYsU7WLPueuMXepmqD4GPN5ud8kcRX8RqEMk6xQ12D91Y5pg
         O6njA2dXKZUeGwDL5le9zit3Y1SCmdxQ3CRIZJ6pVXguE1DFIcCPh5iYh8Yqjw/NddhC
         DVnsigarkWgwpb2gYjFH48H/ySbrkAlMf7CenV/2Qpll5G3WzqBnMncdo2HoWwEU7DIh
         69Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sKlk4NcF8NS0y6xaR3HktIpEv9CLPLPSYXd8VK2NLG8=;
        b=pCT6RByAJU5cjfrbuXmdF2VFBYTAKwBN3K7Qw6xogMUbh9VQoH8p6nIF55ZW+Rayp9
         xRvkvFla2T6zJjLTu/EdvWXXtwhzSujAWtGGqI3Et8vGb09VYW+Ok5Bwi+oBfkbTFhAJ
         ckJv5ySf7M12TEBM8Mu0ProCuPtZq0Vmx1WFxiEKXK9CAZVCS1qtdnKTPB9oNDj+Rbap
         24KErwa3WwJ8VeR4gr80LvKHs+EdZKZVhPZQI+J5pFDRdVrocoEZ+Cd4TqvoOr1Irzij
         LbWNVU4xG1AnX+S8gFpSAP35PVT29J59Kt2BbgfqwF2bcOzG8/jk0ode+ZM0KUhi9OlE
         EhYg==
X-Gm-Message-State: APzg51D4QPDuqOnyQpp51Pglg7L9Kulzo6+Rexm/lre2mKPWLsWeXzBQ
        sMb4Op3gy2Y1lqlpootE4Rs8DXcU
X-Google-Smtp-Source: ANB0VdZVHq5q28FRco+NNay9P4NEcRZ7cpeViZNuOSIDTAlNW9f97Qza3uvj+btj7pFBSFbTdso/hQ==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr26411145plz.49.1537209355351;
        Mon, 17 Sep 2018 11:35:55 -0700 (PDT)
Received: from [10.11.1.235] (173-11-86-161-SFBA.hfc.comcastbusiness.net. [173.11.86.161])
        by smtp.gmail.com with ESMTPSA id l79-v6sm22166422pfb.111.2018.09.17.11.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:35:54 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <43e8d5aa-5418-2e2d-2097-9e21e7a74825@gmail.com>
Date:   Mon, 17 Sep 2018 14:35:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2018 5:56 PM, Junio C Hamano wrote:
> * ds/format-commit-graph-docs (2018-08-21) 2 commits
>   - commit-graph.txt: improve formatting for asciidoc
>   - Docs: Add commit-graph tech docs to Makefile
>
>   Design docs for the commit-graph machinery is now made into HTML as
>   well as text.
>
>   Will discard.
>   I am inclined to drop these, as I do not see much clarity in HTML
>   output over the text source.  Opinions?

Discarding is fine. I originally created it because I thought we were 
supposed to mark all documents for HTML generation. You're right, the 
HTML doesn't add anything.

> * ds/commit-graph-with-grafts (2018-08-21) 8 commits
>   - commit-graph: close_commit_graph before shallow walk
>   - commit-graph: not compatible with uninitialized repo
>   - commit-graph: not compatible with grafts
>   - commit-graph: not compatible with replace objects
>   - test-repository: properly init repo
>   - commit-graph: update design document
>   - refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>   - refs.c: migrate internal ref iteration to pass thru repository argument
>
>   The recently introduced commit-graph auxiliary data is incompatible
>   with mechanisms such as replace & grafts that "breaks" immutable
>   nature of the object reference relationship.  Disable optimizations
>   based on its use (and updating existing commit-graph) when these
>   incompatible features are in use in the repository.
>
>   Replaced with a newer version.

I think this has been the same note for a few weeks now. What does it 
mean? Did I send a new version out that you haven't picked up?

Also, my "git log --topo-order" series was never picked up, but I see it 
has conflicts with 'next' now, so I'll rebase to resolve conflicts and 
send a v2.

Thanks,
-Stolee

