Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2776C2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2996054AbcHEUaT (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:30:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2996182AbcHEUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 240BA33CCA;
	Fri,  5 Aug 2016 16:30:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6tDleuNNM7XjaDm7SHr5T2CYko=; b=ttkh/m
	M3qFa9HtieCO+uBXC/1lHIc5EYeCKtfQM0ltnKfMxwRDXWI1mLQ5zNRgHlHUAuHN
	iZ6wBxhRVZnUPOM+9T49hnihCCcCmon9SvnuzNmfvdqSxdNFR1VJV+/clJOCQBZX
	0Om8QrXLt8UJqDrFkDQiRTzqPYrfN4Gs7lsGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0XOOvtF0OLouLDLBnfuX7bL/3vtDUH5
	vHDuBRgB8x63O+DkhLrArvqpYvtLzNPMANlds8yL9J6NR3otqXt+7tZbo1UtkBDX
	exVDzjPdNpSBd2HurPzbA8aJQVD7DfjPKg+WSdgDSZmgzV8mtryf0GLS4+3F6a3x
	GTnHI0XmA/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A40533CC8;
	Fri,  5 Aug 2016 16:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E51E133CC5;
	Fri,  5 Aug 2016 16:30:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 1/6] t7408: modernize style
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-2-sbeller@google.com>
Date:	Fri, 05 Aug 2016 13:30:11 -0700
In-Reply-To: <20160804195159.7788-2-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:54 -0700")
Message-ID: <xmqqk2fvvu0c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69F1B498-5B4B-11E6-8FC9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> No functional change intended. This commit only changes formatting
> to the style we recently use, e.g. starting the body of a test with a
> single quote on the same line as the header, and then having the test
> indented in the following lines.
>
> Whenever we change directories, we do that in subshells.

All look sensible; I think it is OK to also do minor and trivial
tweaks here, but let's see what 2/6 does.
