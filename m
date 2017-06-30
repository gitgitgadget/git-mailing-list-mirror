Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E230B201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbdF3VtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:49:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35098 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbdF3VtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:49:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so18320088pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GE127J6d3dCq0S7NvWurkAvXzbP851mbRbwnnXv//iQ=;
        b=n009Qzky8k7Z+5zq4cdjbIr6aKviyVgpPkkrUitS+zufVmt+BfCUWqdNEaStpDyGkz
         fj8DCAP9/6L9PNPivljDlHwU65U7FUJ694hylHHfqiWa6ErKvfYaxwBt9mGhv0VPmfIj
         t53UB65nCzDJbOonVxW53xLWoQC+tqcuN+w9dQsxabrLTdPefL3QHNkpb14VKEmA1TUs
         tKdWXLKBD16h2hghB7E4SEtEiob4PmGyg+lbCw0IhLMZc1m0h2esALuRUhJwcrIT4/Yz
         4vOHeW8kcXzaWxu+lb62yaCPbsUa+vU/pBkwk5IUWuIdtzzPRAxPz/LFEw7owAncWnDO
         UCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GE127J6d3dCq0S7NvWurkAvXzbP851mbRbwnnXv//iQ=;
        b=ZknA7uTjrQSvq2xjnZbaOoO1ukzYrBIZyTbCh/oFMv9Oe5IDf9xYK6yabREG6ZA6hr
         tp2p6fMgvLgM5nHK8sWA+jKB1ECbpPAk+PXVIk331OYeI7q+/PRlbAN0jUc9ITFsn6iO
         eqXS81e/EoCSRVc8I+K8R4T3aqNe77DlhVHa+8urCYow0A/8xlunN0rE+WxZYI8AQX7Q
         vEbUxIF4RNb7QeiQptt85C4cWLWsMBDjOJF2v3d3dAtjQSUM0dQ5BQsHLpmaMCkN0TI7
         071WYFalAd7rZpoHofBsBVoYskPCLJlV/tCvReF5L65vGX3vvyZuke6oSSvJCZok9Tia
         faCg==
X-Gm-Message-State: AKS2vOyFl9XZLrUbKiw5FLAKJ8EHdsB5cG1937lN/DPaeIqWyh21He5m
        PcdyPBtCSIQURg==
X-Received: by 10.84.169.4 with SMTP id g4mr27074741plb.272.1498859349967;
        Fri, 30 Jun 2017 14:49:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id a29sm22301221pfg.30.2017.06.30.14.49.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:49:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org
Subject: Re: [PATCHv2 00/25] Reroll of sb/diff-color-moved.
References: <20170630000710.10601-1-sbeller@google.com>
        <20170630205310.7380-1-sbeller@google.com>
Date:   Fri, 30 Jun 2017 14:49:08 -0700
In-Reply-To: <20170630205310.7380-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 30 Jun 2017 13:52:45 -0700")
Message-ID: <xmqqo9t5p2nf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This (obviously) passes the failing tests.

I should have spotted why the rebase of the previous one did not
work myself before bugging you X-<.

Thanks.  Queued.
