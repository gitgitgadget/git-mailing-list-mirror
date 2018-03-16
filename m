Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0226C1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeCPT6b (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:58:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42553 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeCPT63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:58:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id a16so4555505pfn.9
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=loW/CM3F5UH0UKW+frry4m3zvTb6TMJvfoVBA/2oc3c=;
        b=XuJ1yzCxNcHAqKolkol7UBYjduf/qfLxOZQScB00s7nQndyUpH5xDZGqx3vXNCX+3/
         F69RIxIa3PXJHOMvUGZC/81lmLzQ2j1OAgHW6ikKmAMBGy1g7YjcX/HwVFFQDPQ7tWt+
         mOowGmuLr0iP4Mz3dslLiWZMwKrEMwxQ9HEXr+ardKzSE8Pmk1l1fGnOnuPBnkAqGgBd
         WvGEBfrlV+qYWl4th0iL6rSHTpNwuOurAVzGxaMwfKToi6yWHzlcjx7vYip/RbHTpwcC
         rSaZnpV9NKMSc/ltp3IhIofIJBaBi/MvvC7miVbtKD4jbeZ2x+aa/G0bk10g7vKyLlPv
         Pg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=loW/CM3F5UH0UKW+frry4m3zvTb6TMJvfoVBA/2oc3c=;
        b=fhYfAdrkn0OA0Ekgnr0ZLTIbRrVJGh3/qvtGuy7r3Guxyu+2vTpc44L+ZeH3JIP7TU
         9GJxHZZqgDpup6bCUV2DkFLQe4/fuZCRjCC1zuxplLXamuMnM2y0HaZ2oz77q41qvrYO
         ZXELGKw9XHnR15atUlA8IQZuKnd0MPNg8C+igFFumsZeKxb/Pa+3RV5EUK281fRzVFLH
         QDG/cEwRmQTiG6+9/elzqfpIsfq+1xiBgNpzZSZPyRxt0T4hgyHrFaa2l1fll0J6SpD2
         UGBD+g+yqKJ3BzaIPsJfL+IEZghiFkJZQe0kxNjld7T0INWB6CRL+5+uavFkopqVh7L5
         lxUg==
X-Gm-Message-State: AElRT7GeOyxd6TcsAAX5Upve0cRScZ+EprUzOqMk5/jtQ5gQiARW90cs
        cs6ZdFo+bATa6jKa81EvBCwiiktk
X-Google-Smtp-Source: AG47ELswxMljSmop7wUL62nvn7pS0140oD4hRsp0J2eK5B9ptL9kcplmqV+MRo5rtr1nHYTWqr86nw==
X-Received: by 10.99.109.139 with SMTP id i133mr2335978pgc.194.1521230309021;
        Fri, 16 Mar 2018 12:58:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s6sm14998587pgn.59.2018.03.16.12.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 12:58:28 -0700 (PDT)
Date:   Fri, 16 Mar 2018 12:57:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Briggs, John" <JOHN.BRIGGS@aei.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Subject: Re: getting fatal error trying to open git gui
Message-ID: <20180316195756.GA151588@aiede.svl.corp.google.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Briggs, John wrote:

> I just installed git for windows 10 and am getting "git-gui: fatal error" "Cannot parse Git version string.
>
> When I execute "git version" in the command prompt I get
> Git version 2.16.2.windows.1
>
> Everything else seems to be working. How can I get the gui to work?

That's strange indeed.  Why is Git capitalized when you run
"git version"?

Thanks,
Jonathan
