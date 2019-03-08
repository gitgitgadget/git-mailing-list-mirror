Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F36020248
	for <e@80x24.org>; Fri,  8 Mar 2019 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfCHRsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 12:48:17 -0500
Received: from avasout04.plus.net ([212.159.14.19]:60909 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHRsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 12:48:16 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 2JbShxgFUAOoy2JbThorBR; Fri, 08 Mar 2019 17:48:15 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=LoxvCvJquHjgOf8DUz8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 00/21] Add new command "switch"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d0f69dda-f677-45b8-f70e-971df27ce224@ramsayjones.plus.com>
Date:   Fri, 8 Mar 2019 17:48:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPwkWn4WcoOQfxw7S/ANPtf3xiArLwiupbl7ZwuCYi7RN9eG0+S1Qycq7roeY0mplHmbO6HJnk+qO1vjeN8fs6PQtYTWyGhV2YYrz+dWvrjDTAyxSCsX
 qCTa80XGeHk+EiIs8ppfpAXister1M8w9lxBp1EmrqZhFWPnqNGKiBTK8gYB0qSCYTjr2ZenXHgMhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
[snip]
> Range-diff dựa trên v2:
>  -:  ---------- >  1:  949f3dd4fd git-checkout.txt: spell out --no-option
>  1:  8358b9ca36 =  2:  1ddbbae3e2 git-checkout.txt: fix one syntax line
>  2:  1686ccbf8d !  3:  b0cb2372db doc: document --overwrite-ignore
>     @@ -14,14 +14,15 @@
>       	out anyway. In other words, the ref can be held by more than one
>       	worktree.
>       
>     -+--[no-]overwrite-ignore::
>     ++--overwrite-ignore::
>     ++--no-overwrite-ignore::

Just curious, but why? Is '--[no-]overwrite-ignore' thought to
be harder to read? What about the rest of the man-pages?

ATB,
Ramsay Jones

