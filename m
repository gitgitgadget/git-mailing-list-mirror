Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419A220281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964914AbdKBVUp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Nov 2017 17:20:45 -0400
Received: from marcos.anarc.at ([206.248.172.91]:34986 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964829AbdKBVUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:20:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id C52421A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] remote-mediawiki: skip virtual namespaces
In-Reply-To: <xmqqvaitsc9z.fsf@gitster.mtv.corp.google.com>
Organization: Debian
References: <20171029160857.29460-2-anarcat@debian.org> <20171030025142.19421-1-anarcat@debian.org> <20171030025142.19421-5-anarcat@debian.org> <CAPig+cSRrXj9BdgM6Q2OdBZtYJOVOnfo4BaG30C-_ug3QunPfQ@mail.gmail.com> <87wp3a54nj.fsf@curie.anarc.at> <xmqqvaitsc9z.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 02 Nov 2017 17:20:43 -0400
Message-ID: <87375w5qdw.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-02 10:24:40, Junio C Hamano wrote:
> Antoine Beaupré <anarcat@debian.org> writes:
>
>> It might still worth fixing this, but I'm not sure what the process is
>> here - in the latest "what's cooking" Junio said this patchset would be
>> merged in "next". Should I reroll the patchset to fix this or not?
>
> The process is for you (the contributor of the topic) to yell at me,
> "don't merge it yet, there still are updates to come".

YELL! "don't merge it yet, there still are updates to come". :)

> That message _may_ come to late, in which case we may have to go
> incremental, but I usually try to leave at least a few days between
> the time I mark a topic as "will merge" and the time I actually do
> the merge, for this exact reason.

Awesome, thanks for the update.

i'll roll a v4 with the last tweaks, hopefully that will be the last.

a.

-- 
How inappropriate to call this planet 'Earth' when it is quite clearly
'Ocean'.
                        - Arthur C. Clarke
