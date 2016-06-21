Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B6F1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbcFUSjI (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:39:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753000AbcFUSjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:39:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 82D1025C69;
	Tue, 21 Jun 2016 14:35:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9XWmOlcUkPXAqBEBzT69/Jb5ILg=; b=xdKiYr
	t5lOTk4lMzybqCwmEsvCgtK5xRAyxnPk0mQGxwYFh9UBVZMvumEy8Yuex2HJz1lb
	sWFXxpZEFj2QreHXg3hHbYvopWP0MUlzZNyhi7xsNAZjdF0Ps+DR2h3EAqKtRdVY
	dHqWs8WnLYz7pKRuvNSZY2VnOrLB5eROZH73A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsMP2pOrKl8+TqWcE5000g8ddMDSF0p4
	kSr1JdhxOVjperR9V/ZCA3DlAt4WoY1xohkM5GRFrlorGDQ1e5iR68FdPK7AaXll
	JGwjE7uIPI+p51ATeSxyReaHAI9bXUTkuhtoINd1rD+CKVPVag+YBxMZ5I4b2VYZ
	B2vM8lJ5C3k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B14A25C67;
	Tue, 21 Jun 2016 14:35:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E79A525C65;
	Tue, 21 Jun 2016 14:35:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] perf: accommodate for MacOSX
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de>
	<fa788ff09727fc37d8e799dbf1a92e4bba4152c9.1466517188.git.johannes.schindelin@gmx.de>
	<DA5551A9-E3F0-4A59-9B91-206AA74FEAD4@gmail.com>
Date:	Tue, 21 Jun 2016 11:35:25 -0700
In-Reply-To: <DA5551A9-E3F0-4A59-9B91-206AA74FEAD4@gmail.com> (Lars
	Schneider's message of "Tue, 21 Jun 2016 20:03:10 +0200")
Message-ID: <xmqq37o6qtjm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECFC2FDE-37DE-11E6-9BDE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 21 Jun 2016, at 15:53, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>> 
> Looks good to me.

Thanks, both, for following thru.
Will apply.

