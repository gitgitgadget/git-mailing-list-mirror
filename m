Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C9B1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 09:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754457AbdA0JS5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 04:18:57 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34538 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754296AbdA0JSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 04:18:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so56643095wmi.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 01:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fERqoeiVKN7/gOPyTIzLnh9CyItUefO1q4/MdHY07ow=;
        b=YTOktsS/vLHhSevmbMiWuBVRBOmwzY18ittVFHy52cnzC9sQF6UQImhKXHB6kQtche
         Ib5h5n0drkuXThQK4UuH9D84FCsZ22on7SsNQbBev/QZSzVfdipOG9PdAQ1HTTOadGrl
         +s5n+UBS6kmBXiKywcVddX33b1pkGt+RjIZdbcXOMxFUldYT313V/iFJiT+M4bnUVVsV
         Imf5aUcyHlz2qiTSBtFc7j9NEqk5cN+D4t/hG1NFe+UwknlZSzdyzoNLMFwx18wjophz
         G1R+qIdlQ6iny9C4LPKNFzqLOyFK1BM2X6Jbfe43zKlLDgzG3HY8MbSaWIhvlTX2U36J
         xRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fERqoeiVKN7/gOPyTIzLnh9CyItUefO1q4/MdHY07ow=;
        b=LjwBWwk8pnYzpMuMcuu9rsGgga96LsxfshN2f82lrCJHJkXXv8zJ9g6hfGq0fj6v31
         2aeA9ESHfOheUkpTdi1FR9hBXbykepvnuvoWUbfwtCWdaWSbFta/swUfCc6JeZbiLirP
         zyunovkq5Genj5tXuC4DOMey0AgMxGV9JDpe0sRw94G0CWu/57D5MQLSdfe2Me8ISV3s
         tuoLqtzrWR0obyKxa7jzUhAl1G0iGNjsy6QqtbERITpiQ1LN/waKajtISDXzrADOrEkA
         I3p5Xk6i4V6p1Po7Z0/O6uRgt4hA2UbIuHDAoJouVLgFsTBwT1zv9TjNMkSoJWKCdHNA
         /1dw==
X-Gm-Message-State: AIkVDXKdNOC27lh7Th7bBvTqkyM+OqZXGLefP64El5Xr1BHery8xoLPNfOJsPa8a6Lnjug==
X-Received: by 10.28.198.65 with SMTP id w62mr2232712wmf.123.1485508698569;
        Fri, 27 Jan 2017 01:18:18 -0800 (PST)
Received: from [161.111.219.63] ([161.111.219.63])
        by smtp.gmail.com with ESMTPSA id u42sm6840181wrc.1.2017.01.27.01.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2017 01:18:17 -0800 (PST)
Subject: Re: git clone problem
To:     Santiago Torres <santiago@nyu.edu>
References: <ef188364-ccd2-e7f5-3c06-62afca79f8d3@gmail.com>
 <20170125175840.hy7d2f775dxnafpo@LykOS.localdomain>
Cc:     git@vger.kernel.org
From:   Jordi Durban <jordi.durban@gmail.com>
Message-ID: <1f99a4a2-2d6d-7bda-5f2c-9a0754791856@gmail.com>
Date:   Fri, 27 Jan 2017 10:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170125175840.hy7d2f775dxnafpo@LykOS.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Santiago!

Thank you for your answer.

What I meant was that the "WHATEVER" directory contained the same files 
as the current directory (i.e the directory where I typed "git clone"). 
Thus, no files from the remote repository were cloned. It seemed really 
weird. However I was playing around with git and finally I was able to 
clone remote files in a "test" location as you suggested.

Thank you very much.


El 25/01/17 a les 18:58, Santiago Torres ha escrit:
> Hello, Jordi.
>
> Hmm, it should've cloned in the "whatever" directory.
>
> Can you post your git version/configs and maybe the output verbatim of
> the command when you run it?
>
> If you can reproduce in an empty dictionary that'd be better
>
> $ mkdir test && cd test
>
> $ git clone --recursive https://github.com/...
>
> $ ls
>
> Thanks,
> -Santiago
>
> On Wed, Jan 25, 2017 at 05:58:58PM +0100, Jordi Durban wrote:
>> Hi all! Not sure if that will reach the goal, but let's it a try.
>>
>> I have a problem with the git clone command: when I try to clone a remote
>> repository with the following:
>>
>> git clone --recursive https://github.com/whatever.git
>>
>> what I actually obtain is a copy of my own files in the current directory.
>>
>> I mean:
>>
>> In the current directory:
>>
>> $ls
>>
>> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
>> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>>
>> $git clone --recursive https://github.com/whatever.git WHATEVER
>>
>> $ls
>>
>> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
>> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>>
>> -rwxr-xr-x 1  1,6K set  5 13:05 WHATEVER
>>
>> $ls WHATEVER
>>
>> -rwxr-xr-x 1  1,6K oct 24 17:29 get_fasta.pl
>> -rwxr-xr-x 1  1,6K set  5 13:05 script_clus_miRNA_c95.pl
>>
>> I am really confused with that.
>>
>> Any help will be appreciated. Thank you
>>

