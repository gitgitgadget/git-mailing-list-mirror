Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C273209B8
	for <e@80x24.org>; Tue, 12 Sep 2017 02:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdILCQg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 22:16:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57711 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751035AbdILCQf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 22:16:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6033B4A96;
        Mon, 11 Sep 2017 22:16:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y4uGh6O8jmO2WVlE8p1cjYNyYOc=; b=mOfdDM
        pob2RxT/Fbhr6xErb0nqVyp3rR2/RbDTM2AGUYxj9BOq9oSXC0aXfULbwxnovP9o
        lsuW0b4FmLH7YNGIaWo0G9Uog7BGIDoeUvBGxLEf6sxyWsgdCv+4bR/LnlsdtQ08
        sB1revhFASvIxaybqDQD6aUcvLPf5FZLh4LCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ejR2Ptzq6fOYfN4DPM5rlWitPCXF8N5b
        Cex4NmwkqQFXiRDAluZKUSLuDNQcmGmxw7odfkxZ1KRUWP5Yus+qUQglWIPBKJgx
        pvruG8CuF+JeMwsqrEtFIOa0PxoD3OlD5GFFYt8jOXt5lX3WqAuI+vR09zivjL72
        JTdUKNOl2R8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA6E3B4A95;
        Mon, 11 Sep 2017 22:16:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1196EB4A94;
        Mon, 11 Sep 2017 22:16:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Kevin Willford <kewillf@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #02; Mon, 11)
References: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014749CFE6DE449771AF724B7680@SN1PR21MB0014.namprd21.prod.outlook.com>
        <20170911195340.GB26081@hank>
Date:   Tue, 12 Sep 2017 11:16:32 +0900
In-Reply-To: <20170911195340.GB26081@hank> (Thomas Gummerer's message of "Mon,
        11 Sep 2017 20:53:40 +0100")
Message-ID: <xmqqd16w3blr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EE5340-9760-11E7-B5CA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 09/11, Kevin Willford wrote:
>> > 
>> > * kw/write-index-reduce-alloc (2017-09-08) 2 commits
>> >  - read-cache: fix index corruption with index v4
>> >  - Add t/helper/test-write-cache to .gitignore
>> > 
>> >  Expecting a reroll.
>> >  cf. <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-
>> > qg@mail.gmail.com>
>> > 
>> I didn't submit these patches so what would you like
>> me to do?

Nothing ;-).  

These two are fixups to a recent topic; the name of the topic branch
does not mean fixes and updates must come only from those who share
the initial 'kw'.

>> The reroll for read-cache fix was submitted here
>> https://public-inbox.org/git/20170907192412.8085-1-t.gummerer@gmail.com/
>
> I noticed that it has already been picked up as well, as
> 0b90b881e0c1de110c724fe63df6d2c3c9680d6a.  Maybe it's just the What's
> cooking that needs to be updated, or is there something else missing?

Yeah, thanks for keeping an eye on what's on 'pu'.

