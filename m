Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A5E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJDATM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:19:12 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37774 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDATL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:19:11 -0400
Received: by mail-pf1-f169.google.com with SMTP id j23-v6so2022420pfi.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kGcOkdOEwmTAogoaBCHTVnnCLF3EKLk7DYAfOvIqNiE=;
        b=OxV6kjUEoHiWDMCfOd0EyrRVRkgCFNHsVYkUF0Zsl2gEMgIxTAuZSJh+4YjkD2hNgk
         48UVzIBTmaSkD/F9Rrc72QbvAuanvm4wAP03nld/zcZeVDfC39xozbpSa3jRo+tssoVy
         kCwOeXfxp9KGYEgwWe8JORKwKEmOG2flL9DF5TawCO0yEnj5kQJPDtKbIC576ATclnIp
         +/UOuFJ68m2vVEkP6FqgwLPe2wNVWNa6J8yItFRAPdV/z2+ChEQDvDN1ItkaB50xfjbg
         U7FVunE/tut6fQqWqAKrdC69OWIt+4LZpR7AWaTS+kQlVECUiTRlkDYDhmMgOFNVnmFP
         fcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kGcOkdOEwmTAogoaBCHTVnnCLF3EKLk7DYAfOvIqNiE=;
        b=swkxcgU/RpKEBSHCiqituoO2PCFAf+iz4gE6oUqiZiqapnT0wRhtZMUXSKuSIpUdS7
         62Vi79ljW6nDHrBX92Oq/cLTlv3FVtxV4DYr0XbDXGcE8LOFKdL3TVhsWsHd8qrHMoYV
         2b4dMiSSi1ZUHZhsbthX/lY2oqrnpzErysH1g8iOV3Q2FG5Q2CllY3shpM3OXvDqM/bU
         DMg0nGhmiLp5jyWGS7GZYRPXi3SVXIlrEoliBcRcoBeIb2ZAyvs0l5vWW+mVA3FOMvhv
         Asa5aBTTC07+3o8pw/mGlJXUscBOe+QFyqrMSSGJUbxmYxiVI1OuqpFwM78t9rMaErVM
         G2tw==
X-Gm-Message-State: ABuFfohWAUOjS2o05a/xld6HLKGWClFq2VTquLNMptezQx4bFlDoAUAr
        n6EKY2MwX1HtaJnCQ1/kdCX5/MMn
X-Google-Smtp-Source: ACcGV62ieMoon26hnZuqUAbOTRrzAgSfcbdJRzgyiQBttq2vZQXcVXYGISPaNY4Ou/xx0RxiIKA+qA==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr2773814pfi.2.1538587790232;
        Wed, 03 Oct 2018 10:29:50 -0700 (PDT)
Received: from [192.168.2.4] ([171.233.129.129])
        by smtp.gmail.com with ESMTPSA id p75-v6sm3734826pfi.22.2018.10.03.10.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:29:49 -0700 (PDT)
Subject: Re: Git credentials not working
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <CAP8UFD3LEYd7RytZU_-wVcDosH+6VSdM2j3NUcnR0aQc8QfoQg@mail.gmail.com>
From:   Dimitri Kopriwa <d.kopriwa@gmail.com>
Message-ID: <d4f5551f-89d2-d63e-49da-dd80f22ea9ce@gmail.com>
Date:   Thu, 4 Oct 2018 00:29:46 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3LEYd7RytZU_-wVcDosH+6VSdM2j3NUcnR0aQc8QfoQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/3/18 11:03 PM, Christian Couder wrote:
> (removing git-security from CC)
>
> On Wed, Oct 3, 2018 at 4:09 PM Dimitri Kopriwa <d.kopriwa@gmail.com> wrote:
>
>> Git credentials in ~/.git-credentials and ~/.config/git/credentials are
>> being removed by git upon reading.
> https://git-scm.com/docs/git-credential says:
>
> "If the action is reject, git-credential will send the description to
> any configured credential helpers, which may erase any stored
> credential matching the description."
>
> So maybe this is expected.
I am using this script to create my credential file, how am I supposed 
to do in a non tty environment? Is there a prefered way?
>
> Another possibility is that your .gitlab-ci.yml might launch scripts
> writing into those files, like the before_script.sh script that is
> described on:
>
> https://stackoverflow.com/questions/50553049/is-it-possible-to-do-a-git-push-within-a-gitlab-ci-without-ssh
>
> Could you also check which credential helper and which options are
> used? For example with commands like:
>
> $ git config -l --show-origin | grep -i cred
> $ git config -l --show-origin | grep -i http
> $ git config -l --show-origin | grep -i askpass
> $ env | grep -i askpass
  * branch            HEAD       -> FETCH_HEAD
17:15:36.175966 run-command.c:637       trace: run_command: git gc --auto
17:15:36.177688 git.c:415               trace: built-in: git gc --auto
[32;1m$ git config -l --show-origin | grep -i cred[0;m
17:15:36.180191 git.c:415               trace: built-in: git config -l 
--show-origin
file:/root/.gitconfig    credential.helper=store
file:.git/config    credential.helper=store
[32;1m$ git config -l --show-origin | grep -i http[0;m
17:15:36.182768 git.c:415               trace: built-in: git config -l 
--show-origin
file:.git/config 
remote.origin.url=https://git.example.com/example/sample-project.git
[32;1m$ git config -l --show-origin | grep -i askpass || echo nothing 
to do[0;m
17:15:36.185306 git.c:415               trace: built-in: git config -l 
--show-origin
nothing to do
[32;1m$ env | grep -i askpass || echo nothing to do[0;m
nothing to do
