Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51AD1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbcGSSP3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:15:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752868AbcGSSP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:15:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFA9B2DB4A;
	Tue, 19 Jul 2016 14:15:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bw3wxfJgXvpAl6MjgcRD8scStTc=; b=RnArR4
	edCMBw5GIuIIEAE+Zwke7VVqWPXLajuQAPDV70ocV6dyWLaD4bdba1xGOiYlO0js
	mOePexkXbcoPCCTl9hYLjbkJXx424VvzH6bC+hiJwP6K0zHGZnK/ZaWoD+XpcQRw
	yce5jMuJMhELV0kd3rQ7KDy++kKRv8vrK5olg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwMpsJ1IoApmkuaOK8ap9/7So42d1ZSv
	NmCvlV0DZ4/XEN1svByov8d2sqm/pqd4hJRBpezxoctSXc87l+dItV3b4lUhqlN1
	oMMCfY2Vjj8a5bAAO/xPmodIWQB05UasmiRXp7V1gLSbhRTa3RXesc1CoBXm95pO
	Nx5wVmHTdK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A76122DB49;
	Tue, 19 Jul 2016 14:15:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35B012DB46;
	Tue, 19 Jul 2016 14:15:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] difftool: fix argument handling in subdirs
References: <20160719035756.24961-1-davvid@gmail.com>
Date:	Tue, 19 Jul 2016 11:15:24 -0700
In-Reply-To: <20160719035756.24961-1-davvid@gmail.com> (David Aguilar's
	message of "Mon, 18 Jul 2016 20:57:54 -0700")
Message-ID: <xmqq37n5h4ub.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4440382-4DDC-11E6-8298-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> From: John Keeping <john@keeping.me.uk>
>
> When in a subdirectory of a repository, path arguments should be
> ...
> directory.
>
> Reported-by: Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> Acked-by: David Aguilar <davvid@gmail.com>
> ---
> This patch is unchanged from John's version but also includes
> Reported-by and Acked-by lines.

Thanks; will replace.
