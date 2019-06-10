Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304D41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbfFJPPP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:15:15 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35633 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389999AbfFJPPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:15:15 -0400
Received: by mail-pf1-f170.google.com with SMTP id d126so5502581pfd.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L16BzJQzSp/Cct5GHE+ayyq8SS/eRYz7KUO7Zttn/1I=;
        b=ePctQqLnwkV1BQTW/CaF/vbbSKxKYDpg8n6wL1eX0mEl+vnKOD/lGNzk0TH+8KXv85
         SHRZuyiOdALH4e0dMX4PGbrkwgK7ipKr59rIy7i9uKGMS36lts8j623zGswC94CRQdp0
         2eSSRhk4ZxeVX1I7Ztzl2uSsMWpBne/WOi96CGF9rowx4zi0tHVyH99HHxxFg2vvLKB9
         okFiejbTUTTkJ8hu6znotBPRzRWqGlmetvFyvnzJeNYf5DUQ023TCdXuAcMXgIcGKGwZ
         zLuXxvmGyAQSJ9NnSrMprB2GHwLtW391ZNoFrkFaGRbV/n+Nf3tOKvahVYLr3pUG1RZi
         Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L16BzJQzSp/Cct5GHE+ayyq8SS/eRYz7KUO7Zttn/1I=;
        b=NrLIPXp+91+ywadutUQ96hRM8iMnuiFy+EHQqyPIOS7zuJuqDJy4fT27k3aw0oSakV
         ZSKdCHB+BViPbkvPvrc++fSryd3wZhWyB2vzdHLzuAp6MSawjgbTkFntKjC/SLe8PJYZ
         14CuLgtaTvPmpeDRYKnO8/8LbIpRq88lYyUEY43Scikjh5y1ljP62kIlcf+vni022ugZ
         l9L1UDQph7EOWiCdJce9wZncUGZD1hvkfrkt6RGC38g1TV6FTqn7DqofdesVSIIgfy9F
         Fi+TjDEEFikLONrzqOsLChxQ9pvjhWkeE/wDxMiJD78L/2W/JlbPx8E4vwPw76K3kFPV
         xL0g==
X-Gm-Message-State: APjAAAWIdYBy5cfbRQlUa0qq8CSYG4psKH2d1Q6cXLQepMGxGfaAX07Y
        GlmGT4dDr1aJOErfJN7iuC07kg==
X-Google-Smtp-Source: APXvYqyxD5gwuOA0H1/dsB6lzRWhJKbJQ6m24NpYUxtLQfGrroafXHXblr4ZkCv9U6VeDZ1+D3zgeA==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr33687117pfi.207.1560179713819;
        Mon, 10 Jun 2019 08:15:13 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id w190sm10841039pgw.51.2019.06.10.08.15.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 08:15:13 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
 <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
 <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
 <9ab619bb-9deb-4e57-a3ad-9e996425b783@google.com>
 <09bc8c7a-bab5-7cdb-75dc-f7c45a4dbaf8@google.com>
 <9018d6bb-3bc1-824d-e61e-e37bb1587640@gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <8fe53b23-1fbe-882b-f52e-9b02fe6cba42@google.com>
Date:   Mon, 10 Jun 2019 11:15:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9018d6bb-3bc1-824d-e61e-e37bb1587640@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/19 8:57 PM, Derrick Stolee wrote:
[snip]
> I think you should just make the test be complete by
> checking a post-condition. Please see the inserted lines
> below (which _should_ work, I haven't actually ran this
> in the test suite).

With a little massaging, this did the trick.  I'll roll the patch into 
my blame-ignore series, to keep things simple.

Thanks,

Barret

