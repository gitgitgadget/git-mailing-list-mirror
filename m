Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512581F453
	for <e@80x24.org>; Thu, 20 Sep 2018 13:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbeITTZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 15:25:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39597 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeITTZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 15:25:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id b19-v6so5002587qkc.6
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tjk7aj3A9KfHjXqgLH9+Homfd7kzHXKpyaivNMD4Xcc=;
        b=pwxBHERXpBeGih7s+7ehi4ryMQCIN0+vKID85GNxfSMej9nbT/CAhcu/ImockDZXrU
         wj2yToZArmBqnd/BXdQzWn5yssCaeFERDeEQM9k3DpxfE7tgKlLZzqIId+U6UVLG6njz
         g+FdqkYinflGt3Zmu/UlIswL24rTr5w0Lq0svskWTpLRwKyLI2067ufGbU6PibhS1mLH
         ZFAjcKbbQzJg13S3OecUCT7GgsnGudOFMibtXJtdjVQG2MdaIEmSKOxl+w4uLfQB86kS
         hTVgytb1KenNiCrshevf8Gskq2AAfppL7VLthKJgSAVb9q+e6L6RBLk941o21ZlVaMAp
         7Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tjk7aj3A9KfHjXqgLH9+Homfd7kzHXKpyaivNMD4Xcc=;
        b=nyAc+C5yfyZGxwMxCXQMOKF79TWmIpsu8KYPdpiQaydenXvn88w8+uc65txpjzOmGY
         HlETMsJdoyFQYzkeZTr81TwUp79WCuNi6f2luCw6SlO2i1g5ZTyf/NevX1ahUyHKkvL+
         n8N/aqU3+P+nQpu3GKoz8fgt8riXsSk7WuRV+XBZwFnjdISYiUP3O6T3IMO5bskr3p7s
         lMCdRDYvZjqqneTFkAUoVCnG1FvnaJdNLUc1nozcVPhDT641Jhn4mBPu4CcjLrsB51Aq
         HlDw0rgSfL1s70mi05BvadhKdzxGA/5BFOJsvl1bGZ6NmuDQV4q8nuVPKbgnZt5hZ7Y9
         3JSg==
X-Gm-Message-State: APzg51DD7qaBuvFfzPqiyNXN6ppxoFPzWBcXg8VjZs14YtGLRj0wcsq4
        qI+qpc9G3zX1hfI5UH/VVUGzthDs
X-Google-Smtp-Source: ANB0VdadeHNrBufNzHBZoB7qu4Qims9sZeLgSJLbGaO2/+R0ifoSscF9tXQlkzUIVGJTrO1+yoS8jQ==
X-Received: by 2002:a37:a111:: with SMTP id k17-v6mr26728504qke.203.1537450923441;
        Thu, 20 Sep 2018 06:42:03 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v31-v6sm18951800qta.96.2018.09.20.06.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 06:42:02 -0700 (PDT)
Subject: Re: [PATCH 3/4] git-commit-graph.txt: refer to "*commit* graph file"
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cover.1537374062.git.martin.agren@gmail.com>
 <65f42c947aa2b392075740673a5dc889fd6e64e6.1537374062.git.martin.agren@gmail.com>
 <38803edb-de41-90db-33f6-f1a0d5344608@gmail.com>
 <CAN0heSo89WS69VXuPp02nQizordMWgNG0D0o-f-tm02Tp_gGEw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com>
Date:   Thu, 20 Sep 2018 09:42:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSo89WS69VXuPp02nQizordMWgNG0D0o-f-tm02Tp_gGEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2018 9:38 AM, Martin Ågren wrote:
> On Thu, 20 Sep 2018 at 14:50, Derrick Stolee <stolee@gmail.com> wrote:
>> On 9/19/2018 12:30 PM, Martin Ågren wrote:
>>> The full name, by the way, is not the "commit-graph file" with a dash,
>>> cf. the synopsis. Use the dashless form. (The next commit will fix the
>>> remaining few instances of the "commit-graph file" in this document.)
>> The file is literally at ".git/objects/info/commit-graph" which is why I
>> tried to use "commit-graph" everywhere. Why do you think that "commit
>> graph" is better?
> I noticed the discrepancy between "commit graph file" and "commit-graph
> file" and briefly wondered if it was intentional, i.e., if it meant
> anything, but the dash vs no dash seemed pretty random to me. In order
> to figure out which was (more) correct, I went to the synopsis. But
> admittedly, that was quite arbitrary. For all I know, "the commit-graph
> file" could be the better choice, grammatically.

Yeah, the fact that I was inconsistent forced you to make a choice. 
Sorry for that.

> There is the file named "commit-graph" as you note, but it might on the
> other hand just as well be called "cg.bin". I would probably try to let
> the filename "commit-graph" influence the user manual only if we would
> have written "cg.bin" instead. For example, if we would talk about how
> you might get out of a hole by deleting the "<...>/commit-graph"
> ("cg.bin") file manually.
>
> But that's certainly not to argue against "the commit-graph file". I'd
> be happy to s/commit graph file/commit-graph file/g instead to keep
> others from wondering if these are two slightly different things. And
> if the concept and the file have the same name, all the better.
>
> If you agree, I'll do that in a v2, where I will also note in the
> Options section that `--object-dir` takes a `<dir>`.
I think "commit-graph" is better. Thanks for also catching the `...` 
formatting.

Thanks!
-Stolee
