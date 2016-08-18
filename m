Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B86203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbcHSBFy (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:05:54 -0400
Received: from lang.hm ([66.167.227.134]:45149 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753998AbcHSBFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:05:53 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u7IGuGRN018731;
        Thu, 18 Aug 2016 09:56:16 -0700
Date:   Thu, 18 Aug 2016 09:56:16 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     =?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Nikolaus Rath <Nikolaus@rath.org>, git@vger.kernel.org
Subject: Re: Working with zip files
In-Reply-To: <12866c04-f910-2a83-b445-6eada3d2efc9@gmail.com>
Message-ID: <alpine.DEB.2.02.1608180954400.11774@nftneq.ynat.uz>
References: <87y43wwujd.fsf@thinkpad.rath.org> <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz> <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com> <34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com> <xmqq8tvwcvrc.fsf@gitster.mtv.corp.google.com>
 <12866c04-f910-2a83-b445-6eada3d2efc9@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1171998702-1471539387=:11774"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1171998702-1471539387=:11774
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 18 Aug 2016, Jakub Narębski wrote:

> JN>> You can find rezip clean/smudge filter (originally intended for
> JN>> OpenDocument Format (ODF), that is OpenOffice.org etc.) that stores
> JN>> zip or zip-archive (like ODT, jar, etc.) uncompressed.  I think
> JN>> you can find it on GitWiki, but I might be mistaken.
>
> Using 'unzip -c' as separate / additional `textconv` filter for diff
> generation allows to separate the problem of deltifiable storage format
> from textual representation for diff-ing.
>
> Though best results could be had with `diff` and `merge` drivers...

can you point at an example of how to do this? when I went looking about a year 
ago to deal with single-line json data I wasn't able to find anything good. I 
ended up using clean/smudge to pretty-print the json so it was easier to handle.

David Lang
--680960-1171998702-1471539387=:11774--
