Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440DE20A93
	for <e@80x24.org>; Tue, 10 Jan 2017 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939813AbdAJSOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 13:14:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936586AbdAJSN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 13:13:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26BAD5D2CB;
        Tue, 10 Jan 2017 13:13:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ynyk5JK28FV/J1g1zaoWWFk3BUg=; b=KiL/kI
        OB6YMWg4FtPygenQG5h5pfOw/QvOqWV+RMsfkmU96qa4xsLwcmItpr8Rv4t1kFlM
        Q50fOisZT7jVdz/5rxhTWqE7BEH2ysIctlGK6YCLsn6ov/e6Y2DuAfZl2mbp1YMo
        Ufd2Mym7WpO3BpzYo5vwvUAUObrpCwKG4RDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WZH+d+mI3pAq5T2JSkXqYof/rcppZxVA
        nKCScdfGwatCCEwDAQe71m+VTHtONvZ3fTVPnINWHuoY+1fIIy3ExJpqjaIylq/e
        MTGvmb+2G0gdSEyLCEXy8o0NCudXWbNXwsQdFyTz1+afYPOBmi6E+a7am7gc6xy/
        QdhZwUdMGLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D7E85D2CA;
        Tue, 10 Jan 2017 13:13:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BA885D2C6;
        Tue, 10 Jan 2017 13:13:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net
Subject: Re: [PATCHv8] pathspec: give better message for submodule related pathspec error
References: <CAGZ79kZVKFvijfwEfmiaahz2VYgaa=m2m-ty2tbOXh2toO_muQ@mail.gmail.com>
        <20170109231650.9043-1-sbeller@google.com>
Date:   Tue, 10 Jan 2017 10:13:24 -0800
In-Reply-To: <20170109231650.9043-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 15:16:50 -0800")
Message-ID: <xmqqr34asrzv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A9C1874-D760-11E6-9E71-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>   This comes as a single patch again, replacing sb/pathspec-errors.
>   It goes directly on top of bw/pathspec-cleanup.
>
>   v8:
>   cleaned white spaces in commit message
>   removed TEST_CREATE_SUBMODULE=yes
>   : > instead of touch.
>
>   v7:
>   do not rely on "test_commit -C" being there, nor the infrastructure
>   to request a "good" submodule upstream. Just create a submodule outselves
>   to test in.
>
>   Thanks,
>   Stefan

Thanks, queued.
