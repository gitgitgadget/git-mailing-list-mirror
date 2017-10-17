Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381B7202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 02:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756262AbdJQCqR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 22:46:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755028AbdJQCqP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 22:46:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C47B06B0;
        Mon, 16 Oct 2017 22:46:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m2VBpqA0VT/o8xrpon4X0ueIEPA=; b=kCr1FR
        SAb6qMN1FRhO8/Hdfer5jmGc3gxTeKPb+Eh8HYJrEAS4KGYl4EkPTzqeI9KMoID2
        NyaKsUOfOjBmhD5OLDsOLhYVbpDIuHl5tnbX8gAJTKkAF3kCDZS3UudHxp+Gt+my
        jSrXcKwac0WmLI2fGKJrLQ59c6SnvvcNDdbh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VmxDF09KvEldiwgN4LQKgu9sJSKShqpg
        fLc52jeCAt8HlanbkoLVL6MNGzXVdEToltcsuAKWFlJ6WZK9U5u3llkI+qgLzzxU
        gXNQdjh9ximRtn74n+PUQa6V24NXuxY7JBnWeUdYPi0RusSztmJQULzJmh+gz+89
        doL2Oe7Grs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A138B06AF;
        Mon, 16 Oct 2017 22:46:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 765ABB06AE;
        Mon, 16 Oct 2017 22:46:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Glasser <glasser@meteor.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: list filter-branch subdirectory-filter first
References: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
Date:   Tue, 17 Oct 2017 11:46:13 +0900
In-Reply-To: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
        (David Glasser's message of "Mon, 16 Oct 2017 23:17:12 +0000")
Message-ID: <xmqqy3oapk3u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5798F322-B2E5-11E7-AB06-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Glasser <glasser@meteor.com> writes:

> From: David Glasser <glasser@davidglasser.net>
>
> The docs claim that filters are applied in the listed order, so
> subdirectory-filter should come first.
> ---
>  Documentation/git-filter-branch.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Good.  Could you sign it off?

Somewhat related tangent is that we may want to also reorder the
output from "git filter-branch -h" to the order of filter
application.  For that matter, the order in which the SYNOPSIS
section lists these command line arguments may want to match, both
for consistency and as an extra reminder to the users.

