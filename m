Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D6E1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbcHQPbr (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:31:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751495AbcHQPbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:31:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E8BF34C16;
	Wed, 17 Aug 2016 11:31:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ctSfwCaGGzzVwWBbQAaiwPmdXo=; b=dslnl0
	Rl9lyx3sTnSlRzEkrk3dRCb066x7KLU1hK45C0LcZJtKPn/+kBVMflkh1c98+HDt
	TZEoELZ5gf9sdN6FD0CGz5gcgAn80Fxsh3nhHYXnP4rPsQZ1q5yULknlDk0+HHCU
	GzOG2gmIin741BYkaUtVYryYM4yIeW61rOzgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v0BLSk99BzHX6y5MFOQBoZSOO5+1omcM
	+l2sxJbnYThaYiMygw50OGFbbzbu/L5rql3lund7IGtN00yH4wu5uG2epKcX3jFM
	SP9XvqeevLWt7GdHxoY5aNickdiOK7gSMtUuuN49O5AJmZ/eZpUMEhO4+ZE4t7vx
	iw/vVt9KYvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 774D734C15;
	Wed, 17 Aug 2016 11:31:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F314034C13;
	Wed, 17 Aug 2016 11:31:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc:	Stephen Morton <stephen.morton@nokia.com>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org
Subject: Re: git cherry-pick conflict error message is deceptive when cherry-picking multiple commits
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
	<CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com>
	<f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
	<1592315356.1230893.1471443850115.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Date:	Wed, 17 Aug 2016 08:31:43 -0700
In-Reply-To: <1592315356.1230893.1471443850115.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 17 Aug 2016 16:24:10 +0200
	(CEST)")
Message-ID: <xmqqa8gbbee8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B460AF5A-648F-11E6-A183-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Either way (3 or 4 lines) I find it strange to have both advices
> start in the same way except that one is split and not the other.

True.
