Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590C01F404
	for <e@80x24.org>; Sun, 16 Sep 2018 22:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIQDaP (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 23:30:15 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:40243 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbeIQDaP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 23:30:15 -0400
Received: by mail-pg1-f179.google.com with SMTP id l63-v6so6709835pga.7
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3HVKraYAnB/I0hAHAUToZFK+O/MkV9jyWLvxlD58zY=;
        b=NTN4MXg9yjG7yr2GQXVa853uJzlfDoI+hfR+Q3ZWMPSDReuGTLyOYyXe2cPBOD0pTv
         +27t9TJ4MrCuuZ7shRj0R5d7WzXn9/UO1+dChWWka3MBsJoWc2e2jW+J9CvNkf0ZeT9O
         I5dYZyczIcxDu3BkodDchRY8SRRYxPE/O7h9WudQ3EeUXfbmIQAvMuBkEX04o8LlsaL6
         CEGqGck8+58vPPN+T5/1iRkG9iTD1djpi3aUL81x9JDb1gp9fgHU1KNjkbSwD7p1cZPJ
         xUoD8oMZEkNm5LGFqObACr8vxcMtnxYaTN+nBcOQt1xZIOTtxGkbSnhECsyFYoaTQKK8
         jptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3HVKraYAnB/I0hAHAUToZFK+O/MkV9jyWLvxlD58zY=;
        b=aTGRM8MohJuxkb9OwUj/XOhM3HG0C52zXb/1+Bnv0rrOnDDy/dOQtPtaSu7Ei3NhW9
         DUp2/kteWs4AFwEaD5TbNAhraSE+llB8y4CX30OtVzv3tmpKS4g4cuJraGTuV2yPNNBj
         iFC1rPyNi2QVaMSjqsvngZuIQD2CBg8/kdAeCQtQJWiUyNAj7saDhiFSmyvXZKIpPGRx
         qi24SjjQf+s37HdcUMpLNxk4IVwxN0glp41EKLu2o/n4I+j+GwjDVrcyhdpNYp9i9GJc
         lxQneUuFqVIJ0KXQWlC5Gd8BqD4Hd8b2K3VOBCbAnAZPCMPIrbf+TTxN6njfrxflDjWT
         na1g==
X-Gm-Message-State: APzg51DEmkDz2QYx6WIFXBBYvwJF87IxyDEzHLt+Jp4VdYsEegxhRbLX
        7j7AxeT6ffLRwUL+BKO06MU=
X-Google-Smtp-Source: ANB0VdbDmeBF7xE3QfQflJKRoFUTYz4yDBzeOvPINew5+qUMv+EDpMcIw6KemfhdSXlGb6SJBa+Gag==
X-Received: by 2002:a62:90d4:: with SMTP id q81-v6mr23142446pfk.37.1537135550723;
        Sun, 16 Sep 2018 15:05:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g66-v6sm18635468pfk.39.2018.09.16.15.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 15:05:50 -0700 (PDT)
Date:   Sun, 16 Sep 2018 15:05:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     John Austin <john@astrangergravity.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git for games working group
Message-ID: <20180916220548.GA154643@aiede.svl.corp.google.com>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
 <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
 <20180915164217.GB88932@syl>
 <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Sep 16, 2018 at 11:17:27AM -0700, John Austin wrote:
> Taylor Blau wrote:

>> Right, though this still subjects the remote copy to all of the
>> difficulty of packing large objects (though Christian's work to support
>> other object database implementations would go a long way to help this).
>
> Ah, interesting -- I didn't realize this step was part of the
> bottleneck. I presumed git didn't do much more than perhaps gzip'ing
> binary files when it packed them up. Or do you mean the growing cost
> of storing the objects locally as you work? Perhaps that could be
> solved by allowing the client more control (ie. delete the oldest
> blobs that exist on the server).

John, I believe you are correct.  Taylor, can you elaborate about what
packing overhead you are referring to?

One thing I would like to see in the long run to help Git cope with
very large files is adding something similar to bup's "bupsplit" to
the packfile format (or even better, to the actual object format, so
that it affects object names).  In other words, using a rolling hash
to decide where to split a blob and use a tree-like structure so that
(1) common portions between files can deduplicated and (2) portions
can be hashed in parallel.  I haven't heard of these things being the
bottleneck for anyone in practice today, though.

Thanks,
Jonathan
