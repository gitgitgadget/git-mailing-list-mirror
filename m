Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4C81F453
	for <e@80x24.org>; Fri, 26 Oct 2018 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJZV4t (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 17:56:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 17:56:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so1362200wrn.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ufMOkfOmNcH5da8l0bEA3CsQtQEMJJU4igzIeOOLOwU=;
        b=HkdAxr24itWsZwIwjU/6Juo7zFmXoG7OMQ8AtDdT20JwRs+o7K9NcIXzdsE9mHxhr3
         Y1myi/j8C3QONMQwH3L5GpY7NwDvREirvV8fkrN/S9pycqJIfN8q3DGpzlMJ0b5U2GjD
         BczcUcpafKJ8oTPQCDApa46LlvXXI6AFyQ+m+paPtV+mJD/ibXztP2Wj2PpfQ/3jhkMz
         ppBZpzk2dUxYS+/47H9VIa1Y82svZ22bsYeB+PWTZJ5DwsEv8spPXIFofFpO+JwBgIU7
         TNoWNp6JWMP64WDTG71HpoWr1qO8ghYbRhl5JNmPVEknPw+djNfaT85/0NiSwgPHP5Pl
         qmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ufMOkfOmNcH5da8l0bEA3CsQtQEMJJU4igzIeOOLOwU=;
        b=myWU2gZ3EC2XK58Cvb1woCXNhCaaxCPCDcm1fTJ2S06xBpx5rvTrPLIQtrafszIf0/
         RLiLZgmbK8Nr2n02NZNxIIDF6arEFs4Pc0J4jL+VbYtcwFsPeAA4Ol4tEmavHxkNnykM
         HamGBCYCYd87fp547nSJVC5vQ2zMS1SzECn1jiUen6cSV4eOoLIe4s8hFDJJK+hz7aiJ
         MXpVvbp3BZ8yT8ugH4UxX4AM2gFCuJMjTxWMDuTpF7i/t1fFWxCr7gGZijo2pqJerokv
         XKIztJlSex2FNePd52R5oWiELKvaEnKiOgvDtCqX9Pi3TedRxaPrZPJTgJz7MxJwF6J5
         pTjg==
X-Gm-Message-State: AGRZ1gJ1u6Lr9ZTTQFMtZdf9u3GkA645tMENJL5uIg0XBFKFAbaE6nln
        GsEoNGA9EcVEgffnfoJxbjk=
X-Google-Smtp-Source: AJdET5d4v1lei5AUzJw9ZE95rLcDenctQjLZ825YBSwOMj6CCfs1WcLepQ1WeOOpMI4dsEQLOFHtgA==
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr6166752wrg.144.1540559983061;
        Fri, 26 Oct 2018 06:19:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c184-v6sm2969769wma.15.2018.10.26.06.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:19:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
Date:   Fri, 26 Oct 2018 22:19:41 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 26 Oct 2018 14:09:52 +0200
        (DST)")
Message-ID: <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 26 Oct 2018, Junio C Hamano wrote:
>
>> * js/mingw-http-ssl (2018-10-26) 3 commits
>>   (merged to 'next' on 2018-10-26 at 318e82e101)
>>  + http: when using Secure Channel, ignore sslCAInfo by default
>>  + http: add support for disabling SSL revocation checks in cURL
>>  + http: add support for selecting SSL backends at runtime
>>  (this branch is used by jc/http-curlver-warnings.)
>> 
>>  On Windows with recent enough cURL library, the configuration
>>  variable http.sslBackend can be used to choose between OpenSSL and
>>  Secure Channel at runtime as the SSL backend while talking over
>>  the HTTPS protocol.
>
> Just a quick clarification: the http.sslBackend feature is in no way
> Windows-only.  Sure, it was championed there, and sure, we had the first
> multi-ssl-capable libcurl, but this feature applies to all libcurl
> versions that are built with multiple SSL/TLS backends.

Yeah, but "http.sslBackend can be used to choose betnween OpenSSL
and Scure Channel" applies only to Windows (especially the "between
A and B" part, when B is Windows only), right?  I had a hard time
coming up with a phrasing to summarize what the immediate merit
users would get from the topic in a simple paragraph.

> The two patches on top are Windows-only, of course, as they really apply
> only to the Secure Channel backend (which *is* Windows-only).

Yes, that is why the summary for the topic as a whole focuses on
Windows, as that is the primary audience who would benefit from the
topic.
