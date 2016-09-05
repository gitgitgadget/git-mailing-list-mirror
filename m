Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897F91FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934866AbcIETWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:22:00 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38007 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbcIETV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:21:59 -0400
Received: by mail-wm0-f46.google.com with SMTP id 1so154139519wmz.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xn+oNkOcxCBkJGD+jQBtcp8wX27HXMVOV0TPAxqVM8U=;
        b=SgxUEoovq/5ZW0K6UbaAkTX87TQle0iYLABCD6y3MScrMPrgGnT5d8CQWOYBhW4APZ
         qp1CXuX4KlutAkMZQzLLeq9UaNjBlMAGgAKedjc9OCibNLM902Fx3q8z9p+pABaONADe
         zSUdWjZnJV0Yooc7aJU+36jhaIWKp/vRo+QmavrfHeTb0JA+lbMteP2EeX802mjTr9CI
         5zXgW+VM5lf4TOlwvdSXdOZ2BGjPzPb7Dir91NDPGpIFQTrTgyvWcxR8Al6U0TuVIrDN
         9oyqTY4JZ5WxIp00WBr1q9oHT8CA66S/mT8eTfKBzciJW43XAFPBT3NvNVGVHTBOMIpX
         Hu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xn+oNkOcxCBkJGD+jQBtcp8wX27HXMVOV0TPAxqVM8U=;
        b=dH8/ax+nRdQkl5BRY5zuFzOZlXdS7PPb1gLcUz3fuy8mwN8J2rTaQSC4a/ha9PDdhU
         nGTUCyp0IPP6eau59s9gz7YCE1Lcnpj3UuhXUG2WY8k+u3ytn69pAqiHuiWYHkzA+g6r
         3GTIv9oBFHYoib0LwPPv9pqrik+3Eqvpyd6xMIk9cbjtD2MX51S4/lCqyxuYMKaDJzp5
         WdoG8IIYviheTRGOlbihXlMPPN+Ojg+WgMDxr/uXUAxsiRqSRz4z+eji6urggQBQui+h
         NiKc2ryeWheo+m9V8rJCw7MDd0GIbT7dd0un8uakOTcNs9bdOoDJs+utzF+QI+CDC6sU
         Azvw==
X-Gm-Message-State: AE9vXwNsEZkuvTB2jqzxbc8es5YdbKtRh1dGVlzhG2FsiF2KVLbm2EENX/8utKRvcHREVQ==
X-Received: by 10.194.92.77 with SMTP id ck13mr7572748wjb.11.1473103318381;
        Mon, 05 Sep 2016 12:21:58 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id id1sm29144205wjb.21.2016.09.05.12.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Sep 2016 12:21:57 -0700 (PDT)
Date:   Mon, 5 Sep 2016 20:22:02 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 1/4] add: document the chmod option
Message-ID: <20160905192202.GB8254@hank>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
 <20160904113954.21697-1-t.gummerer@gmail.com>
 <20160904113954.21697-2-t.gummerer@gmail.com>
 <alpine.DEB.2.20.1609050944070.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609050944070.129229@virtualbox>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/05, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Sun, 4 Sep 2016, Thomas Gummerer wrote:
> 
> > +--chmod=(+|-)::
> 
> There is an "x" missing ;-)

Ugh, thanks for catching.  I'll wait a few days for more comments and
address it in a re-roll.

> Ciao,
> Dscho
