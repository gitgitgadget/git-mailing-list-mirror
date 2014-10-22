From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix match highlighting for combined patterns with context lines
Date: Wed, 22 Oct 2014 12:14:13 -0700
Message-ID: <xmqq38afj4sa.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<xmqqh9yxz0pc.fsf@gitster.dls.corp.google.com>
	<xmqqoat5hwri.fsf@gitster.dls.corp.google.com>
	<CAKJhZwTQpxiFp1BLed9jHRaPeF_ZuXQ7u6YGNp--UjyAyGZerw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:14:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh1MU-0004UB-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 21:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbaJVTOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 15:14:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754996AbaJVTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 15:14:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34A5D179CA;
	Wed, 22 Oct 2014 15:14:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gFh6ABKWialEv97g95Nb7u7yBo4=; b=IGir7D
	ggcaE0sn4+aXAWXaW9Ydj1PNTER8CIZaVk54ivuUtKcQyvjp6Ac7jtW9uNizE4kl
	Nyw40oIuyFKVdTXG9H68CO1AaU5FQ+ISXdd0uoDLuUmlDYxRcG26mXhxtWwOjyu2
	CvmEKSPQsK9dlBDBtrjpSeGmp1twlssKYQg0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eORfXOjVqKndiGXxuoTV/h+pXEo1ww4j
	7eVUotoPgsqsmNmw26U5BAqLw4w/GUirl/QCklsTNB8NHy0W0CB5+UU484iov8Gx
	RGIukI3LYUlYPCHkHpWBwJb0NBGuEEivnG8ZXsujqxQVGqKlJgtPATGTR0nmmdW8
	AfIi1GCd13Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C51C179C8;
	Wed, 22 Oct 2014 15:14:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5C61179C7;
	Wed, 22 Oct 2014 15:14:14 -0400 (EDT)
In-Reply-To: <CAKJhZwTQpxiFp1BLed9jHRaPeF_ZuXQ7u6YGNp--UjyAyGZerw@mail.gmail.com>
	(Zoltan Klinger's message of "Wed, 22 Oct 2014 11:45:19 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9CB47BC4-5A1F-11E4-9F49-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> It turns out that the result of such a change becomes more readable
>> than the original, in that it makes it clear that reinspection of
>> the lines are done only for matched ones and not context lines.
>>
>>
> Agree, it looks much clearer now. Happy if you squashed your
> change (commit da736e6) in zk/grep-color-words branch.

OK, will do.  Thanks.
