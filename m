Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FC81F462
	for <e@80x24.org>; Fri, 24 May 2019 20:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfEXU6w (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 16:58:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50944 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbfEXU6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 16:58:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54D416A364;
        Fri, 24 May 2019 16:58:51 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=R8G0ckomSfgNthrOqLma9cTRHyo=; b=wX499o7
        LKTLbPpuo+atRDXs+HPbnescHZx3TbMH7UZ6MGeZNRVrUE65dbuUWNccnu9Yqkkc
        FhycVcNMScoOV94Ga+RgezPK0LoN1yzlnFsAXuxAcCVQgBibjGfOdZG5b9KRcCFa
        mJIcDYgLTNitlv9c+fQppLLT8gRs5keRtExU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=I2gX96jXKnPu60PFGXzIQJ77AI4vjmk8c
        bCDeMIazGj30y7apMroRE4p8TC7rlt5+5Owe2ZD4HUrW9xrI72+f8kEKdg09QwxZ
        q2os8FUjlzComUr+kj5U4MSSNA0YlKdfjL5xXGuLeZTHcSjhot3oxE0614RsQsEc
        MGQO4fk3fk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CD806A363;
        Fri, 24 May 2019 16:58:51 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E889F6A361;
        Fri, 24 May 2019 16:58:45 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 24 May 2019 16:58:41 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        bturner@atlassian.com
Subject: Re: [PATCH 0/3] fix diff-parseopt regressions
Message-ID: <20190524205841.GA28239@pobox.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190524173642.GQ3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524173642.GQ3654@pobox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B8C3433E-7E66-11E9-8387-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Below are the compiler errors.

Well, to be precise, all but imap-send are warnings rather
than errors.

-- 
Todd
