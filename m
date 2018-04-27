Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637BB1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757708AbeD0S2K (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:28:10 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37036 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757225AbeD0S2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:28:09 -0400
Received: by mail-wr0-f176.google.com with SMTP id c14-v6so2617240wrd.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iHuSYGwNvzmSjE05G6HLQ71x4+yJUJmxfQslVvEWoOI=;
        b=hsqL0cPoXnIE9nsq+aXpCibdCWnStrILTQaCSpR/3WY2ydGUzzzqFD1pF4LEJyUukV
         Db4TeufaS0VLJVXocARfjCH5ncWcAGUyBZTvRrmDZPB8dIgnMbvpKLzJCj2paM6/3J8y
         ZfIoffUBnxJvuLKoKKRfXjFu4vh7iB+XUotqBRhVGr08PpnlsL/l982zXmz1Y+xSpBO9
         elxJK9vnmRk+oTD6Qvl11/S9DGupJ7c5V0Y2bogkHXcvtqrWWQF6ySx0PJmwkfuGmZMD
         bdtyBlh0bCQhuJvs8vt0aAApzW79Ogm+7e4X7IOROhz5QjHTtDYGZ/+Z63zTdAqJSE65
         +7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iHuSYGwNvzmSjE05G6HLQ71x4+yJUJmxfQslVvEWoOI=;
        b=PtOeydEBPDBbD1xd9ZBrUbOvNEIVNErs7Uhh09yvF8yFS1mS8EUuZM0BtNCJOi9dP2
         58Ihr33QukEJG1dvgUrIOfY7L2H/4UHyX6CGcSMwLc4UP7zVFr1QEkHNChcf+RTeTpmy
         jR1nZ9e7NMAJKps4thq/v0F0Cr3PXcF+g/dswunKMHOYlpP2CZeKNEC1cXEri4fxBOQc
         a8t5sw7D1PQKOp3qsB3zap0d/GIWQvwJTGUErcnnhOVsYVG5j+Vki4zb5o0ht35pWM1N
         JcqjkWl9qgW7nIz5N9bD59+fssPMKCNfEyYNtoRq3+2Ij2R0VjTVGJZCF/0lmjsIUiNf
         jxLA==
X-Gm-Message-State: ALQs6tCwYNc6TcPKLZj/pIXB3FQ+XCaP8jprTFkHDOjRed+Kh83qm2qX
        lIUoVC2Lk5h0I19pLg0Ln7w=
X-Google-Smtp-Source: AB8JxZq0qdPNvrMaIksdHOdhdZpTHzhKZzU7W6f9PHvjVLWR1H9CH085ggaQzkPrkHQNPrGxyY4DHQ==
X-Received: by 2002:adf:e092:: with SMTP id c18-v6mr2574461wri.70.1524853688430;
        Fri, 27 Apr 2018 11:28:08 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:b0f7:2e70:f673:62a9? ([2001:a62:81d:ab01:b0f7:2e70:f673:62a9])
        by smtp.googlemail.com with ESMTPSA id t189sm1827624wmf.22.2018.04.27.11.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 11:28:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com>
 <CAN0heSpdc51+7-uWcLVXU72qLZgZApdME8ywBJaQQy4DiWHAfg@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a3253c99-63a4-22bc-53a0-4d94c01a564c@gmail.com>
Date:   Fri, 27 Apr 2018 20:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpdc51+7-uWcLVXU72qLZgZApdME8ywBJaQQy4DiWHAfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2018 um 19:18 schrieb Martin Ågren:
> On 27 April 2018 at 19:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> The two '<path>' parameters are not optional but the option
>> '--no-index' is. Also move the `--options` part to the same
>> place where the other variants show them.
> 
> Should this commit message be updated after the changes you did to
> address Junio's comment? This text suggests you want to place --no-index
> in [] (and you did in v1) but you do not do that below.
> 
>> All three items are already correct in the synopsis.
> 
> Same here, now you actually do change things there.
> 
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> Reviewed-by: Martin Ågren <martin.agren@gmail.com>
> 
> Strictly speaking, my Reviewed-by was on another patch. I do find this

Sorry, I've added that trailer after reading "The diff LGTM.", then
applied Junio's changes and forgot to remove the trailer.

> one better though thanks to Junio's suggestion (except the mismatch with
> the commit message).

I'll fix that with this:

	doc: align 'diff --no-index' in text with synopsis

	Make the two '<path>' parameters in DESCRIPTION mandatory and
	move the `--options` part to the same place where the other
	variants show them. And finally make `--no-index` in SYNOPSIS
	as mandatory as in DESCRIPTION.

