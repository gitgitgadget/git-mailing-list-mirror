Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1000C202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 04:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbdJ3E4N (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 00:56:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751302AbdJ3E4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 00:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A2AC96A38;
        Mon, 30 Oct 2017 00:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qjiTbKsjcBfAUkud8hawrfF5Bpg=; b=HtGIdx
        9gPIbV8JsZW+yOdOep4gv51PadB0DL7ePVswxLg4FkpFMRd/+e4c2lbtVnQk64Dp
        aftauCAi+hJURjBQJJiE68wi70r77JBNNt8+WBkTDfGErGPvu2X1v7JjGwKIBKrY
        04NmD4gmqRZMNZBhjanjwnF65ofKdC2VoNx+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H/iBfP0aUEqJw60QMOyzB3u3euCJUJBN
        t17YuTMgT16MueopwmcVHiGFbOKXkJthHGEfaSMhPcFGsVhzl2TbZPtuKSkS3gDW
        iWTNPWyk2omdy7WFMZSDdTmycdNLUdFhjgPgkNw5g9PsuR0qZocIptm3Ozy5zvKH
        tQM8Fu+Ue1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80DE096A37;
        Mon, 30 Oct 2017 00:56:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 004D496A36;
        Mon, 30 Oct 2017 00:56:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/7] refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
References: <cover.1509183413.git.mhagger@alum.mit.edu>
        <173511d3d5382acf25d6648586347104d2f4886d.1509183413.git.mhagger@alum.mit.edu>
Date:   Mon, 30 Oct 2017 13:56:10 +0900
In-Reply-To: <173511d3d5382acf25d6648586347104d2f4886d.1509183413.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 28 Oct 2017 11:49:55 +0200")
Message-ID: <xmqqvaix5j4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6A6C630-BD2E-11E7-BB7E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Even after working with this code for years, I still see this constant
> name as "ref node ref". Rename it to make it's meaning clearer.

Yay ;-).
