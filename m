Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C9220196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcGNPs0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:48:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751149AbcGNPsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:48:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A7BB29ECF;
	Thu, 14 Jul 2016 11:48:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Txyi68HoGHJCZ9BUzLZWwBo1UVU=; b=VlKT51
	25EdOb/K1NASp8kv8QaUHArEx0+GeDegh9i52XYTsb3BtR4JitM4+/RTEZESFdgq
	BWIPlJ8eWJeqxXWE/xOrrTHZ28a8rfTrHMfJ6Vnk6brBhzvM2Ioc/pnpwwMtBD6y
	qnoVFSZjvx246QomTNlSRWH8VmHK3hoioAk8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFhsEcL1bQU11Hvtri1F91BuS2y2VWBt
	UKHiTlQsE3kQV6RCR+Js9qD/y4sqcNmuBhh3dZHxrnqhReYuYaKV/9PNrqZEpnvy
	g7ZNGyunrGpqfDwYWjYbtpxwJ7Q7CBx2SzWc6SbEQ5XYZR/cmrBAHLaIwKbo+jCs
	U8ivsFDRMYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6410C29ECE;
	Thu, 14 Jul 2016 11:48:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEEDF29ECD;
	Thu, 14 Jul 2016 11:48:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607141542250.6426@virtualbox>
Date:	Thu, 14 Jul 2016 08:48:20 -0700
In-Reply-To: <alpine.DEB.2.20.1607141542250.6426@virtualbox> (Johannes
	Schindelin's message of "Thu, 14 Jul 2016 15:46:27 +0200 (CEST)")
Message-ID: <xmqqvb08rzjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65193914-49DA-11E6-B0DD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh, and v14 has a bug that I reported already:
> http://article.gmane.org/gmane.comp.version-control.git/298949

These two lines are the most helpful kind of response to "What's
cooking" report.  Highly appreciated.

The value of the report to me primarily is to make sure other people
can _stop_ me from merging things prematurely.

Thanks.
