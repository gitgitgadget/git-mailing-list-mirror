Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFE91F4C0
	for <e@80x24.org>; Fri,  1 Nov 2019 12:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKAM3s (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 08:29:48 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39021 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfKAM3s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 08:29:48 -0400
Received: by mail-wm1-f45.google.com with SMTP id t26so4845788wmi.4
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B+lRv6tJ0FtMKTFsbeUm2QyjGGyyMi8z9/5sdyPRedU=;
        b=Kf/VqYS/0KLjLsRSKjXvU7r0W2qSQUU7MSJbaXiABxa6vhW/0E6lSgmzfS6WCVrx3y
         De1slh62TI06O1Dpiwzr/TLjCcIHFTkvPydE7WFD/+tfJk9e9k5yzKjN+xCJDurd8M05
         fczkEkJ+SrIcaKrrejEV+/doee/tUWA6BtK4066juE+/cPsYBwfLhhN8zYUsoqQT46OF
         udrloNkh4rFDMHF8bCNT//3K9p6Pl5n6C2aDmFbRCZaR4V4YRcW7+eKpGCKY+ojUbyFp
         lkUOzLH3w4JP77eGzlczEorExzaGQOn62BhnojLWPbwWrgGp5mHoM2mVa/uGV5w05XSe
         I39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B+lRv6tJ0FtMKTFsbeUm2QyjGGyyMi8z9/5sdyPRedU=;
        b=tyO1o3IEbtQBGcr6x6Z4BlzyLsFBsn0yHrmc3cXloBmpLEnde8dJ9BJMPk48l+0Phg
         +tFifIL56iBVTnrmI/p/yqrI1UsWLsFwIrJJfs4cLYklBz7AH8itXwP1s2uuj5t/HfAl
         OyhxTA+1DU9nf/cqgPqIvwjpoL1O2pQ/udeh+V3kcfmD7oVNVdSOczz+cqi5KdFAAG24
         1eIRJcOD9Vs1Kr7ZRgAq3m0V49ZCQNa4g5Pbx0q+p5KHR6Kysh6shN9Vu4Un1tK+DYg2
         9+HH2oKc0ZNQ2D3bNhgyn1Q9ig32dD+GQgiR6FCswval49gLpQqUTZ72ucMZ3N+ZIATC
         awJQ==
X-Gm-Message-State: APjAAAWqc/wIWt9TRBJfGfMXoDgH3VE/H44PKuXWk9NDX/gjgrqt8r/k
        bHyp5qCQa2VVB8j4M4dyh5Tz8CIq
X-Google-Smtp-Source: APXvYqzkWBpl70Vq9yWj2PQ4NAxM0DFK66t2jS5+LNDRkjiPWGOcfol/AwzmJdf0I87wxutE/xvhSQ==
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr9987909wme.159.1572611385281;
        Fri, 01 Nov 2019 05:29:45 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id b3sm1114316wmj.44.2019.11.01.05.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 05:29:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git branch --edit-description a custom file
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <20191031181920.GB70819@generichostname>
 <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
 <20191031200739.GA19313@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <822d51af-d522-bf2c-72de-f54a4ccb3b38@gmail.com>
Date:   Fri, 1 Nov 2019 12:29:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031200739.GA19313@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 31/10/2019 20:07, Jeff King wrote:
> On Thu, Oct 31, 2019 at 07:53:18PM +0000, Phillip Wood wrote:
> [...]
>>
>> I'd love to see a consensus around putting remote versions of refs/foo under
>> refs/remote/<remote-name>/foo. To share notes I add a refspec that fetches
>> to refs/remote/<remote-name>/notes. It is a pain that 'git pull' wont merge
>> them for me though.
> 
> The trouble with that sort of scheme is that it conflicts with the
> current namespace scheme, which puts the remote "notes" branch in
> "refs/remotes/<remote-name>/notes". And it's not just a problem if you
> want to have a branch called "notes". Think about what "git fetch
> --prune" would do.

I was suggesting a convention of using refs/remote/ not refs/remotes/ 
for tracking remote refs that are not branches to avoid that problem. 
It's not ideal to have remote branches under a different namespace to 
all the other remote refs but it does avoid breaking current setups. I 
haven't thought it through but perhaps in the long run we could migrate 
remote branches to refs/remote/<remote-name>/heads/ and treat 
refs/remotes/<remote-name>/ as an alias for 
refs/remote/<remote-name>/heads/. As you say below we'd need to think 
about how to use remote tags as well.

> I do think the world would be a better place if we mapped (all or a
> subset of) the remote "refs/" into "refs/remotes/<remote-name>/". I.e.,
> really creating "refs/remotes/origin/heads" and even
> "refs/remotes/origin/tags". But we'd need to re-adjust the way that some
> ref lookups work (e.g., looking in refs/remotes/*/tags for tags).
> 
> There was some work by Johan Herland around the v1.8 time-frame, but it
> stalled:
> 
>    https://public-inbox.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/
> 
> And here's some later discussion:
> 
>    https://public-inbox.org/git/CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com/
> 
> So in short, I agree very much with the direction you're discussing, but
> I think there's some fundamental work that needs done first.

Thanks for the links, I'll have a read through them.

Best Wishes

Phillip

> -Peff
> 
