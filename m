Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5023920248
	for <e@80x24.org>; Sat, 23 Feb 2019 07:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfBWHLD (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 02:11:03 -0500
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:58714
        "EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbfBWHLD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Feb 2019 02:11:03 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id xRSdgax4F6dqMxRSfgfEUB; Sat, 23 Feb 2019 00:11:02 -0700
Date:   Sat, 23 Feb 2019 09:10:59 +0200
From:   Max Kirillov <max@max630.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190223071059.GD2354@jessie.local>
References: <20190130231359.23978-1-max@max630.net>
 <87lg2kj91a.fsf@evledraar.gmail.com>
 <20190213105616.GH1622@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213105616.GH1622@szeder.dev>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfJ+uiBxIcAMHlkjDVl5+8hRd4r6XMW7U9pDLFlwpZIGwcii8vfFGP63a9KbqkpJ+PTHUUevkNm+MwOA8JpuHICAZn3Ncyh5jLLL+1rFWm++LdBjPAzS9
 9Qg9VB8j61bnH0S7p93E79jmd8VB4Croxb4RVcmbpWcVEWw6MLfTeQNBdQwjR3YCuAzugmY8LyFjS3KQy0dq0GFH6i7QccL0gj8Q+37xR7OZZzNiF72XF/X1
 X9jBZrjpCY7hnB1fdsjiWtMNfihh3lqDlKVpdbFkldeWMU5zMzCqPu0kLgxkli6J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:56:16AM +0100, SZEDER Gábor wrote:
>>> +		if (iter)
>>> +		{
> 
> According to our CodingGuidelines, the opening bracket should go on
> the same line as the condition, i.e.
> 
>   if (iter) {

Oh, thanks. I must have been professionally deformed.
