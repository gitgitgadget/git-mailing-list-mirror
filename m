Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA592022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdBWR2j (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:28:39 -0500
Received: from lang.hm ([66.167.227.134]:40877 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbdBWR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:28:38 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1NHCG9b008258;
        Thu, 23 Feb 2017 09:12:17 -0800
Date:   Thu, 23 Feb 2017 09:12:16 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Junio C Hamano <gitster@pobox.com>
cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
In-Reply-To: <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.75.62.1702230907340.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Feb 2017, Junio C Hamano wrote:

> On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>>
>> Since we now have collisions in valid PDF files, collisions in valid git
>> commit and tree objects are probably able to be constructed.
>
> That may be true, but
> https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org/
>

it doesn't help that the Google page on this explicitly says that this shows 
that it's possible to create two different git repos that have the same hash but 
different contents.

https://shattered.it/

How is GIT affected?
GIT strongly relies on SHA-1 for the identification and integrity checking of 
all file objects and commits. It is essentially possible to create two GIT 
repositories with the same head commit hash and different contents, say a benign 
source code and a backdoored one. An attacker could potentially selectively 
serve either repository to targeted users. This will require attackers to 
compute their own collision.

David Lang
