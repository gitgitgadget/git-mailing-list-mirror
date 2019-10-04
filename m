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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8028A1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 12:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfJDM0j (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 08:26:39 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35848 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfJDM0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 08:26:39 -0400
Received: by mail-qt1-f176.google.com with SMTP id o12so8273651qtf.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lg1twu3QgODiJKOzMwQQC1AxeyQgKgr6MAWOfdzHmz0=;
        b=WX2hcmS50DbLGOPqXARHS8IgwyUjuyh6Xy3HZry8+9NKzAfQE5ExDOXsfquABHa2mV
         yAcuvbQ6CuholCElll2Ekn56TeCsJyDSVe9Un31pPlDMsOVjSK9tn5u/4YD6QDRoYJM7
         T3Dva8mxPtW8LEef/+QLF+skCekXCg+AA5DjvhlUcvOYvp2O/F6cGh15S6AFeoBBVFDk
         MlwjgQxGeiBbH01qkijpkWt/jIwr2nBaQCkCoaU/5f+mJeUqdJifg9a6ViV0kpDWoJlv
         GG7fZN5HYONkhbnLcbRBRbdrtEAtQHfxWObXul/uUG+4PKK8iy7FniKLQfONt8+RxuXI
         qF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lg1twu3QgODiJKOzMwQQC1AxeyQgKgr6MAWOfdzHmz0=;
        b=LH3aqQef/2Y7K9rPuohgDaW/61YgjwttM+KnBcDXSUfdG10O7uHEimXVdwRj1jaffi
         HCNNaqtLqEn1HVzyOC0iav4GosjazySNQJcb3NFI3sSF1Hf/PoSi0noVKl0psVPZZKTV
         4/3MNpNR+VoKJQ1iRFhAeMIzLpS4lmZqTBVLCtQWfsbmKCXbfGBUrqbPxsw5EConp/MU
         BZM9OGdGi3oOZm0tjLI9FJLertI5nQE56b+bdss5naqGxFAx9teYcYAvDYS+ZRnQMuUE
         ner4kVs4DsO8fDl7GKrWh2kyM1gHk71rOIBqdlfQ4XB94/qfYKxHfSjZ8XD5ByCKfeOt
         CzQA==
X-Gm-Message-State: APjAAAVaswFMnDzfmdbZHsNP2MW94FYMPCp9Yc26k3/NawGqRVIDyxo2
        vusu4WeoZHZ0BBXspTAy+DGfjC/fIRA=
X-Google-Smtp-Source: APXvYqzFOICdDyxRCVYWfgF/au0AIerJ7ZTMtVf600xz4K3gRdUvQdbOqkr94sW0LrYJRy+/zjVizg==
X-Received: by 2002:ac8:320c:: with SMTP id x12mr15406959qta.285.1570191998145;
        Fri, 04 Oct 2019 05:26:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d7:4f53:f918:2075? ([2001:4898:a800:1012:b60a:4f53:f918:2075])
        by smtp.gmail.com with ESMTPSA id k54sm4411165qtf.28.2019.10.04.05.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 05:26:36 -0700 (PDT)
Subject: Re: [Outreachy] Outreachy internship program
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gespinoz gespinoz <gespinoz2019@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
References: <CAP_ANik21_mkUdqwd0YQS4VDa80AnqQ+Xa1jWsQ7ihnfyQymYw@mail.gmail.com>
 <CAJoAoZkq1=VfJ05J8L2AvJjp6GxoTNTF6pNFAzQ1rx+7LKk6bQ@mail.gmail.com>
 <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com>
 <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
 <6f993a81-9bb5-9d57-0876-45fb2f7e2705@iee.email>
 <CAP_ANikQDyYWKNtfTdH0NMzF5s3=JPzqyiq+ibz98vvb095fDg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910041051370.46@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <54264159-93d5-214b-4da3-53f249e8d703@gmail.com>
Date:   Fri, 4 Oct 2019 08:26:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910041051370.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2019 4:52 AM, Johannes Schindelin wrote:
> Hi George,
> 
> if you have Visual Studio, you could also check out the `vs/master`
> branch of https://github.com/git-for-windows/git and build Git inside
> Visual Studio. The tests can still be run in Git Bash (the regular one
> this time, no need for the Git for Windows SDK in that case).

I also want to point out that git-for-windows/git has its own
CONTRIBUTING.md document [1] with many Windows-specific details.

Thanks,
-Stolee

[1] https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md

