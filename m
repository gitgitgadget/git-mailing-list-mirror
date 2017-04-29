Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FFF1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756654AbdD2VBI (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 17:01:08 -0400
Received: from mout.web.de ([212.227.15.3]:64880 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755726AbdD2VBG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 17:01:06 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyTl-1dcnm721u1-00anyj; Sat, 29
 Apr 2017 23:01:02 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
Date:   Sat, 29 Apr 2017 23:00:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+qtZq4Im/v2JsNU88MtYn289UTHc6jWSrCcOXWIzuqe9Hsh9H4x
 seUqTbP09xgaeby3bQais3uNuBFSmY8vznRs/SOq2srPIp3I4gt+fT37WQY5y60xS4m7JSd
 CHNTdepEzDrttGkIxRsmZNZcXmSCfrBn7l/pWluh3f9AuGN8IFRsylaPs9uhxB02762byiw
 SUKTnGdQw/wIqnx2UdnPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f1M+jp9VxNs=:Iv71d/hUmotR7yjel/OVjO
 lWEYDt/wJxzAcS6yWLYfP+nVK9oHGcELOls3Cn5qY0gcqIec46lyoqO8GaIngSPPE7Myv0Hlf
 d0J/ALYISDKvWddHPTSaNhVZMu9PWluYfp5/AvDiTAQuT4l8T23Vv0GYqdntUFHVD2dTcCIF5
 yh3wJnpvviFfRTF1dP0EilipXF6JqQsYuzVTHrS7VyDhLx+OdhjxXwoVne072tGodWNl5lf7A
 ZmNzvvedbWJ/rKWyuYBOtJjU7oUOpFn+ww7oGfHh8vMqvoNk2Ol8+wslvFU5ax6ta7G/qZgjS
 7zpaDi6GhDtHp2Cp/uZIaOAl42d75O9/y8DQ+3lxrGINgAPdMZRFB/nwrGwGtWX0qb1hwETej
 /f8c7aOnz5SgAAPS90/0klAAEagjm5Bt/4+5NwRctbemRt0vfQxmEGhJTKkB4I8EXDozOq8QV
 v1YSPn9yYESfzJ3wVunlx9gcbiOFvZH9EOkumIlv7Ha36jQJhXJ2zYotrJoDI+MG0eXzQkIJL
 wZof2xZp15s49AA9amrtaUJjLUWT8u5jXnr3gQ5sjp5GV3YszRzkEejomGikUOGOOuO/UTG9o
 jfijNiWVb8dwMx3A32+aSOJC4mAGYOJcA6HiSC9nEP7pt1ZtqxC43L9teh63mSyae+UVhgzun
 2HWgnDe1STlg93zl7B9ZPLkidQidEKvrfbJbzQFePxW95aDetSJP35GtvjKY7BqB57xXMXIKw
 8F9+gvkGzWMwL4/bibOl0rEXbdS+hrbRYC+1ybAnzoyCBm8Q7oxl8Q74ytB/E46bm/yDOGWye
 EXtD2at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-24 19:22, René Scharfe wrote:
> The first patch adds (expensive) tests, the next two are cleanups which
> set the stage for the remaining two to actually implement zip64 support
> for offsets and file sizes.
> 
> Half of the series had been laying around for months, half-finished and
> forgotten because I got distracted by the holiday season. :-/
> 
>   archive-zip: add tests for big ZIP archives
>   archive-zip: use strbuf for ZIP directory
>   archive-zip: write ZIP dir entry directly to strbuf
>   archive-zip: support archives bigger than 4GB
>   archive-zip: support files bigger than 4GB
> 
>  archive-zip.c                   | 211 ++++++++++++++++++++++++----------------
>  t/t5004-archive-corner-cases.sh |  45 +++++++++
>  t/t5004/big-pack.zip            | Bin 0 -> 7373 bytes
>  3 files changed, 172 insertions(+), 84 deletions(-)
>  create mode 100644 t/t5004/big-pack.zip
> 
This fails here under Mac OS:
commit 4cdf3f9d84568da72f1dcade812de7a42ecb6d15
Author: René Scharfe <l.s.r@web.de>
Date:   Mon Apr 24 19:33:34 2017 +0200

    archive-zip: support files bigger than 4GB

---------------------------
Parts of t5004.log, hope this is helpful:

"$GIT_UNZIP" -t many-big.zip

Archive:  many-big.zip
warning [many-big.zip]:  577175 extra bytes at beginning or within zipfile
  (attempting to process anyway)
error [many-big.zip]:  start of central directory not found;
  zipfile corrupt.
  (please check that you have transferred or created the zipfile in the
  appropriate BINARY mode and that you have compiled UnZip properly)
not ok 12 - zip archive bigger than 4GB
#	
#		# build string containing 65536 characters

