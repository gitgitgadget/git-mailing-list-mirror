Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E384F20248
	for <e@80x24.org>; Thu, 28 Feb 2019 08:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfB1ILJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 03:11:09 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:43849 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1ILJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 03:11:09 -0500
Received: by mail-pg1-f176.google.com with SMTP id l11so9317369pgq.10
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 00:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJLr4wKi2OzMTPPx5I7d2OuCRMYr1hwYu2IGcHUW0qA=;
        b=PqGzA9egwpFJoVTwc0bTe1axE/cUKLGbAlBIBJ3Xazw/KPYCTaWU3+YK3xXf82JBHZ
         4DRzQIfr4IF/VIOcZkgpNIPVHYlEDQkGIr7lVAzP3rQkt3zt6znupTbNRoVTiu4hKpyr
         qej+fTuOSr/PVLl06VnB+WB6R+YHZb2YsGOGGxew7wYWt79WGWfSeFFdplFp0D+nZAyH
         ZPemZ4aTuXahlTtDT7Ur8cDoX+GXQZIqrf0TWs4c1mGIbRzLNZLoj0yxx9giCW2WICbN
         gwaDbP2eE2BuNHPxuJvFPUJUsiAdG25CJ0CkX2MPRxNqYOLV8fdOlhfIW2tyocpLI8ji
         JylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJLr4wKi2OzMTPPx5I7d2OuCRMYr1hwYu2IGcHUW0qA=;
        b=nCodAi8yH+GsFUXCX4MSqqZpszp6sotdcg5tDYhZy/cRaSAMzQZZhqjOQwV7iJ3IpH
         7FIfdL2UD0Q3ANOj1J44Y3ZzEFjZU9drkGkl5PWB8z2Ti99VW4FbJB3gckpgi7hfAxVU
         8JPYrMhB3sigwRlyzVsVZXU0gewjucze9a9vlfaGwPjetQod2R6NF7VcpyWzwWhN1xcs
         HaIu1moxMcplmpr5z6PAB66MQl+APFPyBrofsSaYoqgP1Jol/3xxYi8chvCFjZTbQ0R+
         VsAzxPj4E0ecwSMbfldMw0Rofvm8+d+C6rcfUeNAvt+yV9500uqjGV/y6lCoKtxknOsV
         xsgw==
X-Gm-Message-State: AHQUAuZLY767bLKoxLjeuXJAhoEFREVq6B4pg11Az3/T7PDc3GvoPYfA
        BFosrWVhl8tL6oA6dqFXgjY=
X-Google-Smtp-Source: AHgI3IaXE41e9m8yjLQLm0ST6i+fOuvcXJMZBNHvvtFwCNwhmnyKHizNikg+6pl88O/keYlR9FCWkg==
X-Received: by 2002:a63:112:: with SMTP id 18mr6932933pgb.139.1551341468681;
        Thu, 28 Feb 2019 00:11:08 -0800 (PST)
Received: from dektop ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u28sm30226032pgn.32.2019.02.28.00.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:11:07 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:03 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Tags from each remote in a separate "name-space"?
Message-ID: <20190228081103.GA22075@dektop>
References: <87d0ncihkg.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0ncihkg.fsf@javad.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 08:54:23AM +0300, Sergey Organov wrote:
> Hello,
> 
> How do I configure git to handle tags from remotes in a manner similar
> to branches?
> 
> Specifically, I want tag 'tag_name' from remote 'origin' to have local
> name 'origin/tag_name', not 'tag_name', as it is by default. For a repo
> with a lot of remotes[*] it would allow to keep track of what tag came from
> where, as well as prevent name conflicts between tags from different
> remotes (and/or local tags).

On the fetch side, something like this in the config file (assuming
"origin" remote here) probably would do

[remote "origin"]
	fetch = +refs/tags/*:refs/tags/origin/*
	tagOpt = --no-tags

I'm not so sure about the push side.

PS. it would be nice if "git remote" has --no-shared-tags option or
something to do this, assuming that it works perfectly well.
--
Duy
