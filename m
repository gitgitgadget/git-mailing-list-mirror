Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2CC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiBLSun (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 13:50:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBLSun (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 13:50:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286426007A
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 10:50:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so11877867pjh.3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gvFGNQfbbH6+24B2H7W9t/ZaYRBfZDsnTYADFmvlHpM=;
        b=AvlYagmIQ5mKwi73yAWh9eMx30TkuIspunGoz7wDbWXIU8sAavx4CvTCiehhvmPgDH
         ng+MCVuStXqHO9lX3l/+tYs2K5u+fm3woOILMmUr27Kbzbb5K4NRAmo8dMx4RDV2PCBB
         JtW5dC2KOt3tGfEU6d7L+usdk1uM7lkcteCmLGaGXD7mMF13/Y/s1zDti0x+JpWx53aM
         JRKFyt5E22Az5AY83y5o2Sacin1Pd/Ncq5vhMDjREV6BG1I7OpkU950iULh/l312Doh5
         PQ9lDjoHfRC+FdclrVF1nrEB74it2iAISKwLKiaKLazE+A+pt9vbGasc+o6fJWPDP08/
         BXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvFGNQfbbH6+24B2H7W9t/ZaYRBfZDsnTYADFmvlHpM=;
        b=rY+1taOBnim3e7sdM/tM7Sxduitgz0ASvD3s5BaWPt1RHD+hhnOclJb/Aqy7SacOBA
         lruaf6F22yJdPXkrDJ4usYnK/pb9TkNrC4s2OZadaaxTtQHuuOYZTh7XyhH8nLYCvdzD
         NxkvEYCop2G1pVYkuZKsqMOt8hcX5oPnuOpACjQftvJY+zlf6OW95pA8x2IdTV9kTZZF
         ll8C6+dFIcGLh3SHeqcEwHEfiHdS3RjXvXnt8hXYcGcgT7yfQL1QCN6jNWEsse+bqREh
         TX7PQoubmArYSNDVDFwiQOqEMS1Av8JFwkA8KNpxWhLVWkccH/lnlx8c/eoj6Lt15AQN
         1UnA==
X-Gm-Message-State: AOAM530xczoUQOgLBSkXyyY8MrYwxUXtj1YCVojI0UsteiHh5ih9aqyk
        qRN1WxceINaQA0OQ0JIjySE0az0SbTM=
X-Google-Smtp-Source: ABdhPJzS44kw8stAzXev4TrLRNtJaFRMAuh2ZabvIIBRlui2EaGz+SyPXwLODN4BqPB3PNphXeB7ww==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr6917210pls.121.1644691838484;
        Sat, 12 Feb 2022 10:50:38 -0800 (PST)
Received: from [192.168.0.108] ([183.82.176.65])
        by smtp.gmail.com with ESMTPSA id q40sm8661990pjq.19.2022.02.12.10.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 10:50:37 -0800 (PST)
Subject: Re: [RFC] clarify licensing terms for .git/hooks/*.sample files
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqzgn3185p.fsf@gitster.g>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <cb3a4d55-9c84-5d7a-a9cc-767827520763@gmail.com>
Date:   Sun, 13 Feb 2022 00:20:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgn3185p.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/02/22 12:21 pm, Junio C Hamano wrote:
> When a new repository is created by end-user, the template material
> are copied from /usr/share/git-core/templates directory, including
> sample hook scripts.
> 
> As the source code of Git itself is licensed under GPL-2.0, by
> default, these come under the same license.  Some end-users may
> worry that this might "contaminate" their project's licensing
> status.
> 
> Let's add some text to clarify _our_ intention.
> 
> What is added is merely a draft for discussion.  The commit
> references and author idents point at the right commits and people
> whose input matters in today's contents of each file and we'll have
> to contact them and have them agree what license they want to have
> the current contents of the file under.
> 

FWIW, this does sound like a good thing to do.

> I am contemplating to relicense all my work under templates/hooks--*
> under either MIT or BSD-3-Clause, but some sample hooks do not have
> my input and the choice of course will be up to their authors.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   cf. https://lore.kernel.org/git/xmqqbl07mrp3.fsf@gitster.g/
> 
>   templates/hooks--LICENSE | 256 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 256 insertions(+)
>   create mode 100644 templates/hooks--LICENSE
> 
> diff --git a/templates/hooks--LICENSE b/templates/hooks--LICENSE
> new file mode 100644
> index 0000000000..f6834f312b
> --- /dev/null
> +++ b/templates/hooks--LICENSE
> @@ -0,0 +1,256 @@
> +The *.sample hook scripts installed in this repository have been
> +copied from Git source code by "git init".  Because Git itself as a
> +whole is licensed under the GPL-2.0 license [*1*], some people have
> +raised concerns if these scripts somehow contaminate the contents
> +developed by the end users and stored in their repository.
> +
> +While we, Git developers, are not your lawyers, we believe the
> +presence of these sample hook scripts in your repository does not
> +constitute "distribution" that makes the contents tracked in your
> +repository governed also under the same license as ours, but it would
> +be a good idea to clarify that
> +
> + * We do not intend to spread the license of Git to your contents by
> +   copying the sample hook scripts.
> +
> + * These sample hook scripts may be under licenses other than GPL-2.0.
> +
> +The list below describes under which open-source license each sample
> +hook script is licensed.
> +

The above seems to read well to me.

> +----
> +
> +NEEDSWORK:
> +
> +Below are draft entries that do show correct commit object names that
> +matter to, or contributors who write, the surviving contents of the
> +file, but these people haven't been asked to do anything yet (hence
> +they haven't responded yet, of course), so they do not show what the
> +licensing status of these files will be at the end of this exercise
> +yet.
> +
> +What I am hoping to achieve is to replace the text under each bullet
> +point to document who the authors/copyright holders are of the file,
> +and under what license the copy given to each end-user repository is
> +usable by the end-user.  It would be more useful if the license chosen
> +(which can be different per file) is more lenient than strict.
> +
> +----

> [ ... snip ...]

> +
> +* prepare-commit-msg.sample
> +
> +    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> +    b22a3079466b72e8a8b76065d6c28efe7eea4b16 (clean-up)
> +

For my part, I would be fine if we license contents of prepare-commit-msg.sample
under the MIT license.

-- 
Sivaraam
