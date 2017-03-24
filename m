Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3B920958
	for <e@80x24.org>; Fri, 24 Mar 2017 05:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdCXFBD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 01:01:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35511 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbdCXFBB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 01:01:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so843967pge.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6U54lVnWDEa/1MZT8YYpXO8Csq9+YB6OWbxVJPY+cUg=;
        b=Q+CNTXr4C3D83wPyv1bbdBLPEH1aw4PllQrd6qt3ssJCxnbT35XLGYL0aRiOy1AUfs
         RvmdgEUZ8wAFwLia8SfQFFq5ZgcToJS9VUboFeEdLEFZFgxAmr9TglXOY8rkgMKjCOjN
         GDCKZlhU2zuznldJWGxhhDpRrGcLSAMQHXmhrXS7HJdW77y7j5YFIRtQA/n3NwG2/VNK
         +bxhOq4J8OQNAXF4X9jyOG2X9RcVuIHyHcRtoX8iVfSW+WEHsl4WO5iSau5qUyXTpTJH
         x3Z8gCruvDoW9vEJgwvoxnNAFaq/GJjLATTQns/5EUPjLQ51oF0aL56YLpjbxlqX+y9m
         mc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6U54lVnWDEa/1MZT8YYpXO8Csq9+YB6OWbxVJPY+cUg=;
        b=PTQE3JLz13Jjcb9qusXrOTsNb6JXCeZ2QwJcuxUrMISRNwKngH6lycojVhuveAOkxF
         w3s7EdETnbbynFh+f+T0jJDdnXkdme4S77NIl8+5S8kNYjgCDnaLJXKHUTQBG3xZA83l
         UJ1fqVJJEZzTPpU92qWb78YxGls3kmexoK9C/Tdu4g9Ix5eMS8RbFvcNg0+2usE0y6fI
         ZQl181Qk5iMrhsiNQf/Djp6QIHimSRFYjFrUacpF9WsckPC6vqGGB/skmHI75BtT57Dg
         rMPggtVxI4UVLHTjFgTao8pYSHfwCfEePGz1CoCjmmWAOd/1N24lHi1fNxPLKq0sTney
         C7yA==
X-Gm-Message-State: AFeK/H2fXMtzXx4CSMs6PY0VmX1CMtwM7PFVifLtiREYmNYaV9G8Vl9UXBUcrGhGMCbiyw==
X-Received: by 10.99.112.22 with SMTP id l22mr6836924pgc.94.1490331660257;
        Thu, 23 Mar 2017 22:01:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id t133sm1395367pgc.24.2017.03.23.22.00.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 22:00:59 -0700 (PDT)
Date:   Thu, 23 Mar 2017 22:00:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] branch doc: update description for `--list`
Message-ID: <20170324050030.GA7558@aiede.mtv.corp.google.com>
References: <20170323120326.19051-1-avarab@gmail.com>
 <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
 <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com>
 <20170324004858.GE20794@aiede.mtv.corp.google.com>
 <xmqqtw6j8e7f.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw6j8e7f.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
