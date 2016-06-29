Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89ED1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbcF2LvX (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:51:23 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36030 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcF2LvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:51:22 -0400
Received: by mail-pa0-f49.google.com with SMTP id wo6so16946398pac.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 04:51:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=uqqZ41UV03Yx0TJ8P8gkLFFuhAYhjThIv9zFO8f5mnQ=;
        b=Gcj2bDYhMG8keLxgZhiV3w8IVK2YRGGrcbKSWKAlnDoA9Plefn7BNU1M38vg8tN1Z9
         osT3ZJ/ilUZ7xH5EOOnHY6qI3fr7ck6W363LXO6Edv8qplBzeqCQCyWkjdHQDn7v4DQo
         C6UQgrAiXAtoQLakOmS/19ggj/dEe6aDCPnfkUt7xHG1ZCwd4m2Cm6VV0OJwbxuojEyj
         7Lf/XgcCuF9T54esQ3RUQVxYHV/tQ/DJ/LlTWemCwO4mDBZ2CNU+PhZRbi5LgjhCK4wC
         sUmPjBF+RjarfP03OQx/7/Yy2+NCAD35yaRw2dalmKOTQEXUr0rD7Crso9FgHdXm/OAb
         83+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=uqqZ41UV03Yx0TJ8P8gkLFFuhAYhjThIv9zFO8f5mnQ=;
        b=S3+f/P4kkEGWWP8AWSxmCVVvr5J3sfuNyzlGd8iGDz2vFlOCzGcHTKboiwyoShnpY2
         T7n0yFr0EspR3HM8t5weVAnRdE54CkSdl5fAksreijh18gspnnH7H5dztA+SyuioRU0j
         vy9NZl9uBeykWwC72lnHSjhpDmSgpBiNn49JDmxYrEQUn16wzOWao+pUfdTwAEjuhoHB
         yirysOYH39uLU6Svd72AjHrzu2YgnF5ZlVA6XIz0q4w8hP4QIxkGXD7A554ZedBu7S4X
         6nYNOXgE+ahfiEpCYycVyR9yjw/6Gk9C5ILANT4+aROmrCL50tCDSGC4lfv5o98wPOR5
         u78A==
X-Gm-Message-State: ALyK8tLl8ebK3mxAR1a80HLVPri1ndQMHZP3wOHSDFLFqWvOfni4ODDaABAAnGNrkRZasg==
X-Received: by 10.66.25.133 with SMTP id c5mr10873271pag.103.1467201081923;
        Wed, 29 Jun 2016 04:51:21 -0700 (PDT)
Received: from [192.168.2.11] ([223.207.72.228])
        by smtp.googlemail.com with ESMTPSA id ct7sm5493261pac.13.2016.06.29.04.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 04:51:21 -0700 (PDT)
Subject: Re: git gui produces series of commits with exactly the same time
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <37a71a23-ded6-9d48-a873-a05f33e802bd@gmail.com>
 <alpine.DEB.2.20.1606291344400.12947@virtualbox>
Cc:	git@vger.kernel.org
From:	Andrei Faber <andrei.faber@gmail.com>
Message-ID: <97cb482e-2023-52d7-d8ba-149923c85a3b@gmail.com>
Date:	Wed, 29 Jun 2016 18:51:15 +0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1606291344400.12947@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

No.

Another thing I've found is that these commits have different timestamp 
in the "Author" and "Committer" lines. The "Committer" lines have 
correct timestamps, and the "Author" timestamp is wrong.

Best wishes,
Andrei Faber

On 29/06/2016 18:45, Johannes Schindelin wrote:
> Hi Andrei,
>
> On Wed, 29 Jun 2016, Andrei Faber wrote:
>
>> I've noticed that git history contains series of commits with exactly
>> the same time, despite the real commit time of these commits was
>> different. All these commit were made using the git gui tool. I'm the
>> only developer in this project.
> Is it possible that you played games with your GIT_AUTHOR_DATE environment
> variable?
>
> Ciao,
> Johannes
>

