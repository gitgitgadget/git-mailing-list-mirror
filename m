Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F742018F
	for <e@80x24.org>; Sun, 17 Jul 2016 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbcGQTGz (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 15:06:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751142AbcGQTGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 15:06:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FA522C2A1;
	Sun, 17 Jul 2016 15:06:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=axyUuuMsvk+IjK5LexLY4rZcfio=; b=thSkpW
	dzTEizuUVTo4pYxiNuJsu5ViOmmvmKxP/BcmVC5u5LVIAO9NAXqFo6xll2vb1qC8
	9B3t0KCgrxtxpYNx6swhiY5qqYVyP6AWHNIBZOIStiFdeshf577s69kZcwCaIDpC
	09jIfvFu+rmz8CdLW+ap666deogV9sqmf46OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYY/EFjGcKMMZEP0o1uppPGNIAjKfQNE
	2sgx/p+h99oOriXdAa5loQ3MyJU+qFxP7smgvhIUo271qCwf/iRFqeQ1xz75A9ls
	Qr1+1eEJC4M+RElwbiSCCHBThTJuDtflC5d73yg5hruhZ1MfDSNYUw7mssuauvPW
	oWHZMd6fjDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27BC42C2A0;
	Sun, 17 Jul 2016 15:06:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6C8A2C29F;
	Sun, 17 Jul 2016 15:06:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	mappu <mappu04@gmail.com>, git@vger.kernel.org
Subject: Re: proposal: allow git clone for http-hosted bundles
References: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
	<20160717064513.GA2049@sigill.intra.peff.net>
Date:	Sun, 17 Jul 2016 12:06:50 -0700
In-Reply-To: <20160717064513.GA2049@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 17 Jul 2016 02:45:13 -0400")
Message-ID: <xmqqd1mckrsl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F1D28D6-4C51-11E6-8128-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You might do better to stick a shim script in your $PATH to just
> intercept the calls to git. Hacky, but it would probably solve your
> problem with a minimal amount of code.

I recently learned about http://repo.or.cz/git.git/bundles which
is a very nicely done set of instructions ;-)
