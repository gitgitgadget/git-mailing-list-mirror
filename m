Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DD51FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbcFTVAH (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:00:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755381AbcFTVAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2016 17:00:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3676264A9;
	Mon, 20 Jun 2016 16:06:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xfmj4oQgWcG1
	FzSoJZw2VARk3YQ=; b=up8CdDcsY/+6bCLmH5O4ZLYDptx97ZS8ztKDo0fQ7/RO
	NNB/hPi1MgBvVRKCK0wBJIf9F9zgBt1gPj09Aok0aSNKoC0fwiiT9GhNq2NKaMRz
	O4N74k+zGUKbnc6ejn9fJDLmMIDhPxxRiXuyTGDo/EFWKZg7LdUJhsCB5ovhl8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y2+dXL
	S+k81yjaeP3P9GwcYrKo7cZ3KjD7KOZa85NnAGrVJ1JzvlfH67DIpt/RUx5kr+oT
	Aex9UuHKZnfHGDBPBikKWY2oN9SrnExWuapui6QZbzxB7lgYNg/AVoOey1bPOKk/
	wq8pukbQTpGNGZo2cLXx2pDu2dSTc3ogNaZF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B93F4264A8;
	Mon, 20 Jun 2016 16:06:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36D5B264A7;
	Mon, 20 Jun 2016 16:06:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<18617acb-bcdb-607d-007e-552dabd352cb@web.de>
Date:	Mon, 20 Jun 2016 13:06:22 -0700
In-Reply-To: <18617acb-bcdb-607d-007e-552dabd352cb@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 20 Jun 2016 08:06:29
 +0200")
Message-ID: <xmqq60t3tykh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76C3E922-3722-11E6-879B-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> There is a conflict in pu:
> "jh/clean-smudge-annex" does not work together with "tb/convert-peek-in-index"
>
> (And currently pu didn't compile)

Thanks for a report, but didn't I mention this breakage in the
What's cooking report already?
