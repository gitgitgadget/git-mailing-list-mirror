Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D80C1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 19:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIOAQP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:16:15 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:54493 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeIOAQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:16:15 -0400
Received: by mail-it0-f50.google.com with SMTP id f14-v6so3972064ita.4
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8C2AlTIOBu3De5uhfKBkMN0xHVzslEjJxMRHWBQsvGY=;
        b=TJrDYB4cqZLMvdARL/CgG94ckinmH8KCx+zEP63Rhw3JjlYlR3SMqA1jPChKbbHSSZ
         DZTO278co00cKo5dtQvK05a1YgDeTR1pOWn01n1WI/SCjzZdAI21fxpa+KGGhPovEm74
         2iOqwEtSjOm1M2V3xxHGzQaXohIbtmxwi8xyz+me9w90I4z37xDUu9jo5650rvBuFRgA
         Qk5AFnYt+5oyIzd34HiKr8Vp06BC2G2hJfPbebuACVqUUQVnSP4uVN42sEIycH3L1Mvv
         TA2tma32U1tTyAcenizKRToWNQWQAHtkMV2hO6m3EgHGkorsQ9V4QmLrsHoImDtfPRj6
         lUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8C2AlTIOBu3De5uhfKBkMN0xHVzslEjJxMRHWBQsvGY=;
        b=sqehuiawHOh9IyMT/yMesoY4MCozSRIhYl9lYSXj7PWXuT3savXOyh9rqc/HgUbhfW
         7TmeJE8uINeALiBVMyU4nc+70gtEPSX02Tn5DBm3cqFl/hM9NCEG2AgsAWeDBes+0oDJ
         OCONA1JDPFwhWOD/jRYbKmKTMAPILbMPkne+Y88e7WPICbzAQzV2/6RYEhySH2DKxrZs
         H0pgM37xvEZpAAtbzJxB57JY2m3FONs6v/QsuhrwbeIUmsfFvqmVAuhGqNLs/V2tWWfV
         Puad0wINDnPHOP/R+R3e4rxOxTbud1L6mKwQEtlZLYsWSCrTshPrkc7MRrGwRqDI1j74
         0SFA==
X-Gm-Message-State: APzg51Cj2OFUqSeKrqjw3ou+ph2JPxvzI+qkxiqSrI7P2l2t6ils8JfR
        /krNHUaKRJS1jl4MDRJPnAmwEA==
X-Google-Smtp-Source: ANB0Vdb727J2sjPaYzTiIV6ZPmw0rBcPtKolG3giptiecchauJjO3iHczdqSA56eBUouictJq04jqw==
X-Received: by 2002:a24:fa49:: with SMTP id v70-v6mr3654419ith.76.1536951627567;
        Fri, 14 Sep 2018 12:00:27 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id d65-v6sm4360758iof.46.2018.09.14.12.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 12:00:26 -0700 (PDT)
Date:   Fri, 14 Sep 2018 15:00:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Austin <john@astrangergravity.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Subject: Re: Git for games working group
Message-ID: <20180914190025.GJ55140@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Fri, Sep 14, 2018 at 10:55:39AM -0700, John Austin wrote:
> Is anyone interested in contributing/offering insights? I suspect most
> folks here are git users as is, but if you know someone stuck on
> Perforce, I'd love to chat with them!

I'm thrilled that other folks are interested in this, too. I'm not a
video game developer myself, but I am the maintainer of Git LFS. If
there's a capacity in which I could be useful to this group, I'd be more
than happy to offer myself in that capacity.

I'm cc-ing in brian carlson, Lars Schneider, and Preben Ingvaldsen on
this email, too, since they all server on the core team of the project.

Thanks,
Taylor
