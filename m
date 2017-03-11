Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1D4201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbdCKUnp (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 15:43:45 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33209 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbdCKUno (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 15:43:44 -0500
Received: by mail-lf0-f48.google.com with SMTP id a6so51862007lfa.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=mnZuyHUvr2Oemm3MsaGlGTnILPpb+ssIf1a1pJ4Mu0c=;
        b=V9urDkuK/LAX+iQozu2JIfXcAL+MHbNq6nM7zqgHXp22ToXRlfpON9z2cQ1RMMNQHf
         fuHkff3Q9Y1BaQbVYZ3JqTFrY8n5om62Ejxr0nBLOquY070g78PvyG00aj9ZcNJ4FIVf
         1eP1stPP6UxSMcmPAK7H/fSNdYhaGUauiED6cRNWx4oRgLT8Mb50vq5qxy9xZcJQTTCO
         nsCs4OqAop/kFGvSFo3umodd/4o11vcfTfS92/sopxXLxC6M5nTAj4utw+brDaXJSCUl
         s5KxDNzyU3/wA0soeEikkksgzS83y0J+I0I8LHuOEZw/VBTGGuXFJzsJFJcgcal+cUWT
         rlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=mnZuyHUvr2Oemm3MsaGlGTnILPpb+ssIf1a1pJ4Mu0c=;
        b=qjKZyYHLxTuAsqb2OWlxETFuKgbrDqnkUNiEAf49gleUucjN1Shpugopy36JejAw+n
         sMj1WPB2VxzDkTSqrTtzeVS2xORJcdcayVEoR5yXhrYPSIO5TaGWcql1RUe9VhaMCO71
         M77OtxIx7vWHilg5rbaXm6LUF2EBQcxfCdJOqQnh/x4HZszJprXBakxtTIGlk506GqRn
         ER/FMpY1eSJ7D3r4W96W8uNwtNomj7xF/KgSxlusXkJHPwllXdb6EqlruKgWzb0IGgof
         qaIMLEEQGTJUTvcymCEuvg5/RviJEwEs9pj8/FJAVpjVJqIqzdvtIAFszkaRzYwsOrj6
         fwfw==
X-Gm-Message-State: AMke39l7uAqvV+VapAaSW2P3LId1CkmyyNwy9h5SppzK7TwQJqr/LFobJ8TItY94wbHXsA==
X-Received: by 10.25.202.66 with SMTP id h2mr6415466lfj.33.1489265021951;
        Sat, 11 Mar 2017 12:43:41 -0800 (PST)
Received: from [192.168.1.26] (epn242.neoplus.adsl.tpnet.pl. [83.20.55.242])
        by smtp.googlemail.com with ESMTPSA id y6sm2656586ljd.55.2017.03.11.12.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Mar 2017 12:43:40 -0800 (PST)
Subject: Re: git-push branch confusion caused by user mistake
To:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
References: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4a60d43b-b4b2-fb8d-b139-bbbdef564187@gmail.com>
Date:   Sat, 11 Mar 2017 21:43:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 10.03.2017 o 22:44, Phil Hord pisze:
> This week a user accidentally did this:
> 
>     $ git push origin origin/master
>     Total 0 (delta 0), reused 0 (delta 0)
>     To parent.git
>      * [new branch]      origin/master -> origin/master
> 
> He saw his mistake when the "new branch" message appeared, but he was
> confused about how to fix it and worried he broke something.

It is nowadays very easy to delete accidentally created remote branch
with

      $ git push origin --delete origin/master
 
> It seems reasonable that git expanded the original args into this one:
> 
>     git push origin refs/remotes/origin/master
> 
> However, since the dest ref was not provided, it was assumed to be the
> same as the source ref, so it worked as if he typed this:
> 
>     git push origin refs/remotes/origin/master:refs/remotes/origin/master

This rule depends on push.default setting, but it is a very simple
rule.  Simple is good.  DWIM is usually not worth it, unless program
can guess what you meant, and what you meant is always the same.

> I think git should be smarter about deducing the dest ref from the
> source ref if the source ref is in refs/remotes, but I'm not sure how
> far to take it.  It feels like we should translate refspecs something
> like this for push:
> 
>     origin/master
>         => refs/remotes/origin/master:refs/heads/master
[...]

Such push doesn't make sense (unless you have a quite unusual situation).

Note that 'origin/master', that is 'refs/remotes/origin/master' is a
remote-tracking branch, that is a ref that is meant to track position
of the 'master' branch ('refs/heads/master') in the 'origin' remote.
Thus it should always be the same as 'master' in 'origin', or be behind
if you didn't fetch.

> Does this seem reasonable?  I can try to work up a patch if so.

Thus I don't think such complication is reasonable.

-- 
Jakub Narębski
 

