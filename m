Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815A01F667
	for <e@80x24.org>; Sat, 12 Aug 2017 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdHLJ7a (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 05:59:30 -0400
Received: from mout.web.de ([212.227.15.4]:61454 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdHLJ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 05:59:29 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40zy-1dO7Ko1Du6-00rW3v; Sat, 12
 Aug 2017 11:59:16 +0200
Date:   Sat, 12 Aug 2017 11:59:15 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170812095915.GA5768@tor.lan>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:TJv5A5De75Lno2dnrCm2p+I4GwOL5ojeURfYPwsIq+fs1z41FN3
 6U/axOjYSvhNtDk0bJWYLnJoI+Uh7ZZK5DRkWLAlhWU7JOBhBCemFxTDZkwPD8HtQOSXXKU
 Gsb+hOI1O2Ipu4jdQ/tQUcl2TG/Kf4RTUJvj3u3rvYdUBbeqCjuwUaDxQnDhviNwuMVhyqg
 k5JbyNT2NutqyOpRl9iNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7TuTsKlrdKA=:RiXFMM43LLczQUuy37bymd
 LtKhM1amOlBnVCfq1sC0MNHwQyTv5uBRekPHQDKyxJf90p/G14tUIuUxz0FtBowwmOmR60Dt9
 lkwjH7YKFbtsWhdUDiaeE8JTV068Ar7G86S4KdnXv4V7N1BsZz8TNXHctX2+cXVeQVckTSa94
 YkeGEjUXTtdJL31ydkdUzYhqLFqpixX2YGFM4joyZMjKkHBpRIU9+I22E6xI+rzmdB9uXMUbx
 9XMBiLmHYvF1UF7+sgkS5Wv6cYybb931iKNfMs5wXp+ZF1+PDXcYKT3yhCos5rkoSbSQv/rLf
 sDpwA5CyopNB70FeaDEuD6HD1KYmRF5IkdeFhdsRtYoZogTOUht48SDpzu4Clw0/oOqGYV/9P
 RnfQhTPgohYthZ/PAEQOyQShNtlq6U4v33USlpl6JebkxZevdz64Dz/2dl3wxUOfKYXV9XCwH
 hQsbyxwBfkJU5a7WWlPzBbZZ2zSMbw+C+ILilOWAbjPKHNb7QwTKn6Q+K7P2X703n5xN7tnRi
 wXopPuueW+63snL7LUIHP6zl1bTjNKiIGlKCTEJ0J1gqxdkn916CvGbH6o42fsOl7CS84bIRN
 +fyn2a+MjLjpD52QjRVA4azw/n5Sg1AmQ1DafBiE8JMfAbZPltr4EDcjGIsyHMhejiwGXOQq2
 amCxkkuL4s160M1ezsnSnXR6WXTdA2QtBcJYsAcQFafwM0oFDzL9IIKI3RabwhSQvoJqk4omG
 kTsMaJwGkKZcDIs4i1zBox1ldaNFvT1lgbef/ZkA8eotz5WCsDLbkbLuE5CTbRUWiOSfEU48n
 OxCWhy3SK+r25LTQ8ZbccGszX2mmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for working on this - unfortunatly the patch does not apply on
git.git/master.

Which baseline did you use ?

