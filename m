Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1610B203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbcGZUxE (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:53:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752531AbcGZUxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:53:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C0C33044D;
	Tue, 26 Jul 2016 16:53:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLrRvL/r6FGdZBsTtk3K5nn2krk=; b=psNDay
	p/R05mhFcDjObXlNJvtpXecGre9/3JYJdhtXhbzyQOJR9vBREH1tv2bONFoH9/15
	qbjmNQZ88Tb7gy0I0HmAtZgUVUQODDmy2HNDfHq6b2hXCv/sk6wyal6oY9WFKW72
	R+alSFtHWAoUS/e1QdUdogBczCO5r9zzjlV4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/+y/fvhBU5cAT8GEXlCISGJQ6EDdHGW
	HC8xlGHjO8eFbmwEPko75oE+FkuQLkoEnZiwVYKJjjmUq8Y/N7n5+xIQxn9+eoto
	NcIEO9ZQx8qT+OQk3snpABfD8XFJz8dNucBmZaOUcNCKuOT7DxnZVeYoTT4ykV54
	zb/iB+rwljI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8427C3044C;
	Tue, 26 Jul 2016 16:53:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA5BC30449;
	Tue, 26 Jul 2016 16:53:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH]submodule deinit: remove outdated comment
References: <20160726003538.30990-1-sbeller@google.com>
Date:	Tue, 26 Jul 2016 13:52:58 -0700
In-Reply-To: <20160726003538.30990-1-sbeller@google.com> (Stefan Beller's
	message of "Mon, 25 Jul 2016 17:35:38 -0700")
Message-ID: <xmqqk2g8yvdh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F08150EE-5372-11E6-8A0A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   This is logically part of origin/sb/submodule-deinit-all, but this change
>   failed to be there on time.

Thanks; let's queue it there and fast-track it down to 'master'.
