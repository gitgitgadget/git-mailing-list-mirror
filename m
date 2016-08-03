Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1727F1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbcHCP7J (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:59:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753185AbcHCP7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:59:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC9DB2E4A8;
	Wed,  3 Aug 2016 11:58:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8QfEYJHH9/DgGbcS6undS/ghD0=; b=YWrAte
	KjcfqocmR6yJ++ezH1pmHOCarDSrRS2kRl8+1UT+YSol3ddm8cuKNCFxFH13WNex
	8LJqPhULleQfvKwDf90PbYqUBnzMnAHTsSGdnAeel1cTAKRugAySNlzIJQ9wu+gB
	fG0WHY5qHstvqxvsqVvoH5/uZwIFMYSDVWz1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AgClMV3Sq9TxPtHRyn6hfBGXoKG8rnBn
	4fMypO351nt+8SQ91tGnqx750DUgcyRE8ci0gWHr8DMhaa18wrrgsdKfC/7N9AIB
	A3v1tjvWqHHSBkecPHCTjroqlv/WzVc3tM2IV+1UsXgG2eM9WEJrZZz6jOdTUroS
	Ee+BZ8BgQcw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E454A2E4A7;
	Wed,  3 Aug 2016 11:58:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A9682E4A6;
	Wed,  3 Aug 2016 11:58:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Chris Packham <judge.packham@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
References: <20160803084743.3299-1-judge.packham@gmail.com>
Date:	Wed, 03 Aug 2016 08:58:56 -0700
In-Reply-To: <20160803084743.3299-1-judge.packham@gmail.com> (Chris Packham's
	message of "Wed, 3 Aug 2016 20:47:43 +1200")
Message-ID: <xmqqvazhalof.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30296724-5993-11E6-9770-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> This is similar to the existing "reword" command in that it can be used
> to update the commit message the difference is that the editor presented
> to the user for the commit. It provides a useful shorthand for "exec git
> commit --amend --no-edit -s"

Hmm, what should those who want to amend and sign do, though?
