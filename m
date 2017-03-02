Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62531F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdCBTTv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:19:51 -0500
Received: from mout.web.de ([212.227.17.11]:54143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbdCBTTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:19:30 -0500
Received: from macce.lan ([213.64.64.87]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1cTu1d0DZP-00srpG; Thu, 02
 Mar 2017 19:20:10 +0100
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
To:     Mike Crowe <mac@mcrowe.com>, Junio C Hamano <gitster@pobox.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
 <20170302142056.GB7821@mcrowe.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <4e53ca81-3328-349b-3612-a672ddc6a949@web.de>
Date:   Thu, 2 Mar 2017 19:20:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170302142056.GB7821@mcrowe.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SizSm/23418x4P9sz3oMMObroBBUWmVsYT2EOEsjrWCg2FV962b
 dylgBdvg7PvyqavHp/b7Tf6y+uGXWya/UKgAx6AdflVGrx2FvzquBi1ESsBn3RT1tMrTeUS
 FZfTNnIlkLQtnF4GR4KvEP2Of1DkAnti1vTJT4bQWWUIZZ06RjxNTIQtILQ/QuUYBxONCxC
 y2rAsJTpjEi+5yCapfAUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vLC0F1Oc1no=:5caJfJk1dL0bwKThNbB11a
 UqvmgcKQQ2aZo8cO03pqrHw2WrBHZNV5KkFdIo1QRuYPc4M9Hdam60f3S21m8HlYEzicQLe2Z
 nyhYn55sLT/QbsW1qDVYosd/vgQv4sAuegYgE4t2kUkB31UEjOAyBCL+XzXm9TLIt/BhmWeqh
 dfoq4yGUHbgMb4XcwWMjMm2gIhU02l17k8MTZbk2BZQ/65cYZUQrURtAXMv1/35sJTnsNf9Wy
 69aoQR1JXFjHSdUgsjVUOls57pJFaYx3QXycqRrlkMBaTGTHf8sk9TIWvZTMtejsKStIQMmOr
 HMjkOQ6YEcuWTnZTSzpoXz0kdDr8yyP8c+zdEgvLB2WvKYMqNE4ZS0S8RKMBBQmISX8642JIJ
 Xmf1vzORmDG4aFD6WVyJ1dldy4Nyy64vsyCoAdw3XKd/eBIxb5sWVY4jaG4qmBoDebYsv2b3W
 QzPUWnKOkEoW59LHzDvI/UanwSlwXsQXmWLAScBgUD7QYkqeBKxToxVkCGfXZJ9P8fJZUysSz
 TJ4NPBzgc8cZbLYE35HJQs+tIDAVifXSCxCj8PHfDjbTsOl1Ke9/SuFt0ODFf4g03y06Gh1LS
 /NyGHXTwy+1Dd3A6TYWLJa+S8bSZpCEHh4ZPwpW/fPRctsVU7z6Pr/CAFWkwVoslqkZnmUDAD
 qROSKH4dzWnfKEtBGtMQjC6qeCrNzNYrx2PS4xLUIHtSPYTMWxHagEfAgHmnjBADhuOD+M5Ri
 EU7NpIWPYwz+3jVb+xiu2lXa2CbsRY27gtQTrZKkzJXlB64ImpVdAY2AcVvp849FJLsYCZqaY
 V3yuLo3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-02 15:20, Mike Crowe wrote:
> ll the solutions presented so far do cause a small change in behaviour
> when using git diff --quiet: they may now cause warning messages like:
> 
>  warning: CRLF will be replaced by LF in crlf.txt.
>  The file will have its original line endings in your working directory.
Ah,
that is not ideal.
I can have a look at it later (or due to the weekend)

