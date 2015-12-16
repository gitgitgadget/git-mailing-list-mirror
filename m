From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Wed, 16 Dec 2015 10:04:39 -0800
Message-ID: <xmqqk2oee0co.fsf@gitster.mtv.corp.google.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
	<56710B96.30103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 19:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9GRR-0006uQ-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 19:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934676AbbLPSEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2015 13:04:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934352AbbLPSEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 13:04:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7B6E342FC;
	Wed, 16 Dec 2015 13:04:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BOVsH+2FpkKO
	kveHHmkYy/riHyA=; b=KxFkDjFXvrLd0q4T1w+c/4a0uSC1C4H4J59QmekbFCa/
	G2aPgsht59JMJLjDPTB9/0M9LpuwJPLjv0ZzrwaNO4uCnzlYOwdAetQL2a8qsVaU
	tCiu6reigXZB2+kE2w/b82AN9r7wwzJYE1mNqzOTqbixu0GeZeKRiS69pBZC8HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DzQVW0
	CrPgLNEVurjtzydQN0xf2YICJOKxJO88whCuoIMNHr0mtukpkWYjLSjh/QIVvVXn
	VEAqLKdjt4yuu0F1FQ9Am82b2rwWgXdSaSDw4EofoQJZ5uVKT36oJt9z/DFauqLv
	HOABymTzoGkx2dlNriWHWi71ezA8CO8cWWazg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F76B342FB;
	Wed, 16 Dec 2015 13:04:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18905342F8;
	Wed, 16 Dec 2015 13:04:41 -0500 (EST)
In-Reply-To: <56710B96.30103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Wed, 16 Dec 2015 07:58:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A848576-A41F-11E5-8F78-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282578>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 15.12.15 23:48, Junio C Hamano wrote:
>> * tb/ls-files-eol (2015-11-28) 2 commits
>>  - convert.c: mark a file-local function static
>>  - ls-files: Add eol diagnostics
>>=20
>>  Add options to ls-files to help diagnose end-of-line problems.
>>=20
>>  This latest round hasn't gotten any review yet.
>>=20
>>  Waiting for review.
>
> The latest review are here: $gmane/281785 $gmane/282061
> And a re-roll is planned the next weeks, sorry for delay.

Thanks.  In the meantime, I'll pick up v6 $gmane/282061 and replace
the above with it.
