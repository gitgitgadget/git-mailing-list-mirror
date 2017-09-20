Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83284202A5
	for <e@80x24.org>; Wed, 20 Sep 2017 08:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbdITIDN (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 04:03:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33896 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdITIDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 04:03:09 -0400
Received: by mail-io0-f195.google.com with SMTP id g32so1604774ioj.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f9cBa6zX+pcpqjZYol9p3LfIQ80fDdPt0HIr/ZwqwXo=;
        b=c530VPYw+cRfrSjx1JTfSHWvEhIE+49vOXsbZBoNFG9uTrvoo9wByQIfHajaN0qDFj
         SwSt/+a11AiDjPRencg/W5LNHHE4ENutoAXqGnzkvfTrty80+hueJePIHWFg3+1xMLc3
         bFiqzNeZyQdxLgwSfrMmSQSZHGTJ47GC4AhZwCJu382kiKYidFESUTv7ZbJNc1ZqA2d2
         lgGIraI37NrGOCpfwECxMcOGm39KgsZBUL3gnhuqxoWinxT03MlKBBH3lDc++//mWRfy
         saUttAmEScwBtk78ivljFLah386be0xgR9F4xnZgOenUU9nnkJPB99+cdSYlqd1IX485
         3rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f9cBa6zX+pcpqjZYol9p3LfIQ80fDdPt0HIr/ZwqwXo=;
        b=Tz3XMejiaZ91VtkUwoWHpeIx/1pS2ft7e7a3p9nEM2M3cLjz2WuIIKTk7ToazLyuux
         OJSCLXS8+MZ11v+XgEiEObIEvxiUZZ18ywZV+2PMk+F5z3bsZA8gdfMauAF3zMc6bkk8
         bl8zA3BfNUjlhfKYLaZP5Xpu9KZBQh2Cp5gCLvX9DZkTNnLry4WUIDpEc2avG1J2hkkr
         7WC6yUMAuIHglPnC/8Kmocn/OvKUN90OuWbXm3kt2TAywxRGIDP112KdLcUctp801wc0
         SfECSaKqiXNH0GGvwuxyM+4WyR8s25cMOKB2wkbk/vT0RL5VDKS8b6/i1+79zAUVJ0ye
         J4Pg==
X-Gm-Message-State: AHPjjUioR7APJNFZfBLybMEk4b504Sv3futTeEPPiOG3zQEb38jw73TE
        /epEw6Roeh5szUh4sFvz3E6h95Lv
X-Google-Smtp-Source: AOwi7QCMfoiCgkBojqjE+sTOuvNm22M0klxS2Lo1tPlIaEKcRVeAvAZlQC9vBivwWlct3J501jbPug==
X-Received: by 10.107.202.2 with SMTP id a2mr5463069iog.140.1505894588239;
        Wed, 20 Sep 2017 01:03:08 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id b102sm1989926itd.19.2017.09.20.01.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 01:03:07 -0700 (PDT)
Subject: Re: [PATCH] doc: camelCase the config variables to improve
 readability
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
References: <0102015e9a2d3eb6-bee76ba8-4298-47d2-8822-d513bc33bd71-000000@eu-west-1.amazonses.com>
 <20170919202201.GD75068@aiede.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <63517904-6e14-6e12-31dd-ad91b2a70004@gmail.com>
Date:   Wed, 20 Sep 2017 13:33:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170919202201.GD75068@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 September 2017 01:52 AM, Jonathan Nieder wrote:
> nit: Git's commit messages describe the current behavior of Git in the
> present tense.  Something like:

Thanks for the clarification. I was once searching 
Documentation/SubmittingPatches
to see if there is any guideline about the tense to use. Unfortunately, 
this seems to
be an undocumented guideline. Fixed it.

My little nit: I don't think this is really the a "current behaviour of 
*Git*". It's just
a document, you see ;-)

> 	These manpages' references to config variables are hard to read because
> 	they use all-lowercase names, without indicating where each word ends
> 	and begins in the configuration variable names.
>
> 	Improve readability by using camelCase instead.  Git treats these names
> 	case-insensitively so this does not affect functionality.

Thanks for providing the solution, also. Used it with a little tweak.

> This also is just more consistent with the rest of the docs.

Yes.

> FWIW, with or without the commit message tweaks mentioned above,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.


> Thanks for your attention to detail.

You're welcome. Just for the note, I sent this because I had a hard time 
finding
the words that made up those config variable names when reading that part of
the 'git branch' documentation. I thought I could help a little in 
improving it.

---
Kaartic
