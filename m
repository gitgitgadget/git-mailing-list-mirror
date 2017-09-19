Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15B02047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdISUeM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:34:12 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:53920 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdISUeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:34:11 -0400
Received: by mail-pg0-f54.google.com with SMTP id j70so447073pgc.10
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igKne/IRbLX1k1t9VLpTxZNYA8373pymZXYCEE0q7RY=;
        b=bS6hYaKpFBdXwZUzW9TPc6EfjEhiHlSSyg9I5elfySn8LMtnkJGj1RWQVkA7H0GFHI
         Dws3+aX2qf8zpuwjnnySXjfnsSxlvDo66n+DtWRekt2McJ/+YL1my7zD11EVpyhgpt0c
         dcnq8wHcMzVtQU3v5gekh1yZdrWU9w2q5FrDcQzAfJvto9+TkHbiYBIgsb7MCxMgOogQ
         EgWiyvSkKHxCuGURKApED8iN0stqdEl877nzIYXh+ssuwjL4doDm4Q1AHKDzjMFXlSe8
         hf9H+fYwFDS+o3z78dDUZj47ckZHnzWu20MrIdDviEt2ZWup8jeLLlmUBmF9aAmGjOJo
         RFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igKne/IRbLX1k1t9VLpTxZNYA8373pymZXYCEE0q7RY=;
        b=EMGlL+mHRb7N2J9OyCwzSHAKlh2BZlm0ugYb+mMP8shT0Tg2BZONBmEYRjNzORK/9S
         gfXLHK/kHFPG1NzZf3mJZWO9NlO+/uh6v4K7Ikxq35g/eW1iiiwQNGhI7PBg6TysGtWp
         qjSWBE8OxhduQ/CtXXMpohUVbdAoFLdM5RGo1e+Dk32+ZY1E9SjkKPksIIULrSs4d6Pk
         cXk/PxXxxCaEMTehUgBbN/98+SN4DavnEjpwJoYS5IP5AUMYkSctmm5BeLL7jH/0uxMb
         ig6n6SUZPbqZIX/Q4Wum2gpk/jdKdBGPTKkYcr8s23PF/AFXnc3sS5yzn8l7KOl0CEOC
         a6gw==
X-Gm-Message-State: AHPjjUgn5ZsYNnunuMT4Rmr0zxLgQcbKwDlWD2ClVLiZzOF/bWElUsK2
        DcDutF27Ngok/gaTDf9DANs=
X-Google-Smtp-Source: AOwi7QAckxCwZEM/cPmjW4opjR8zmWKxfKUFjH63qkBTni41oUcsnkLk7cICGIaRUu2wqXwC7t0LHw==
X-Received: by 10.98.149.68 with SMTP id p65mr2320676pfd.301.1505853251093;
        Tue, 19 Sep 2017 13:34:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id x27sm4913417pfe.65.2017.09.19.13.34.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 13:34:10 -0700 (PDT)
Date:   Tue, 19 Sep 2017 13:34:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
Message-ID: <20170919203408.GE75068@aiede.mtv.corp.google.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
 <xmqqy3peszho.fsf@gitster.mtv.corp.google.com>
 <2f3cdc85-f051-c0ae-b9db-fd13cac78aed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3cdc85-f051-c0ae-b9db-fd13cac78aed@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart wrote:

> Some stats on these same coding style errors in the current bash scripts:
>
> 298 instances of "[a-z]\(\).*\{" ie "function_name() {" (no space)
> 140 instances of "if \[ .* \]" (not using the preferred "test")
> 293 instances of "if .*; then"
>
> Wouldn't it be great not to have to write up style feedback for when
> these all get copy/pasted into new scripts?

Agreed.  Care to write patches for these? :)  (I think three patches,
one for each issue, would do the trick.)

Thanks,
Jonathan
