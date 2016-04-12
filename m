From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 6/6] commit: add a commit.verbose config variable
Date: Tue, 12 Apr 2016 15:18:06 -0700
Message-ID: <xmqqtwj6o4ip.fsf@gitster.mtv.corp.google.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
	<xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
	<xmqqy48io6bh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:18:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq6dT-0001v1-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbcDLWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:18:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756453AbcDLWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:18:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C03D550BA;
	Tue, 12 Apr 2016 18:18:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fu+soE6VaSqrKM2eOig/zzXxjCM=; b=qV0BAu
	jCcgRLnbYuQJmti9v7cKsKhbKmCPQs7JCrllyQTPAB25wHBBdFWV9vHU4Ffg/QK/
	LznyQNcrhoRLCl2wNKZc4gJf8rtrxikpAHoX/MvUJvdIUSPGcNsUb4eYdBJ9+/J6
	R8DgrRfAny1l5JDbd6qGJLKVqxyRMa0NA2ttQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DOTc0cuhqCBIxtl0kvML983G02Lq07XQ
	ToC751TR6Wl1zq7Nl0z9S2RJ5jI0oULgq82Y7dJjukxWcrQz0KnN0AktcmzHrAVY
	yUD3LLDJVMEchVa3fYD4J9QA4290Ghb0SWnPf4mPmRd388h0ejLqG51iZC9jxJQ6
	qZvNYKpx7dI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21769550B9;
	Tue, 12 Apr 2016 18:18:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94B6E550B8;
	Tue, 12 Apr 2016 18:18:07 -0400 (EDT)
In-Reply-To: <xmqqy48io6bh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 14:39:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F0CDF74-00FC-11E6-B23C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291302>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmph, isn't this already in 'next', hence we cannot accept a
>> replacement patch?
>
> As a one-time measure, I'll revert the previous one
>
> 50f0d20d (commit: add a commit.verbose config variable, 2016-03-14)
>
> out of 'next' and queue this one instead on 'pu'.

I queued these 6 patches on 'master' and merged to 'pu', but it
seems the series breaks t0040, so in the meantime, I ejected the
whole thing.
