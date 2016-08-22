Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DC81F859
	for <e@80x24.org>; Mon, 22 Aug 2016 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbcHVQv5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 12:51:57 -0400
Received: from mout.web.de ([217.72.192.78]:54472 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755576AbcHVQvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 12:51:48 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lg01f-1amZGQ3S9r-00paTB; Mon, 22 Aug 2016 18:51:41
 +0200
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
 <20160819085700.GA23254@tb-raspi>
 <alpine.DEB.2.20.1608191656080.4924@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0ee82126-3fae-723a-ab89-b5794c4abc74@web.de>
Date:   Mon, 22 Aug 2016 18:51:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608191656080.4924@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:oUIuov0s/DgwuXoJln6MVZGu438bPbGduBj9WfbFRFBAuZQS6bi
 wW4GjCMWz2Ew8xIbkkbKwkVRGbzjgSrKQTG1ST7szNQ0p7u+gvvU1yyxdoU6W9oUpyZLkVs
 cmqPykEnByOTEpnsdCfGenziHVZbx1U6iTbR9N1A5LUUBx2t7SzAPqgqGMsAsNe8sqSwISj
 C7plLCW1cZvgCmiWyuSFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RxGhuTj21BI=:Ha4pVHhvEKx1cYjo9z2D/R
 6dbncsDPe005+54Sis7MP5plILQOc95MgqKCORJqyKk4Ys0u9swqGkc5S2DJSRUck6QJ6SY0q
 DCUVueQGuZieP/tkIlC0bLhv6QcxxbzeuCYtrYra+LRN84EyD6jko2i7exFKJQWkFvSRJxIWe
 0JRrYDofNEPRbrnPLCDV6ZgBDWO/r6U+K+gzxUuW15URaY4LWGGjhSSVMmx5P2dW8MJOfMnFR
 L69fPKxS48elDt1Wr0T/unStXY2FKY/aHZktKqVSZogIO3t6+qmUwlMV1ucYzN+6o45CWqIog
 H16ohoirwU7sBCLYj1tJ64bvmUOnEbICCxw/ZMSOCvpzBQfj5Y+MJVY/JmLzJY5km+LwwGZeV
 ckQ4nLOX3s3pYpDp2KqOpxE/6vmVEayrm4+Bi7Eq9YkY09xjZNt4pYrxfuzzKuq4C+67pRJRN
 t4af6lEnrgvkzDWRm80xxZnlDpG/ufzaF+wzLP5IcLp7AMOC6XSPM5JaIvrXjX3Pf/2WIyt7C
 JcKW/zXJuOXSNuj0ef7WbK94p77FS4f561tkDMMZB3hmzxv0Kt85/SvqKnPb72u4olNHLjEKI
 TZHAQpdqtiYmmrYnhNhYvoCvop1+yXPrUoUvpe30SoNEEL4aCQGjejo+F4S+MXjIaBTQGL8vw
 azfGd5vkb78xMYdjEy68shnIhAd/0LDBrSiJtztaUhoWJ1+uYr5bnYaAFTqYfo8XgBD1X5InM
 DCXREFAFVKhH8rgSgQe69o5b8ashuqo82Fi72RCmrTGcTIh5t0mG5nkpby+qOfvPGN0Ia65ju
 iyjM3xm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.08.16 17:00, Johannes Schindelin wrote:
> Hi Torsten,
>
> On Fri, 19 Aug 2016, Torsten Bögershausen wrote:
>
>> On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:
>>
>>> +--filters::
>>> +	Show the content as transformed by the filters configured in
>> Minor comment:
>> s/transformed/converted/ ?
> Sure.
>
>> Does it make sense to be more specific here:
>> The order of conversion is
>> - ident
>> - CRLF
>> - smudge
> I do not think it makes sense to complexify the documentation in that
> manner. The filters should always be applied in the same order, methinks,
> and it would only clutter the man page to repeat that order here.
Can we can shorten the description and have something like this:

--filters::
+	Show the content converted by the filters configured in
+	the current working tree for the given <path>. 
+ 	<object> has to be of the form <tree-ish>:<path> or :<path>.
+


