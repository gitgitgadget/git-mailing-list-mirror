Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3671F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdLNVGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:06:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752361AbdLNVGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:06:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A239EC9952;
        Thu, 14 Dec 2017 16:06:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7cQePtmQ5w4Cnk8yYAEYd7gNalU=; b=OoNB4v
        6P5xOV5AzRxefx/6NS1gjS2qXXSfXWGvZhIFEFuGFT6LgCpPko8ydOw9jkjbKeEQ
        rgWN4xkzyNJW6w0wsM0IgWyrJHBDsz458herg59YVBrQE8F0w3WuGs3HU+bvAfs+
        5Zb7Q/jGvknHMfn9lWlIdDy1mziyVXIo5TUAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z1jzxvKCCenJysLD2f2k+k/Ue5m6AL92
        vhAwR++5vYME8HeLei7jwZtEGjm6biS4CRkcuj6wLZudGKXuqoTnTs/+qqRPFE6t
        0ahYa3IRe4oSkfjQA24bEGVge01mXuxYx7EKx47cV21BQx/NY8VeXJXd4tjylOIT
        jSrTecBZaIk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99CE7C9951;
        Thu, 14 Dec 2017 16:06:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01C87C9950;
        Thu, 14 Dec 2017 16:06:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <20171214210453.GB32842@aiede.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 13:06:33 -0800
In-Reply-To: <20171214210453.GB32842@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 14 Dec 2017 13:04:53 -0800")
Message-ID: <xmqq6099t3xi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AADB4BF6-E112-11E7-AE1B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> * sb/diff-blobfind (2017-12-12) 1 commit
>>   (merged to 'next' on 2017-12-13 at 9a27a20c5f)
>>  + diffcore: add a filter to find a specific blob
>>
>>  "git diff" family of commands learned --blobfind=<object-name> that
>>  allows you to limit the output only to a change that involves the
>>  named blob object (either changing the contents from or to it).
>>
>>  Will merge to 'master'.
>
> Sorry, I should have replied about this a long time ago: I love this
> option but I am not sure that --blobfind is the right name for it.

Sorry.  I should have updated the description when the option name
was updated in the latest round.
Jonathan Nieder <jrnieder@gmail.com> writes:

