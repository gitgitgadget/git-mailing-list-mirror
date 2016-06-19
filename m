Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8612B20189
	for <e@80x24.org>; Sun, 19 Jun 2016 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcFSVHG (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 17:07:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286AbcFSVHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 17:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA47A24508;
	Sun, 19 Jun 2016 17:06:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D0oj6gTdcPhhxuBc49czujIVjsM=; b=xP7eBL
	Yi/d54ezeXD6LZVcAYQuXq2ty4A7DUqnniONnZeZEapRZuA4unHb8b6Yk9FTJqRD
	GwUlON31+QWXVTOksJhhd7PPhy3eJeDVMVFgkD70joWe9UoJk/Gdtftdzpl3n29y
	hImfVqh9T6CzTsvu/+uXIJzyYl/ZrGi9zp09o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TWZQ1lgeoM281PI45WjzEybEX+9OZkj+
	Ig+oMoa2vbt7RxpaCpPQd8dQQOXjACYlJY+IrXguCQNH17FCeOTj4fOOghAHQaDU
	3MDAHlRl8J1iBtp5M5tyoBzJ7k8O+pj7he93xyEPNirMw2Rx+8sEox7sk7aMlNPn
	KX8D/poDuyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E311224507;
	Sun, 19 Jun 2016 17:06:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70B0124506;
	Sun, 19 Jun 2016 17:06:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
References: <xmqqvb15vz3y.fsf@gitster.mtv.corp.google.com>
	<20160619180928.16255-1-cuong.manhle.vn@gmail.com>
Date:	Sun, 19 Jun 2016 14:06:15 -0700
In-Reply-To: <20160619180928.16255-1-cuong.manhle.vn@gmail.com> (LE Manh
	Cuong's message of "Mon, 20 Jun 2016 01:09:28 +0700")
Message-ID: <xmqq37o8x514.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA16A510-3661-11E6-A638-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

LE Manh Cuong <cuong.manhle.vn@gmail.com> writes:

> It's really a good commit message, better than mine.
>
> So must I make another patch or you will update the commit message?
>
> PS: This is the first time I submit a patch to Git, so forgive me
> if I made any silly questions.

I can locally amend by replacing the log message when I queue your
original patch, now we seem to have agreed how it should read.

Thanks.
