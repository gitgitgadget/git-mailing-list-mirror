Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAB11FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969059AbdDSSzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 14:55:42 -0400
Received: from mout.web.de ([212.227.17.12]:58678 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966926AbdDSSzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 14:55:40 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNiS-1cbfDP0wV2-00TmLV; Wed, 19
 Apr 2017 20:55:19 +0200
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
 <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
 <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
 <106c2be9-c558-edcc-2d97-5091c15010d1@web.de>
 <638E6914-6B66-4C66-996F-F04A285A2129@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <48d9e7f0-15bf-ce0e-aae8-4c3ebd5c07cf@web.de>
Date:   Wed, 19 Apr 2017 20:55:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <638E6914-6B66-4C66-996F-F04A285A2129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KmuN/lgG9PJrVVBPQj6zc9sbwjwZQ10GLB4KEi51uRmUU867TMh
 TaO2Wqc5FhCbHY0SSXu0d98mh2AwlLxT/OaX7PBBysk+BA6gSFdTirodZhAJ51RW6j7yp0g
 F8bmhk/CqWBXdXZR9N5Cw7N8dqNY7/7ydgKSZf7ZQNiK9WX0yoq4+Y/P+0qvqxWw1AWq8tO
 o9ozndjoV4BVf8sm057Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SH8Lb5S+Dww=:BqNKZ2OI7dK+DS3sYaBqNh
 0utEyxUDsVhZ1fVz3cDbC4eBwK3N/v31+2rtXLnkJNICZWM9Cvt7oAipta37ZF04OvGjv7Zj4
 8z+KPO9bObK5pXBDrpjdwRCJmD/cxtorxZ6pjsqOBmJcs85iEjZnqeuzl24df5FoSZ4C56OFy
 4Hy+5B9rxuLqC3tRk4ETuL47MfFfSdkWO66HRNZ9KE2YK44rSKGZn/JkYCVpmkZuAphZOmfs/
 UD2KKmQvlxnIYnaSa1+KPVge0Gyrv3k0csR+k8H1g2BSm90EFokrGEt1si7LZxeL3HTzL0Lt1
 goTmO1oeQkeH0SC5l9bYyhFmCmmVI8WA2B4/kDVggnA8KYjCH8dqTi3NaUASTwHzLtaGqhNUK
 h0usRPkaounIe+Stlm9wMcKj8jiXmse90yxTkCw7zXzzhxEOQ/wnr7N7oCHUE6Y+UyMQ/xsyz
 vQsWpXudNgfA8DIHbR3EA6CwkQRhELxnJcEwgvJrWjCHJQc5wUyJiQIIZzui+wc6AL9YXq4KK
 ir1/V7vLZWcHmfXTFP/zuQVigbHCJ2Aq8OhdZ4SpA18G9owyl5N3Rzslw9hvqSqu8nlyM3Kn2
 fP344jmf02dky6ncwBWkjVv+5/M4XF5xiILMk8ppgvdJYho4j9T6L7077JNl7KOEmaPuzuJWO
 /0f2AnLTVmiQivgPYfLw7JUK6N0AYSDt9/zGv4o5ShJZU3wabkpOuwn9PRYQA3ZW7dTjTjgXk
 tHF1TFPQML61g1S97sXyxMWPWFvX0Wj1RjFueQOE5j4IHcoX+wK0mfMTg1PskbCwbOYPT+R8U
 IRdBSdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> (Back to the roots)
>> Which criteria do you have in mind: When should a filter process the blob
>> and return it immediately, and when would it respond "delayed" ?
> 
> See above: it's up to the filter. In case of Git LFS: delay if a network call is required.
> 
That make sense.
I try to understand the big picture, and from here try to review
the details.
Does it make sense to mention "git lfs" in the commit message,
and/or add some test code ?


