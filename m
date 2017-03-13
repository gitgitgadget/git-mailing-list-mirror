Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A9C1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdCMTNf (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:13:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751703AbdCMTNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:13:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F09F81871;
        Mon, 13 Mar 2017 15:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4KCvTxwOzQ1t
        26K1PKapwJKNiHc=; b=sqUKKsszcNR/BeREIzRnw/YTfi4iK9sIibh3dsoVpvpJ
        LTWAWm7Hgh4DXP0AKSgvestXQiC5m/vHkikioYLHjxKzVJQsP9x0xoTaOel9o56F
        iMXMFeCGfsinaHi+WFYGp+f2nTiztRuXJMqD/bcrNxun6UrnWJBN78B2vL0FRr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=doI9es
        hxrETXsccPxGHVSC5aWGk2Q7lP3kB9WPhDXtPSSEA9kDuxscen897zG/Ft/fucnG
        brUoMWsMPOa+ROaIHITqinZ7LDw9GxvD1QHzZyEGHkxNoRnSalxcCdhluSwgnWvc
        MRmV1CQ00Bb1qVJsr6vRM8d6ZuZQBEQRQXHlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1877B81870;
        Mon, 13 Mar 2017 15:13:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BE768186F;
        Mon, 13 Mar 2017 15:13:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Scian <ascian@auvik.com>
Cc:     git@vger.kernel.org
Subject: Re: 'git add --patch' no longer allows you to select files before selecting patches
References: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com>
Date:   Mon, 13 Mar 2017 12:13:05 -0700
In-Reply-To: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com> (Anthony Scian's
        message of "Mon, 13 Mar 2017 14:51:52 -0400")
Message-ID: <xmqq8to9rnwe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 169F3E04-0821-11E7-9A75-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Scian <ascian@auvik.com> writes:

> Similarly the patch sub-command in =E2=80=98git add =E2=80=94interactiv=
e=E2=80=99 goes
> immediately to selecting patches starting with the first file.  Is
> there a git configuration that would being back the old behaviour?
> Why was this changed?

Because people are careless ;-)=20

The fix is already proposed and in the 'master' branch.  Please keep
using that version to make sure there is no unexpected regression
caused by the fix.

Thanks.
