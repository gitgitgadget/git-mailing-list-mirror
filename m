Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EC420C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdLADmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:42:17 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34022 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdLADmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:42:16 -0500
Received: by mail-qk0-f169.google.com with SMTP id d66so11696069qkg.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=29tKmFk9/i5TN8dcxrnANz7SK7C1RBkedfgT+G3GweI=;
        b=Ej+seHSgSG1+g77bpPKkHcwZFtu9Osx2uHDKtCCKdcZGUA2hCho0sQjuJYe0lpG1d2
         NAjz/tENTJmvzsoyR8PNXt5nBKuIBcPVKrS2YfRasZlfO+NygHaGXC5XBo3GnhGvfJR7
         lcd3CyOPUysO4/ZQxrCWgriRaDXLSsHun3bUGfFQXfE8mSEbeMGRnY3CZhjCH9dAMyU9
         KqcxyFb0Qt9czUw1m4GUNLhXDJgN6nXPGz5xwkG2UBYzfvNuQMTnv5eqyC1iil/zlJqs
         xFRmLR3+aFdvrHA2Kwci9GdIkfou6Irks7r54089B1b3+MhfBHHV+TVQqqJSiBXes/5C
         P1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=29tKmFk9/i5TN8dcxrnANz7SK7C1RBkedfgT+G3GweI=;
        b=Vi+hKG/v1VnaGPL82jzClopUnF0HC9ujnqZlsLc3WRu84e/pVwO5YgZNJYd2QsVOlA
         aQUnVJivC8MtciR5T9zAWKOpxFHQfvk0zga6sRaf3AryhzhbVCJOM5v4n9TXmaxmTYDZ
         ZOa97wIbONjlX8n+s/55n5GB/fJLnbXefIVWd2LcX6MxfcGziEt+6ObL0r3Nh2twMfBX
         qd7izVlLb+JQoIiklLy0qGDuxxiMgcrBJDVWWQKkvWWhD5fT83tKFBp0KxnrB4/bvxSJ
         7k4itKwhD7Ks+RjtzgjtLtGUt5olfDDIzuKOo0B3lTOfAStQSf8uwBEo4+oGKXVxejcc
         cCew==
X-Gm-Message-State: AKGB3mJnlnEHebGVELjo62yBPFE88+THa9QvYaIKidKMP95/NZwk6uNM
        VVxbg9eAUi8GULAX4RaiqeM=
X-Google-Smtp-Source: AGs4zMZHG83dYGQV9wpQb6FCLG6osXFami12fACjOs17jCbQW7E9Wp8OiSdFTLbWM9h2P02yJeXaBA==
X-Received: by 10.55.98.134 with SMTP id w128mr5735093qkb.292.1512099735870;
        Thu, 30 Nov 2017 19:42:15 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id l52sm4148179qta.12.2017.11.30.19.42.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 19:42:15 -0800 (PST)
Date:   Thu, 30 Nov 2017 22:42:12 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/2] t/lib-git-svn: whitespace cleanup
Message-ID: <20171201034212.GD3693@zaya.teonanacatl.net>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-2-tmz@pobox.com>
 <20171201030453.GG20640@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171201030453.GG20640@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Nieder wrote:
> nit: it would have been a tiny bit easier to review if the commit
> message mentioned that this is only changing the indentation from an
> inconsistent space/tab mixture to tabs and isn't making any other
> changes.

If only you saw how many times I typed a subject and changed it
before settling on the terse version...

How about:

    t/lib-git-svn: cleanup inconsistent tab/space usage

?

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
How am I supposed to hallucinate with all these swirling colors
distracting me?
    -- Lisa Simpson

