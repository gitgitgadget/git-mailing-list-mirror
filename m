Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE971F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfJGUhA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:37:00 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46449 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGUhA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:37:00 -0400
Received: by mail-pf1-f172.google.com with SMTP id q5so9356197pfg.13
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wD9d7799RGgz6ULeEn182oLSoU6v/ifAX6FSPysZDeI=;
        b=omnvip2ConaRCiYB724EOFkfR7kEpZ5S0KhXXBqqpj/CzLF67tkhtxUpsTlObRiY+c
         nfVV+TR4vqjAdH9tBp9ALJyCVpbHO9rpDeYpNZ5TCmRRJ2ERgM0C47WXtbudDwwAt3g6
         LKfIW0FzXGbljMIOO8Dh2J5bqvQP7Pywmn0VJPhKrcw+L1EYvObsiSrRYJti9kucFxrU
         iPYyVmfGi6wBez6fLyf5LjkIVFkwK4U9ODOThtpmODnceY5GjPmgnMdAHxQry5YI/gFQ
         WuiQz51FLHO/98bSbeHOt1L+13rqXkDbp7kkKBsEh8y0aicvxtIo+90xlwIHxjKBcuna
         /ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wD9d7799RGgz6ULeEn182oLSoU6v/ifAX6FSPysZDeI=;
        b=PgrIrMbP2TG45BBi7zshB1AguYw9Dio/vmADRekjiVmu/cU2etiewTgs34Bq+lnN3M
         lfNla+mCYrtMWGcf5KYT2eSArR4f0OsUEk0sBzaqHH/Ogs97kyN70mB45l9V1lwFZcO8
         9nxkeTJrZTkvAarCvhaVcguRsL78L7hfiR0wWiFrE6q6p7y3tzQFyrJWyIKtQ6fOHgzv
         NRXgCI4Vb61Na4H37Af95SWHIgYdHceJz7lCNOfxTIRWLrn6qm8yfv+TSlJu3Dkky+DT
         2CW7wr+RsB0TsIe7SGhDVI9LYop+e93xDPWlh9ZdWB80h7F435Fx4b7rovJf166jWtci
         CmJA==
X-Gm-Message-State: APjAAAVaKkax3hE17PEe4JnO1iWfzrjewYv2a9NRvBSeBBf1j0w0vJpQ
        scmm5e34OL1HzqALDEYaJxwwuQ==
X-Google-Smtp-Source: APXvYqxK64qtKhMz8ldhPI8ljx8ZSzWGVvR36jM/yjLMM4H7tk9l/FA8ZP30EWbshgROs86p5YaTlg==
X-Received: by 2002:a62:170b:: with SMTP id 11mr33617139pfx.243.1570480619043;
        Mon, 07 Oct 2019 13:36:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q30sm330913pja.18.2019.10.07.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 13:36:58 -0700 (PDT)
Date:   Mon, 7 Oct 2019 13:36:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Rajni Jha <rajnikjha98@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Outreachy
Message-ID: <20191007203654.GA20450@google.com>
References: <CAAe2+-RUhQDuw2kR4xCh2Sjh0CvpuBsWtK2iLmHih1iWtcP60w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAe2+-RUhQDuw2kR4xCh2Sjh0CvpuBsWtK2iLmHih1iWtcP60w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 06, 2019 at 01:32:54AM +0530, Rajni Jha wrote:
> Hello!
Welcome! Thank you for introducing yourself and please don't hesitate to
ask any questions you may have.

> 
> I am an outreachy applicant and I am looking forward to working with git
> for my outreachy internship.

Hope this will help you get started. The community discussed the list of
microprojects for applicants to try in this mailing list thread:
https://public-inbox.org/git/20190916184208.GB17913@google.com/
I don't think you need to wade through the replies on that thread to
determine whether the microproject you are interested in is available,
although you're certainly welcome to. You can also ask me if you see a
microproject you are interested in and I will be happy to help
summarize it and point you in the right direction :)

It is also probably a good idea for you to search that mailing list
archive for "[Outreachy]" so you can see what Outreachy interns have
done in the past and try to emulate how they submitted finished
microprojects. I also recommend that you read through
https://git-scm.com/docs/MyFirstContribution.html#ready-to-share to
learn how to share your code with us when you have finished.

 - Emily
