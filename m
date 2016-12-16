Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DCB1FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 00:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757296AbcLPAHz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 19:07:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65330 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757293AbcLPAHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 19:07:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07817595C9;
        Thu, 15 Dec 2016 19:07:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sVRY7mDjiOvphFJnJpkn2XFUCXw=; b=EDgJqk
        ikdREuCZ7PUpHclh1iim9f4OXLKMopGEjkeVo4Hsv223AX4rcR4UlklW/ZRWg6hy
        prW/rtDJxX/6rfUbk4dHG95X9HnPG8W5AJGpexmI9faYjfi+Jqt0aRR5mNHaiQ6b
        XU1y5iTGRQd9mNaGnciKCU71UcRTftVWiEmmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TIAJEFBFRyWN1BBghcdHabyBBneriGww
        lgU2B+hJ70wUPlbvyPzHJmm3MH5x7YAn4IaR/HUIWNyxRTjJwMqscU36ZosUaLnm
        XXN0i/nDdsGnR3YfPP5JqN8AhotMLxGOmCW/IcQbMeTxIwENMnKwkwGs0ldvfhL6
        Yb9nv7aafK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2FD9595C8;
        Thu, 15 Dec 2016 19:07:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66B7D595C7;
        Thu, 15 Dec 2016 19:07:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Larry Minton <larry.minton@autodesk.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Is there a way to have local changes in a branch 'bake' while working in different branches?
References: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
Date:   Thu, 15 Dec 2016 16:07:47 -0800
In-Reply-To: <14b481f95c5043aca6cdfddfe4728fa9@BLUPR79MB001.MGDADSK.autodesk.com>
        (Larry Minton's message of "Thu, 15 Dec 2016 20:14:58 +0000")
Message-ID: <xmqqwpf0u46k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD8DB9F0-C323-11E6-93FE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Larry Minton <larry.minton@autodesk.com> writes:

> Lars Schneider recommended I ask you this question.
>
> My question:
>
> Let's say I have a code change that I want to 'bake' for a while
> locally, just to make sure some edge case doesn't pop up while I
> am working on other things. Is there any practical way of doing
> that?

That sounds exactly like what I have been doing for the past several
years in public around here ;-)

