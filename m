Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E171F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeIQT0P (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:26:15 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:55546 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQT0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:26:15 -0400
Received: by mail-it0-f44.google.com with SMTP id d10-v6so11184574itj.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hd8+hPjMz2mzDUhwgTTMdtCMIhXMF+l5M3bBn5tlWgM=;
        b=eFqBKD479tl92uqz1JGN45y0iY6ld/rOC/f/XyP4Bb1wcCp2GQb09+2RnjENEQTQ6T
         wM7RqKMsfoGr3Gns+WVOUE62u3bLDvBqaIXly6EtwyBOQD4hk+j+xZm8XoDqMcB2PiEu
         BbbHcZLdNWcFPBYeD1VLv5c3l4P8Y305bS+QMalVnl1mXXv5+vOldEPzsoHG23dNcYpQ
         P+1+5JV73bIgQTu6xIS7l+wUlbpFPL0VV5dChTOOla5NLuyQnq9EcDQaO3/eh5LoaEAQ
         A/NrpvXGXIy2WRgmcfiuZB1KyWCHlL2jbLFSZcLB8wamo7ZCaOty3uNOPHHWh5MRgJ1z
         MVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hd8+hPjMz2mzDUhwgTTMdtCMIhXMF+l5M3bBn5tlWgM=;
        b=tZlXxPmgk5EO0cBaYPx/cH16XkENffYeOsVc8Vr7D7XCeTBe/+7mDU/DPjFij8og+2
         N0TeuPf/le6WHUoPU4VBxB4TkqHUWn24W9a+Jxcs/hEBANdzvvKurBBDtzYR0HULQuMi
         eG/T3ninrihkAc/dgQwEwmDwrA3Jd7TC3QE/IMsEA6MHVFbMDK3F7BLWC9wIo9vT46KK
         PLueV8OLmRJapSkJQDcTxFL5yTRa1CP9yXQLYZo7g2fms0S+q1U5+oh4QTKR6cuslfEf
         0Tb9sKN6aN8Ju6mvmDlnw2t4uLi2JuzuPUxjOyGijg3R7Wm+hy27gPQDy1Op7MTAzvB7
         hVQQ==
X-Gm-Message-State: APzg51D40MtZ5S/C9pWwR3v1HCAcy2SuhvHbupkPEgr99DmWcxnqJzVJ
        4lNqYLBFazLx5XLnhDDFqf6QCA==
X-Google-Smtp-Source: ANB0VdZqKGAqBzGR0DdHPNozWBPRnrQu3XMWg8PHoGUa+egiqiX4FHtxZrZFilfrRMJHl952NE42/g==
X-Received: by 2002:a24:400b:: with SMTP id n11-v6mr13054082ita.2.1537192727113;
        Mon, 17 Sep 2018 06:58:47 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5363897iob.88.2018.09.17.06.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 06:58:45 -0700 (PDT)
Date:   Mon, 17 Sep 2018 09:58:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     John Austin <john@astrangergravity.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git for games working group
Message-ID: <20180917135846.GG71477@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <87bm8zlqrh.fsf@evledraar.gmail.com>
 <CA+AhR6d4p2N06t-w62A2=wTH0x1ipt3x3hN2mQKK-Cwj0rMX1g@mail.gmail.com>
 <20180915164217.GB88932@syl>
 <CA+AhR6fjtzWyRtcgRkedK=RWua8_rmiqkDR+my8u9BHLfjhRMA@mail.gmail.com>
 <20180916220548.GA154643@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916220548.GA154643@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 16, 2018 at 03:05:48PM -0700, Jonathan Nieder wrote:
> Hi,
>
> On Sun, Sep 16, 2018 at 11:17:27AM -0700, John Austin wrote:
> > Taylor Blau wrote:
>
> >> Right, though this still subjects the remote copy to all of the
> >> difficulty of packing large objects (though Christian's work to support
> >> other object database implementations would go a long way to help this).
> >
> > Ah, interesting -- I didn't realize this step was part of the
> > bottleneck. I presumed git didn't do much more than perhaps gzip'ing
> > binary files when it packed them up. Or do you mean the growing cost
> > of storing the objects locally as you work? Perhaps that could be
> > solved by allowing the client more control (ie. delete the oldest
> > blobs that exist on the server).
>
> John, I believe you are correct.  Taylor, can you elaborate about what
> packing overhead you are referring to?

Jonathan, you are right. I was also referring about the increased time
that Git would spend trying to find good packfile chains with larger,
non-textual objects. I haven't done any hard benchmarking work on this,
so it may be a moot point.

> In other words, using a rolling hash to decide where to split a blob
> and use a tree-like structure so that (1) common portions between
> files can deduplicated and (2) portions can be hashed in parallel.

I think that this is worth discussing further. Certainly, it would go a
good bit of the way to addressing the point that I responded to earlier
in this message.

Thanks,
Taylor
