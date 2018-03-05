Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F5D1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeCEXZe (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 18:25:34 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:44544 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeCEXZd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 18:25:33 -0500
Received: by mail-pl0-f44.google.com with SMTP id 9-v6so5195238ple.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJN37ATXP0pvo1oYUiCh7JmdmMNJFGHBrsz09MLCPjU=;
        b=pxmJKLFoQDsrUETbnPXiLoXpygFUxIVEXS+91OBplNOK569giJSij4b1xGIRm+890i
         LpnARXYDVlQBlBA1KCXpNq8jjlcD5sUdW2TKh2LJqvvkGbXI6P/2Tfs7dAFjof0DxYAj
         IrDJRWomIgJa3RKdnEhuvou4rzBJtYI8ko9wgAh+RMw/xglPVrAEq7ycOhNsdwK7fdVo
         Oh2PuTxWVLPj4JEd+7Cf5zbkZ9zu7UTJeBZI9QJd8JWpt8W9hdCSjwuOQV4Q+KdhAFC9
         RpCUq81J4UM6lR41ieT6rKmEQYjbexj3v3svHGNhrrG5crTSTI2m/MO0aQKhQnMSwfNh
         ctog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJN37ATXP0pvo1oYUiCh7JmdmMNJFGHBrsz09MLCPjU=;
        b=OKwjo+4o0NsBmGd498S5pSXRqUWP4APXW7hbIz9dMHKz2Ko42b/0m0MojkswPtqOp/
         rY2em2A0aziQcy/+31I6stWsfn21D+7OVB3vQ1p+4g1tgYnaOrR4gMIbsysBMiiBsahH
         ImTJD4VODJlbSjEDkXSFtfN+P0QEBXfrPzPpeL2py6FhG/kSpBc3PdJiLz73knFxkJq3
         TyaXotJm0SCaCN0SeId7ICYVPZaMUfu4ApgsmrPzl10Fke64H4Y1X3s6ETMOSJkZBtVg
         Xa7LJsoQgENxPM6gF9GiP7RStAh8e2Wrzdk+UHkD85AB0kUjBk4mEFYZMg9isUSUZj3m
         NZAw==
X-Gm-Message-State: APf1xPCNj9NBPsXRAfho+qqT2DcAQEt5stOJZCAgwESVZ/U9nhtZeg2n
        UPZSwHW4StNjJNiTTrLTNmwRdcun
X-Google-Smtp-Source: AG47ELtH5KRqsS14RSf1OJRI4FaH+SSNvut/8yD/l8Um83HYxgypq/G6h2CjgZijmx43piqkrFtxvA==
X-Received: by 2002:a17:902:b613:: with SMTP id b19-v6mr14499015pls.173.1520292333312;
        Mon, 05 Mar 2018 15:25:33 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b6sm31041704pfe.85.2018.03.05.15.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 15:25:32 -0800 (PST)
Date:   Mon, 5 Mar 2018 15:25:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     kalle <kalle@projektwerkstatt.de>
Cc:     git@vger.kernel.org
Subject: Re: man gittutorial: patch proposal
Message-ID: <20180305232531.GH28067@aiede.svl.corp.google.com>
References: <d34357b0-45a4-d22b-9a53-1a376addbd53@projektwerkstatt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34357b0-45a4-d22b-9a53-1a376addbd53@projektwerkstatt.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

kalle wrote:

> see attachment.

Thanks for writing.  A few questions:

 1. Can you say a little more about the rationale for this change?
    E.g. is the current formatting sending a confusing message?  Is the
    current formatting intending to use '' as quotes and using italics
    instead?  If so, should this use "" to fix it?

 2. May we forge your sign-off? See the section "Certify your work"
    in Documentation/SubmittingPatches for more about what this means.

Thanks,
Jonathan
