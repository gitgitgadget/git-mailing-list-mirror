Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A58C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965791AbdCVS4d (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:56:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58206 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965787AbdCVS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:56:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DB487ACB4;
        Wed, 22 Mar 2017 14:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=755/QoCv+NSY2QLIrfO4+sbfgTA=; b=kHaD4Z
        XjWfZjUhLqGBErUEv+wnC2W6iJ+kyHa8fMyTB33wdAsDv3u1QSKqiHoRaOfQONv6
        8LHDfb0Pj8WMwQ73bs4sNs3sZ2FrA5zo4tZkSnOnpqVmlsri7YFRIvMozzZd46do
        K6Ilo6KuofLfki+mv/ARyNUks9OHMe0m4WwZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jzBIcmmZ5qMVagKXcDj9h+Pdrqe3zyOi
        vKkpACc3UDiEkKkqZCqw890wOsaYiBLkWwbetr/lwMNOnUl6J7ZR2fB0q3f3wo/9
        yIEPRrBrIiolMoXUNAtAYcLE/hZv+Odh4rnPSGW1am3cM2C8Ao8cRF4rkj1ZqCYd
        KkCKJxjv6AE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 172AC7ACB3;
        Wed, 22 Mar 2017 14:56:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 750627ACB1;
        Wed, 22 Mar 2017 14:56:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170320210225.13046-1-jn.avila@free.fr>
        <20170320210225.13046-3-jn.avila@free.fr>
        <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
        <5036581a-f989-2db6-06ba-621db05c6de1@free.fr>
        <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZBq+dL7hEj108DPU5KbVeJX2nYEw88jS0Eq78GxzCabA@mail.gmail.com>
Date:   Wed, 22 Mar 2017 11:56:28 -0700
In-Reply-To: <CAGZ79kZBq+dL7hEj108DPU5KbVeJX2nYEw88jS0Eq78GxzCabA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 22 Mar 2017 11:41:23 -0700")
Message-ID: <xmqq1stpkun7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 421AD892-0F31-11E7-B5D0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I wonder if we could have partial functionality for these "clone and checkout"
> fake submodules, by having e.g. the .gitmodules file telling you the URL
> and path, but no recorded gitlink in the tree.

You can have such a comment in any file including .gitmodules but
would that even be a feature?  

A comment in the INSTALL file was what I had in mind, at least while
we are getting more familiar with the proposed two project structure
and before we commit to use the submodule mechanism to bind them
together.

> So we'd want to be able to say:
>   "get a tarball including all submodules except the superproject"
>   (This would produce the "optional language pack tarball")

You do not need that.  Just go to the gitman-l10n project and grab a
tarball out of it.

>   "get a tarball including the superproject and only one submodule"
>   (This would produce the "I can distribute this in locally as everyone
>   speaks the same language in the organisation" tarball)

We don't need that, either, even though some other project would.
"git archive --recurse-submodules" with properly implemented
pathspec support will solve that.
