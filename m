Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC9C20254
	for <e@80x24.org>; Thu, 23 Feb 2017 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdBWTWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:22:00 -0500
Received: from lang.hm ([66.167.227.134]:44897 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdBWTV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:21:59 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1NJKYOD009581;
        Thu, 23 Feb 2017 11:20:34 -0800
Date:   Thu, 23 Feb 2017 11:20:34 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Junio C Hamano <gitster@pobox.com>
cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
In-Reply-To: <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.75.62.1702231113450.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


pointers to a little more info


https://shattered.it/static/
the two files are:

https://shattered.it/static/shattered-1.pdf
https://shattered.it/static/shattered-2.pdf

422435 shattered-2.pdf
422435 shattered-1.pdf

identical length and a lot smaller than I expected (~162K of the 413K file is 
binary junk)


$ sha1sum shattered-*pdf
38762cf7f55934b34d179ae6a4c80cadccbb7f0a  shattered-1.pdf
38762cf7f55934b34d179ae6a4c80cadccbb7f0a  shattered-2.pdf

$ sum shattered-*pdf
62721   413 shattered-1.pdf
41606   413 shattered-2.pdf

$ md5sum shattered-*pdf
ee4aa52b139d925f8d8884402b0a750c  shattered-1.pdf
5bd9d8cabc46041579a311230539b8d1  shattered-2.pdf

David Lang
