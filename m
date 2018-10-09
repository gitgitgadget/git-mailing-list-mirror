Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236591F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 08:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJIP1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 11:27:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIP1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 11:27:02 -0400
Received: from [IPv6:2a02:ab04:3b9:5e00::3] (2a02-ab04-03b9-5e00-0000-0000-0000-0003.dynamic.v6.chello.sk [IPv6:2a02:ab04:3b9:5e00::3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1FE3627774D;
        Tue,  9 Oct 2018 09:11:18 +0100 (BST)
Subject: Re: refreshing the gitk colour scheme
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     git@vger.kernel.org
References: <7641bc4d-bc0d-845b-3c3e-4071fc184e12@collabora.co.uk>
Cc:     Paul Mackerras <paulus@ozlabs.org>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.shadura@collabora.co.uk; prefer-encrypt=mutual;
 keydata=
 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
 UuW1fO3lmRpcLq680uTO+9V+8FQHeQ==
Organization: Collabora
Message-ID: <8f7c60b4-b8c2-af37-1705-d67b9b6deeb5@collabora.co.uk>
Date:   Tue, 9 Oct 2018 10:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7641bc4d-bc0d-845b-3c3e-4071fc184e12@collabora.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just a ping for opinions. I can provide a patch if the changes make sense.

On 12/05/18 15:14, Andrej Shadura wrote:
> Hello everyone,
> 
> I’ve been using Gitk with the following colour settings for a year or
> so, and I found it much more convenient to use that the current default,
> so I’d like to propose to make them the defaults. These colours are
> slightly less 80’s i.e. they’re using colours outside of the ‘classic’
> 16 colour palette for a more pleasing visual experience.
> 
> set headbgcolor #98ff5e
> set remotebgcolor #bae2ff
> set tagbgcolor #f3fb57
> set mainheadcirclecolor #ffeb74
> set indexcirclecolor green
> set circlecolors {white #08b5ed gray blue blue}
> 
> I also found it may be a good idea to disable auto-selection of the
> commit hash by default, since it overwrites whatever content was in the
> selection clipboard, and also pollutes the clipboard history if the user
> is using a clipboard manager:
> 
> set autoselect 0
> 
> Here’s one more change which I am not proposing for inclusion, but I
> found it more æsthetically pleasing than the default:
> 
> set mainfont {FreeSans 11}

-- 
Cheers,
  Andrej
