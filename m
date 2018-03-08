Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980091F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeCHQag (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:30:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46266 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933560AbeCHQaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:30:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id m12so6274873wrm.13
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhkWKLPKZxY5sOkYEoZJibtyY3nsUIOBMIEoxDL9XJs=;
        b=NYwzwXIe+EIgOA90spNLfeSXA5xfrZUQKF8v2sMdg+7KdX2aD5AvgShY/CyAmO7AUl
         U9Vja0uCX164YHxBVg94LqBt0XcNiyrX5XGrjhIpnukPthpI61HUj6V4PgZdfTkWQgh7
         RWLQcvURZ/rBWcmcPYONy96DllQg3xZBY8WGB3Dm8cjkkHqSSx1BgJRuoCxCy+nWgJA7
         ETaJn75ae+qdKMMHUsjebKMjTJSK+Cpch6tt6SeqlGj+UUEmJfZ6R0RVXgWHFgL7F9W5
         GQWJEVBH02xpa+W/2sV8FHJ2AM9R4X47SzZFsajT05ib7th4w9Pq0EdNwCUJrSA1OTCC
         eSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhkWKLPKZxY5sOkYEoZJibtyY3nsUIOBMIEoxDL9XJs=;
        b=XB9Hu08QqysoWio74js9VJzCVrfjmP6aGTVMb/+DvHRTmjnpOuYxOTQp5BQ6qeFw/w
         TliivcjhpSernffEXysLwEB0CDv8FmYPXrl552Djwl6oTUY/L63fbbM2sLlcXy9hN97/
         w/TkRPFJ7jpdtCRxAG3TkD/J0nII9sVml1JqH/WOP+In8bQppRkzithm3KbJCB7a/ad2
         gxJoYRD/+5OFHthuGM8tqu6nL4whUemG5+MnD/NGMa1yHMbCDqDJymyPRWPJWUg5eWn1
         Iuj8HS7Au1zclj1yQbYk5NPwe9cbwO2pFfwhKSo/Ha82C2XrhBRrwqocde3AWWDDGrpP
         8tdA==
X-Gm-Message-State: APf1xPBfHd7iTbF1TYg55tk0RA/NIFKkXp4wIh42ObS4TohuevT0qDVm
        Jdt6iW/9U3lj7n1r9XdOlRo=
X-Google-Smtp-Source: AG47ELs3tvhs6CimI378keCRpsBQHSA4ojsS+LJFMEj42drpXwq572hwVLjTHLFLAd3jPVRlZyYq1w==
X-Received: by 10.223.174.194 with SMTP id y60mr22420932wrc.202.1520526633989;
        Thu, 08 Mar 2018 08:30:33 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id p78sm21551978wmg.47.2018.03.08.08.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 08:30:33 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Cc:     phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
 <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
 <87r2oxfmwo.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <1abcbc94-44b1-f729-686f-58efba3f9dea@gmail.com>
Date:   Thu, 8 Mar 2018 17:30:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87r2oxfmwo.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 12:45, Sergey Organov wrote:
> 
> > > The only thing I wonder of here is how would we check if the 
> > > "rebased" merge M' was "clean", or should we stop for user amendment? 
> > > With that other approach Sergey described, we have U1'==U2' to test with.
> >
> > I think (though I haven't rigorously proved to myself) that in the
> > absence of conflicts this scheme has well defined semantics (the merges
> > can be commuted), so the result should be predicable from the users
> > point of view so maybe it could just offer an option to stop.
> 
> Yes, hopefully it's predictable, but is it the intended one? We don't
> know, so there is still some level of uncertainty.
> 
> When in doubt, I try to find similar cases. There are two I'm aware of:
> 
> 1. "git merge" just commits the result when there are no conflicts.
> However, it supposedly has been run by the user just now, and thus user
> can amend what he gets. That's effectively a stop for amendment from our
> POV.
> 
> 2. When rebasing, "rerere", when fires, stages the changes, and rebasing
> stops for amendment. For me "rerere" behavior is rather annoying (I've
> never in fact amended what it prepared), but I always assumed there are
> good reasons it behaves this way.
> 
> Overall, to be consistent, it seems we do need to stop at U1' != U2', at
> least by default. Additional options could be supported then to specify
> user intentions, both on the command level and in the todo list,
> provided it proves to be useful.

Just to say I agree with this, `if U1' == U2' then proceed else stop` 
seems as a good sanity check.
