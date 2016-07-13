Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A172018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbcGMSKN (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:10:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752613AbcGMSKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:10:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A1E82AAF2;
	Wed, 13 Jul 2016 14:09:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N/k+JZ2Vdvje7fcDhKn/3WOx33I=; b=QZPyK4
	X98bO8TKvFOEqv+2Ow1P8cGvaLzn1ElwPVkfWHD32f4Bd8XH2erUlmPE4LNK4n1N
	2aTLawY8eWoyHp4f879jz42zxuja7k6O1v5m1gR0xJfGFlPdwRoCYL6bmJjpYqGS
	unqNf24P/j08DoMvWuIV402en96eXmilHM3oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWoK3EmtbGOAtMxa2RdKRxIWiRvHSr9X
	zu8B5qhjt/fg294zMceNDoUMWv09wOFtalulXtu7jmu/9I7Kq0g/m3pn4c0P1VhY
	GMGJzQXr3yW/7sM4WfySAxTlx+lK/XWzvmJsxTYR1te3xH50fUAQGZmTIt2eECK4
	W4SEDWpi9P4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62DA22AAF1;
	Wed, 13 Jul 2016 14:09:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E251C2AAF0;
	Wed, 13 Jul 2016 14:09:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	ervion <ervion@cryptolab.net>
Cc:	git@vger.kernel.org
Subject: Re: Https password present in git output
References: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
Date:	Wed, 13 Jul 2016 11:09:42 -0700
In-Reply-To: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
	(ervion@cryptolab.net's message of "Wed, 13 Jul 2016 20:26:27 +0300")
Message-ID: <xmqqd1mh1kbd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA5BFCB6-4924-11E6-B80D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

ervion <ervion@cryptolab.net> writes:

> Sometimes using ssh is not possible and saving https password in plain
> text to disk may be desireable
> (in case of encrypted disk it would be equivalent security with
> caching password in memory).
>
> One possibility for this in git is to save remote in the
> https://username:password@domain.com/repo.git format.

Wasn't netrc support added exactly because users do not want to do
this?
