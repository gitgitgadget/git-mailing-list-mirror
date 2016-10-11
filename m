Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174E51F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbcJKVuS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:50:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65479 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753121AbcJKVuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E54F443093;
        Tue, 11 Oct 2016 17:45:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9JjIcBNwllaztIg5iAdL3orB13Y=; b=gns+le
        CSiFMlPZumjtNJ8zn63VVUKf4dLXdffv0bEnsLWeLa8u3e4DuRHP++w7Z8lDCgCA
        ZvkT28g02vst+DXfytWAjoU45OWR2Zd1SyGd/6GtTAB7UEydLww+yjOnvjfaQpLs
        xt50uhyTose3uu9zfR5LZv/ZrzGsln4JVSk8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nyw2OIIpDV0PmGZwq3mur9zOiSVcffEl
        slHbXqLelZG8boFSK5A5O0GrDgF3v5P5dx+w8AdPz6GKWn4zZUHrE8F9Q+z7f+FH
        92MF/u58ihoqComA0LV8bk3jJVKBfqToGl9qxTepdyqIYF9jS0r3we4NLpT7aKwz
        z4MJtQTCAsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDE6C43092;
        Tue, 11 Oct 2016 17:45:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2266E43091;
        Tue, 11 Oct 2016 17:45:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
Date:   Tue, 11 Oct 2016 14:45:07 -0700
In-Reply-To: <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 14:39:22 -0700")
Message-ID: <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAF88E82-8FFB-11E6-8044-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Oct 11, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
>>   (merged to 'next' on 2016-10-11 at e37425ed17)
>>  + submodule: ignore trailing slash in relative url
>>  + submodule: ignore trailing slash on superproject URL
>>
>>  A minor regression fix for "git submodule".
>>
>>  Will merge to 'master'.
>
> Going by the bug report, this *may* be more than
> minor and worth merging down to maint as well, eventually.

The topic was forked at a reasonably old commit so that it can be
merged as far down to maint-2.9 if we wanted to.  Which means the
regression was fairly old and fix is not all that urgent as well.

Thanks.
