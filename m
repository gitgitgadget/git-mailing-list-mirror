Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B18720372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755823AbdJJAQX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:16:23 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:47212 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755560AbdJJAQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:16:22 -0400
Received: by mail-pf0-f169.google.com with SMTP id z11so5452525pfk.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pRgKm2l+/O6i+ZmbWK4ENikvW3f6GkARSj8qxZVmsiQ=;
        b=T8EF9WKtrmzHRsZFt5k/VE9ZB+WTVA99GCV3cMtjHra92FSdmnm5C4WxJ8EX/4nSHR
         LwpMWbJcqhTbCf1qx2OR2yJeJO/s5VCtf9MIrD5O8HYcmARWgYmbi/dbRf7kjiWgf9lT
         NRMvdzQbiyB8KQO2hT0ZJde0soe6aTaSArGUP3Si6jcq+LMwTQZNg70J0P2380eXIOvW
         QAftmZhBBIGQH5+q6L7vxQAJzYNYIp0c2hdo7idALNfpIGPvarCiZP7eQOfPFmPHid1K
         i9Jw6Rc5gjkTpvTrYlXX1cp0Y47ABx0YNEyuYnQUXLUcARGMhvAK2dePqGJw4qy8p1dK
         eVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRgKm2l+/O6i+ZmbWK4ENikvW3f6GkARSj8qxZVmsiQ=;
        b=SkMwGV59eG4Y2Qjz5wiITR1WJ+bHO6tO+j0aIALUZsQ9RPBf14xg6ua8HhqlHk01fH
         kapl+2F57h9EFCLW7qQQNev/2dXLUUEcghyHBPe/2zykw0dWQUpX9u9M8O5XC1UGT84/
         PQC4CcyfkcbBnlvpJc7CQmx6gzM797z6gDE+zIFZkeXFDLzCkbJ7zN4UmWecgZ2QkWiq
         SlSVXkmFtmEQ6M96jkWjjmN28ZL0fJCO4Fs3d8Lj3VLrhsl26cTub7jDoXXppAVs06cu
         9LE5QHdMboWmsugL/KXOrl7/Oscg6DbIWdQL6JOK1lwQNehBlclY9RUeBNec3nGXcC8r
         7sZQ==
X-Gm-Message-State: AMCzsaWOSfS/KW8Xp80mFGTL93FFxaNQsx2OTM/xndcvShDolvaYIAmF
        OeZzf4F5qOsSZOK4m7CLx/0=
X-Google-Smtp-Source: AOwi7QBZsEPqpeQDjELWLk3PUxUnFqzAEM/wl52JtxJ9o+lEYogWNurU/Mm5j4bBr87mgyDsquMygg==
X-Received: by 10.98.18.18 with SMTP id a18mr4169953pfj.301.1507594582072;
        Mon, 09 Oct 2017 17:16:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id g68sm16272880pfb.120.2017.10.09.17.16.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 17:16:21 -0700 (PDT)
Date:   Mon, 9 Oct 2017 17:16:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nazri Ramliy <ayiehere@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010001619.GL19555@aiede.mtv.corp.google.com>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Nazri Ramliy wrote:

> I used to work before, but now:
>
> $ git version
> git version 2.15.0.rc0.39.g2f0e14e649
>
> $ git status --color=always
> error: unknown option `color=always'
> usage: git status [<options>] [--] <pathspec>...

Which version did it work in?  That would allow me to bisect.

Thanks,
Jonathan
