Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624961F461
	for <e@80x24.org>; Thu, 29 Aug 2019 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfH2P1s (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 11:27:48 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40790 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2P1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 11:27:48 -0400
Received: by mail-wr1-f44.google.com with SMTP id c3so3877390wrd.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zzxjPFCd0xoI4uKPdamoONMiAmbHTDk816fChQ+8SVk=;
        b=sc4kPk7czt4j77c3bmRlw7aC9Dl8AdzmO2+XBFX12+Y36wT519Di8VmzUWSh1+NG5K
         Yk7qSZTd0rJSebrdxwfOyWEBgqyISXf7PvC5atkMIZKeTbvml8ugSIPVVpjzUXOFpoV4
         Ar9tUiSfi7avxqM6aMBkxwhGnpmkX/jeW+ARM1e+SKzliEovsNYAD+8XShsLVWI3o1fx
         nSFNXeaB2Toc7HfbirZF7rs9UbvZwzF8x70M6RTYPGvJwmx9DmevC46MUUpYxs34CXhe
         VTMjkeiTubNxP0ILsEeTWaLB7WU3QWQG3Ftctt5JliEtY1688DNQpN5+9gfOzOEvXI0o
         /PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzxjPFCd0xoI4uKPdamoONMiAmbHTDk816fChQ+8SVk=;
        b=d3Ga7//B8oVMdMj0ERJn5YJ9OA9MIbLmikJbnoUi9bQ4ialfDeLDCothO/A1bg7wNd
         KOY8ErTjIf/R45QOx/DsQ7FCnR/88W+PyL40IhL+0DSkxMFDbX9ea7/vGd3YT6so4abh
         O0ZzUNjAR9pilcRQVv1DUqSV/gKzTl6QYzTp3duGXGum7Rmpmng6ntl3RAUWy0lZgS37
         L3s1qqxRsVXEDF2dRUm4E+ucy9Quwt3F0Q7kFTxEVOScAsRb1Dbp6dfHdXi/j9jP4qwt
         7JIJA95vdc359Q1bcJjTHi7/WSokiP3BRKFvIU3405lBI8tFBPVyTmHPKOHaMmHXw2fw
         iKGg==
X-Gm-Message-State: APjAAAUDTkEqhadUg4JxUdO6INo592AgHHMvnA4QnRniVTPWYR8TZ4jT
        jdzLelgLAsZS1eiQN3nbGCko8BuM
X-Google-Smtp-Source: APXvYqzdMJJ7d5sU2KMHzfSl0z97Q8i9E4PVhEQs4ySJg3O/Kp9b39OfpAgzgFzOgYDOiH6tzBblxA==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr11509488wrp.189.1567092465511;
        Thu, 29 Aug 2019 08:27:45 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id b15sm4295454wmb.28.2019.08.29.08.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:27:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: error: cannot cherry-pick during a revert
To:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
References: <20190828232515.bvghqlwe3i7sie7n@glandium.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <be3f951c-467d-68aa-592a-bdf77646fdbb@gmail.com>
Date:   Thu, 29 Aug 2019 16:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828232515.bvghqlwe3i7sie7n@glandium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike

On 29/08/2019 00:25, Mike Hommey wrote:
> Hi,
> 
> This just happened to me while cherry-pick'ing:
> 
> $ git cherry-pick HEAD@{1}
> error: could not apply 614fe5e629b84... try
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> Recorded preimage for 'taskcluster/ci/build/linux.yml'
> 
> (... this is where I fix my conflict ...)
> 
> $ git add -u
> $ git cherry-pick --continue
> error: cannot cherry-pick during a revert.
> fatal: cherry-pick failed

Oh dear that's not good

> So apparently, cherry-pick thinks it was doing a revert when it hit a
> conflict?
> 
> (This is with git 2.23)

I wondered if this was due to some of the recent changes adding --skip 
to cherry-pick and revert but I can't see anything obvious at the 
moment. To get that error the sequencer has loaded a todo file (in 
read_populate_todo()) which starts with a revert command. Is it possible 
you were reverting a sequence of commits before you ran the cherry-pick? 
(a single pick or revert does not create a todo list). It could be that 
there was an old todo list left over from a while ago - historically the 
sequencer hasn't been all that good at cleaning up after itself if the 
user committed the final pick or revert with 'git commit' and forgot to 
run 'cherry-pick/revert --continue' afterwards.

Best Wishes

Phillip

> Mike
> 
