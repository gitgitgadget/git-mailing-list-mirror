Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E1FC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiCGUZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiCGUZX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:25:23 -0500
X-Greylist: delayed 182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 12:24:28 PST
Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267446E7BA
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:24:27 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id RJr1nQpRgYWUuRJr2nOnAA; Mon, 07 Mar 2022 20:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1646684483; bh=eB6MBjyCk1M7UXlkRQiWk+YioCN7uRkQkLsrspsi5Uc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=O2mBXEFNruVuTbFhO/FMCsuywaYpe0CXajiJG5XiB07eU6maPPtCMSAS31LmuDXBY
         EDt447xT6cz2xcmSxT76Ksrzk/fkGMeBsQ2LZX6EAqqdjlQL8FVkdRyAhRNvAuSv1k
         B9wz3TM1pD7AZkI9e90fuYTZeZ8nNTjqL4B1nRTEPKjvO07gcw571GsR7EPExnlPvG
         pPe3z9sSATxqCcOuL5G5dhV755mcMNq5llmrondAmRXy06SpPoSl9NRHIXPD6qRmh1
         NFiS5vf1xfyAEIhEy04aJco9anHyoDB7jdyG0fzSXnfHgwRsjCSS9ETlupb+jT/uIF
         non55I/oz/gLQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XfLqcK15 c=1 sm=1 tr=0 ts=62266943
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=c4Lp0R_3zJ6SiOuYX2UA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <e16ee84f-4fa5-6cc8-c96d-3b728e3c8b2a@ramsayjones.plus.com>
Date:   Mon, 7 Mar 2022 20:21:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Content-Language: en-GB
To:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
 <95cbca4c-ec26-853e-243f-461a365d9f71@ramsayjones.plus.com>
 <a2d91895-d933-9909-2f1b-5addd38974f3@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <a2d91895-d933-9909-2f1b-5addd38974f3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNJyvR9WKgz2MOtf3Y7oL+nc6W3tCsyq3Cl0aFZfajUPfKM9+RhRNwKYl2kYg1zLtRX4gebHVcLvxa9QREEBG4MXT8oz4LhyHunlIqDDQlFoFLuyUWSR
 Dcm7bwlz9TgdT7maCJk0RbbOQCxejQ+s0GvoXDAXq7DqP0LxW+baF5smDFLQQRD0J4jD05SX3chTsSx5r7sB8FWiVQ0mzkQhfvo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 07/03/2022 11:11, Phillip Wood wrote:
> Hi Ramsay
[snip]
>> .. but here, you pass the flags as the second parameter. ;-)
> 
> Oh dear that's embarrassing, thanks for your careful review.
> 
> Are patches 3 & 4 OK for non-stop platforms?

Err... I didn't notice any problems with patches 3 & 4, but, as
far as the non-stop platform is concerned, I wouldn't have a clue! ;-)

(Perhaps you were thinking of Randall?)

ATB,
Ramsay Jones


