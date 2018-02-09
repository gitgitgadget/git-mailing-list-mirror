Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEBB1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBITMj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:12:39 -0500
Received: from grym.ekleog.org ([94.23.42.210]:54802 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeBITMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:12:14 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id f48fa37a;
        Fri, 9 Feb 2018 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:from:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=aSbpws8v+EE+KzaFJji4nFge7JQ=; b=kDHgYIDdBVzehf
        Q+V7m94JBbB0OBi7QIrXwD+KO4ynXMOyV8waPwTMC4p2WM+aQgpudSR7VX8H8JrF
        xNQXMBn37rsluKt3m3Vdo1t1kLX3/51Quwg9lOz5w1wfV9f+tW0fSpoqn5qWMUNt
        nlm7Sor4tKHOJkYU8vCh3fYNpdqYU=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 67d024d0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 9 Feb 2018 19:12:12 +0000 (UTC)
Subject: Re: Fetch-hooks
From:   Leo Gaspard <leo@gaspard.io>
To:     Joey Hess <id@joeyh.name>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
Message-ID: <3a5a2827-0f69-3a11-2664-51a60eefebf1@gaspard.io>
Date:   Fri, 9 Feb 2018 20:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2018 06:02 PM, Leo Gaspard wrote:
> On 02/08/2018 04:30 PM, Joey Hess wrote:
>> [...]
> 
> Hmm, OK, so I guess I'll try to update the patch when I get some time to
> delve into git's internals, as my use case (forbidding some fetches)
> couldn't afaik be covered by a wrapper hook.

Joey,

I just wanted to check, you did not put the Signed-off-by line in
patches in https://marc.info/?l=git&m=132491485901482&w=2

Could you confirm that the patches you sent are “covered under an
appropriate open source license and I have the right under that license
to submit that work with modifications, whether created in whole or in
part by me, under the same open source license (unless I am permitted to
submit under a different license), as indicated in the file”, so that I
could send the patch I wrote based on yours with a Signed-off-by line of
my own without breaking the DCO?

Thanks!
Leo
