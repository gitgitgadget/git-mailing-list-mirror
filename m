Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9462B2055E
	for <e@80x24.org>; Wed,  1 Nov 2017 02:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbdKACwH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 22:52:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932210AbdKACwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 22:52:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57005BC899;
        Tue, 31 Oct 2017 22:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nii1c9j/L9OVY/P2H0Wov8lQfGQ=; b=wZKY+m
        4jNOcngtQMorH2Qy6KyBcgZaploy4j1JJxIe6Bk5Nef3VWxZRNAX21Lu5AWVqfC7
        FvAV4nB2oZcMgeZdMAyaviPpsfpaHX7wEczpT1BnwQ8EN/h3TUh24bQoGgW+9gFO
        Kivj0vmQd4ygvDQjzZ5vlK1unB8DbullVEq3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C/S4c4aTcaz1ccA91oly+YfahTJqOOa5
        ThkyIWZ/b8YYaTMy6e2Z0utNvPuGRe8mWLGA0eo4z/xwuhfzkczQ4kfQqLsmbarY
        Neak+mdDSfgh3rYyhliDhJtN7IL6VobOVOLnOhaaLRO16L5OfTFMECvLPSSu5JEq
        M8o77so0Y9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F4DEBC898;
        Tue, 31 Oct 2017 22:52:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6F09BC897;
        Tue, 31 Oct 2017 22:52:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] diff: remove DIFF_OPT_CLR macro
References: <20171030194646.27473-1-bmwill@google.com>
        <20171031181911.42687-1-bmwill@google.com>
        <20171031181911.42687-8-bmwill@google.com>
        <CAGZ79kbgeVhi46vU9YzSyuvgFLFCZddFatUaopJDG=o=cU6dcw@mail.gmail.com>
Date:   Wed, 01 Nov 2017 11:52:04 +0900
In-Reply-To: <CAGZ79kbgeVhi46vU9YzSyuvgFLFCZddFatUaopJDG=o=cU6dcw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 31 Oct 2017 14:44:00 -0700")
Message-ID: <xmqqbmkmww17.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A533FB24-BEAF-11E7-9C9C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Oct 31, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
>> Remove the `DIFF_OPT_SET` macro and instead set the flags directly.
>
>  _CLR here

Will squash in. Thanks.
