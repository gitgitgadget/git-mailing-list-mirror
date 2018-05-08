Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F57B200B9
	for <e@80x24.org>; Tue,  8 May 2018 02:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeEHC2q (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 22:28:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53720 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeEHC2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 22:28:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24E81EE534;
        Mon,  7 May 2018 22:28:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=nT6278GpLWmqdeY52rvwwzVVCTQ=; b=yiyjPZO
        Ty3rMp4zAPbE1bFBnyrtLg4kg2DSyz7jKP4CIIt/2dKzjNDLV47NcKrA/lPaEQBz
        BCZRlB9f1EheixpW8ibQ/V+AJe/YDZ51J7T3H19YUyaE50H9B15AjrV/jXADeu4U
        E2yWwkVPgwbZ04IIuia46K8vZUOB6AC2lNEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=TyVQnGrOiYMAO9JWl1yOw/O6enYaHppLx
        08q5wEwNBSDcgBZrvjrrAFaBA6xeCfZLx8yvLt8AVMEa4EWY8ox0m0EVXvkcPe4P
        oOqEJMZe5tmszS3Vz5lWlhT8qYOowvoCfbR6B7h6ubBaRF4lYv6eU1C+cckT+T0V
        IFipShPDoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CC99EE533;
        Mon,  7 May 2018 22:28:45 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88F1BEE532;
        Mon,  7 May 2018 22:28:44 -0400 (EDT)
Date:   Mon, 7 May 2018 22:28:42 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Matthew Coleman <matt@1eanda.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached
 --options
Message-ID: <20180508022842.GD26695@zaya.teonanacatl.net>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
 <xmqqh8o9l7n4.fsf@gitster-ct.c.googlers.com>
 <21289682-5B46-4131-B7D7-57CE9F391B9D@1eanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21289682-5B46-4131-B7D7-57CE9F391B9D@1eanda.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 87B89DBA-5267-11E8-92A5-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

Matthew Coleman wrote:
> I haven't seen any discussion about this recently. What
> are the chances of getting it merged? I'd like to see this
> included in 2.18.

Junio's last few "What's cooking" updates have mentioned it:

> * sg/completion-clear-cached (2018-04-18) 1 commit
>   (merged to 'next' on 2018-04-25 at 9178da6c3d)
>  + completion: reduce overhead of clearing cached --options
> 
>  The completion script (in contrib/) learned to clear cached list of
>  command line options upon dot-sourcing it again in a more efficient
>  way.
> 
>  Will merge to 'master'.

I imagine it will show up on master sometime soon, in time
for 2.18.0.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I expected times like this -- but never thought they'd be so bad, so
long, and so frequent.
    -- Demotivators (www.despair.com)

