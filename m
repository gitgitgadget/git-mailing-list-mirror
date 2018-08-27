Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF6B1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 13:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeH0RRZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 13:17:25 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46805 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeH0RRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 13:17:25 -0400
Received: by mail-qt0-f177.google.com with SMTP id d4-v6so17900104qtn.13
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wwPcVLALGmLuaZiKdaiEAKc7OB7RugHQK/gOEbUxAXk=;
        b=Z0p5zQOrfL6BQE5hIkbFAVQ7pgbHLy47b0K5r5Tma7CS72NyCSrSM3hhz0ADMlhKQY
         Lfl0+AVP+Pv1I9Lbh2m99/U1dUCLlFbIsT/TzjtgC9o7Imql7e40W5YW6/rAmfEyluFk
         H6HGe8dJDRJ9497IJuTYfvMeCnrnphRGo4gOkvncx4to8CUzL1jJ8DNkxKlsXVPMORm3
         b+Ufv5QH+EFWP2NN4dB3BfHPoPvUIHKaZYdkjFBdTGatZubwGQPU6hob3RYE5hehl/gl
         pK+/EoGaR/KkhYwEtFwBGTBHlC5MC6YWeNAp50bq9YNq0cTKihQ+mTEnv1yQtqNfLb8d
         WTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wwPcVLALGmLuaZiKdaiEAKc7OB7RugHQK/gOEbUxAXk=;
        b=Nj6A1afQCVzU0zhEzu+AC1k9YI/UpFrG06vLIjwMO78NkA6DqF+cFOKNhD98z/oi/+
         rE5K+1W5aoqlw/XcpFLJBkx/soWLlR/0WGbygbCOEAZlfkfJoiIaKidWYFs9tHZhvMaP
         lTFfU3ULmS6GzeNgzzpoUdooWP2kH1zwq3AwUyXsvpWFNJuTd+rzqB9JTpJB6LgfeeUI
         8lhjKZ41ypf7EaBAGwgC77eSVRVX2JI8/pWHS8ztULP2DU6Mh4YhtaZqmXGBO+LnXpVy
         CpyOKUy3QDiP7OYuEOOPcL4X2RfYQrK5MoI5bcBCohhIJLpahd7NOxuNF8KcGOQ4HE+5
         h/rw==
X-Gm-Message-State: APzg51DZYD+OCyGchj/BrI1dt9TBPJhdWJuhX02uuRIMfCEnrDPVZNbD
        SJbpNJrQ557zFgVpBeWKRUHzcF5m
X-Google-Smtp-Source: ANB0VdYdocP3xryLTU7UyhSdjibg1mDCQxAUZtMmyqQJXaiDoW4orVDMkxyvTohtx8sePAiQbMgJiQ==
X-Received: by 2002:a0c:becb:: with SMTP id f11-v6mr796507qvj.217.1535376644503;
        Mon, 27 Aug 2018 06:30:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:10b0:d7ed:482d:ab9b? ([2001:4898:8010:0:f9e5:d7ed:482d:ab9b])
        by smtp.gmail.com with ESMTPSA id n41-v6sm10263093qtn.73.2018.08.27.06.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 06:30:43 -0700 (PDT)
Subject: Re: Contributor Summit planning
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
 <20180813171535.GA8476@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f0e85ed-6402-65b2-442e-67a1a7a7486d@gmail.com>
Date:   Mon, 27 Aug 2018 09:30:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2018 9:22 AM, Johannes Schindelin wrote:
> Point in favor of the pure-online meeting: the informal standup on IRC
> every second Friday. I really try to attend it (it is a bit awkward
> because it is on a Friday evening in my timezone, right at the time when I
> want to unwind from the work week), as it does have a similar effect to
> in-person standups: surprising collaborations spring up, unexpected help,
> and a general sense of belonging.
>
> Of course, the value of these standups comes from the makeup of the
> participants: Stefan, Brandon, Stolee, JeffH, Jonathan and other *very*
> active core contributors hang out for roughly half an hour, sharing what
> they are working on, exchanging ideas, etc.

A focused aside, since you brought up the online "standup": it seems the 
IRC channel has been less than ideal, with people trying to participate 
but having nickname issues or being muted. You also describe another 
issue: the timing. Having a real-time discussion has its benefits, but 
also it leaves many people out.

One idea to try next time is to create a mailing list thread asking for 
statuses, and each person can chime in asynchronously and spawn a new 
discussion based on that status. Perhaps we can try that next time.

Thanks,

-Stolee

