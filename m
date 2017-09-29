Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E228020281
	for <e@80x24.org>; Fri, 29 Sep 2017 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbdI2WjT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 18:39:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:50845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbdI2WjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 18:39:18 -0400
Received: from [192.168.178.43] ([92.76.242.84]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQvDO-1dlNB347Ys-00UGDJ; Sat, 30
 Sep 2017 00:39:12 +0200
Subject: Re: [PATCH] clang-format: adjust line break penalties
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
References: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
 <20170929184032.GK19555@aiede.mtv.corp.google.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c1230d5b-ff84-8cf4-8ae7-b8387bf4bb04@gmx.net>
Date:   Sat, 30 Sep 2017 00:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170929184032.GK19555@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rChez2K90S9F8SQCfrFe2JlUqnCqRs9Uq34mflkr7+5wtmb5Gsb
 Q2Ec8LiMFLj/kPW9Z6FuJSYtfB/n69tUIhd2yd4Cc771ua6zO2yUahC3/QXoD7bVG3k5xbP
 xQmIQLL7cMiwAFbQXa85S5joTgapXOUrwn6lkyUlFIVt2UYPvFIb9TVNGCx41oXXvb/zAnA
 +lvCGnWwYkEuut6tHgMYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zakk6Lx+DpY=:eG+PLLocoT+HyEhtSPD4lL
 BD6E6lAhJ9e7gj8Npr1Vz2zowo/14x0AW5rvQknUDipGRMzJediIF4bNCuys5l7XNdvg6fPP2
 gVXC72ubBeVz2JSozBzNmVkwWDBw3vmip99w8Qt3UHhV6xYsghHQJw4aB5VAIWqnzDMJrbt8T
 R64BjyYmX1L3bG49RBH9fYeSdBbZbDU5ghF0FbaZg6Owm52ZWUUhQAnryH/vsJntzFMz4lJa/
 z0a6tDBCo0U1DYLXIHkJfDPxBpPTKgHqoP7Q8qHytQjtqASuj6Fk96FhmknTYqI8HXOr5Hatu
 WOOzkDOcTmJiLCTNzD9sQuawxq1SBkyR1KCKRHQCFNl1Cbzkq99qbKrAbTZf7p56BEvW+ergt
 G0hWVkp2nEu8iREINSr7t8aIPw/WkfawlpzkZ5IXh7Gl4yyEKF+Ldcy3p3SZibX+29RwOt2OV
 llvPEKXBwgQaQohoftxIxI8ms+Sjshr5ubYRI4fdkcnPteMOTBjcJtcFa8g5oUQyIrre46nWh
 PM/GoPF/Ez7Gq0VXLhx4clUjs3Ol24yj/UICcKqpVCpeD7yaa1RMxHHAPzWKoPwUMM2T8vT5+
 aRZpmNjskjx0ba2RkDiQRBENN+3gz2+N54LJUxVnuJ9aaFHIKGc+ivzWDAxybndgT+J59PCzA
 elBHkhTUyfZaFJRq1GafdJajjbvJsC7N07KWYtMvv4etMztusQf0YSdtexY8RH/D0JAeDLCrj
 UeupYDRcQYIhcdrpK/Xv3tBvGTnCpJnFKRwcP4vK/AheFAUF8MtJEABKZa5ujF8zThAT8Uaaf
 SyqeGVrBl223fbx6iEdqFMLfWNKwhgfHkxra29cCZftqhEKGZQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 09/29/2017 08:40 PM, Jonathan Nieder wrote:
> Going forward, is there an easy way to preview the effect of this kind
> of change (e.g., to run "make style" on the entire codebase so as to be
> able to compare the result with two different versions of
> .clang-format)?

I just ran clang-format before and after the patch and pushed to github.
The resulting diff is quite big:

https://github.com/sbeyer/git/commit/3d1186c4cf4dd7e40b97453af5fc1170f6868ccd

Cheers
Stephan

PS: There should be a comment at the beginning of the .clang-format file
that says what version it is tested with (on my machine it worked with
5.0 but not with 4.0) and there should also probably a remark that the
clang-format-based style should only be understood as a hint or guidance
and that most of the Git codebase does not conform it.
