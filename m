Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217BF1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 21:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJDEZ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 00:25:28 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44010 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJDEZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 00:25:28 -0400
Received: by mail-pl1-f169.google.com with SMTP id 30-v6so4085103plb.10
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c8n8761X4IEgAd9ud0aJ23+dT5FpxfmGbhkb4XmPizE=;
        b=hT4oMSqg3cSgdzbAJ/7r7eZ4bn1mQ9C+tPWpDYeUcLqion6nk9FagSniC/PI9g0nHp
         imyUrysP4YDTrELcsPCMxuh1TTQWN1iGPC+vOMfq/9yQnAXFE2Vn+Ym1pBVPOwLWt1Vb
         qC964Wm/0u2M22yUO6pvm4wDWx3Imwg+I0wARgJBxH+uPOxBSrpzYx/SaJrTBN9kWgZf
         TJzZ2BdS50SqmwO54XCNDWDKhRy1jLxrSwjGOegXD2MLi4GXdAMIPWtyvOp3oVF+IwOV
         ga8247bycQykXbmC86GyjRZLl+mXSwphzSLhDWO61yt9WwDDnRX/DC+JXdGHeMy38a/+
         qQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c8n8761X4IEgAd9ud0aJ23+dT5FpxfmGbhkb4XmPizE=;
        b=rnvUl7uhKYt9Py85KSALMni8EObGvRgPDtn6adO8eyCrmttR11ViGJPvEhF8mfD/F6
         V8aaY4q8lNcuKsiY088Ju9qR8X+LBi9Che2nlO6gdSw6XirRhmzcUtAeWURd9JKOAOKL
         wtV+lsOZLkg5rl8jiYgZu9B3GRJoHM5FZmp9GevYO6RefNfBlXBBxhAmeUP1fZDTuStI
         G5zuCq95iV2LfLU4Ig1SJ/ujCpLndvTLvLCKnf8Owmwq5nx7Q+v40nOglf5Cgoq9V4gn
         pK9SiTMDB2aWVL4fXS8+2T5cqcmzbfbbZHbVPr7fj33fCuKn5eO91g17eZ4+/E4rw1Oz
         a8lA==
X-Gm-Message-State: ABuFfojju7NKtwTcaHlrkJpOPcQWYnXOcTVo7ZJ9vqYNwI7A+rCuUOkD
        kGcrPUmVNEpUDh40d61Bh88hQ7hX
X-Google-Smtp-Source: ACcGV61kw+tmQ4MsHrlOyDXfobc85ql4R/g5vpuxIf7C5GGJpcFQVhb98OoIn7hT8LY3IAYJfif67w==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr3575667pls.202.1538602518792;
        Wed, 03 Oct 2018 14:35:18 -0700 (PDT)
Received: from [192.168.2.4] ([171.233.129.129])
        by smtp.gmail.com with ESMTPSA id x17-v6sm3369973pfn.59.2018.10.03.14.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 14:35:18 -0700 (PDT)
Subject: Re: Fwd: Git credentials not working
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <20181003171104.GA12200@sigill.intra.peff.net>
 <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
 <20181003182409.GA14848@sigill.intra.peff.net>
 <84e704e0-fbf9-230f-459c-2927dea19a03@gmail.com>
 <20181003204312.GC20709@sigill.intra.peff.net>
From:   Dimitri Kopriwa <d.kopriwa@gmail.com>
Message-ID: <9cdc6dc8-a897-471f-a7e3-83cdfdf86fac@gmail.com>
Date:   Thu, 4 Oct 2018 04:35:15 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003204312.GC20709@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone.

All your answers helped. I found out that the issue was not related to git.

I am using semantic-release to perform a release, apparently 
git-credentials is not working with semantic-release.

I did also setup the double authentication and every fix applied on 
git-credentials were simply useless.

Read more here : 
https://github.com/semantic-release/semantic-release/issues/941#issuecomment-426691824

Thanks a lot for your help and git is the best software ever made thanks!

Dimitri Kopriwa


On 10/4/18 3:43 AM, Jeff King wrote:
> On Thu, Oct 04, 2018 at 02:34:17AM +0700, Dimitri Kopriwa wrote:
>
>> I have replaced the way I fill the git credentials store, I have verify
>> ~/.git-credentials and information are there, the ~/.gitconfig look fine
>> too.
>>
>> I still have 401 error when reading from that file.
>>
>> This is the paste log : https://paste.gnome.org/pmntlkdw0
>>
>> Now that I use git approve, I dont think that I need a custom helper.
>>
>> Any idea why I still can't log in using git-credential?
> Looking at your pastebin, it looks like the server sometimes takes it
> and sometimes not. E.g., piping the log through:
>
>    egrep '(Send|Recv) header:' |
>    perl -lpe 's/^.*?(=>|<=) //'
>
> I see:
>
>    Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
>    Send header: User-Agent: git/2.19.0
>    ...
>    Recv header: HTTP/1.1 401 Unauthorized
>    Recv header: WWW-Authenticate: Basic realm="GitLab"
>    ...
>    Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
>    Send header: Authorization: Basic <redacted>
>    Send header: User-Agent: git/2.19.0
>    ...
>    Recv header: HTTP/1.1 200 OK
>
> So that works. But then later we get:
>
>    Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
>    Send header: User-Agent: git/2.19.0
>    ...
>    Recv header: HTTP/1.1 401 Unauthorized
>    Recv header: WWW-Authenticate: Basic realm="GitLab"
>    ...
>    Send header: GET /example-keys/sample-project.git/info/refs?service=git-upload-pack HTTP/1.1
>    Send header: Authorization: Basic <redacted>
>    Send header: User-Agent: git/2.19.0
>    ...
>    Recv header: HTTP/1.1 401 Unauthorized
>
> And then that causes credential-store to delete the non-working entry,
> after which all of them must fail (because you have no working
> credential, and presumably no terminal to prompt the user).
>
> I have no idea why the same request would sometimes be allowed and
> sometimes not. It's possible the <redacted> data is different in those
> two times, but I don't know why that would be. It's also possible you're
> hitting different load-balancing servers that behave differently.
>
> -Peff
