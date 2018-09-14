Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E66A1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeINXsp (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:48:45 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:35139 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:48:45 -0400
Received: by mail-io1-f41.google.com with SMTP id w11-v6so6835455iob.2
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HFk7eJM70I+KsgZjniVHeLLaSVet7Llh+1SbEupXJc=;
        b=FEg/h8cDGD1IIr4boge6Z1Dfaz4qdQtd3wDDQSv90ZnRTsERTVF3J7oIrZmhioXNMI
         UduK5Z1/OoDKebr1Apbq+gNyGDy2Epc+qNw9rUMSFIusBvH0UVBIt6+ccYCHnk+DtSuv
         FPm3IPxufjzWvv687xVk5lSq9W8AkD3f3K60Ul38xE22bqqk1bhKSKLlCVNUa0ALjP+o
         wpfWv6viqhYseKeQjSu0MPw4lgC/E0cszDTumA4ew2ra3UngVKLfqrM0FWZBpVzBX9Md
         as6OMzBB7+NIB03AicsdxsDToHp/7Mejjluk6R+IUkmvudMvQhALjr2o7ixVeRinLD2v
         4dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HFk7eJM70I+KsgZjniVHeLLaSVet7Llh+1SbEupXJc=;
        b=OhdIIeBaYsVcunfo1fEAqptjE7vRp18Nbb9XAfjM3O4l9XySeECrtothDNDLbQn4bO
         ZF3mKkxchXxbpdb9+IdXDpP+XPyMZNEaEl/OVZm+KvXp32n0q/T3QV0Gn7J68mTGz5fc
         zTaaVPlO9nS0ACfOhDHtMAeGDaVicrxsMZTHPYUsXKakUbe5Hr/RCietqpxSfWxFm1Gs
         RwqXfDKLpYPVyw98/N5ty1v0FLiO2rAmdkrGiux2PoPc7IqVFaPbgUmETu5IQvm6kkZq
         7alo5RkE+z3abX7ljaNjkievgFezjp3aawdNuCXD5ceoEw7JzsgaByUFjsmb84vS3HQP
         qZGQ==
X-Gm-Message-State: APzg51D8ws0rqsJCJjxw04ik40qoiXLT9PTL32JYjlD03XnV6STg4iB+
        Xl3M/gTcEE7cnpU7VMt5GffJ6g==
X-Google-Smtp-Source: ANB0VdYXj12T7yASPNDTZPZlNbw9L/BhovJwOhWdFi4e3m7/qmVabG5XMThiTreUpXgg/5oRsTzd2w==
X-Received: by 2002:a6b:9e91:: with SMTP id h139-v6mr11556985ioe.185.1536949982769;
        Fri, 14 Sep 2018 11:33:02 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id p190-v6sm1055235ite.0.2018.09.14.11.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 11:33:01 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 14 Sep 2018 14:33:00 -0400
To:     Mikkel Hofstedt Juul <mikkel.hofstedt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: spelling mistake 'rerere' on docs/git-gc
Message-ID: <20180914183300.GF55140@syl>
References: <CAG-YsNbX-23+LMR_Zd5Z0Ln64vz-HQRU_YkFSnODBWuAvcRW2g@mail.gmail.com>
 <CAG-YsNbh1AQvf3FCQscNDviQqyC4FFqx-VruXrpeCgjL953agQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG-YsNbh1AQvf3FCQscNDviQqyC4FFqx-VruXrpeCgjL953agQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikkel,

On Fri, Sep 14, 2018 at 02:31:04PM +0200, Mikkel Hofstedt Juul wrote:
> See title
> in sentence:
> ...invocations of git add, packing refs, pruning reflog, rerere
> metadata or stale working trees.

I think that 'rerere' in this case, is correct, since it refers
bookkeeping from the 'git rerere' command [1], which "reuse[s] recorded
resolution[s] of conflict meregs".

Thanks,
Taylor


[1]: https://git-scm.com/docs/git-rerere
