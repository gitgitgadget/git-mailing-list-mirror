From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: -r -d(D) should say "remote-tracking branch"
Date: Wed, 06 May 2015 10:53:54 -0700
Message-ID: <xmqq4mnpvbgt.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu5pKiQ76WrCXvziQ8zER-Mc5oVt7tGnC7Q3RMVX2r8ZXQ@mail.gmail.com>
	<CAN0XMOJ8QJ14B15BoFrr7d7L-jE06yUbquo8pW3OCj4wmUk2Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Danny Lin <danny0838@gmail.com>, git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3WG-0001LR-AV
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbbEFRyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:54:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbbEFRx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:53:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F25624F80F;
	Wed,  6 May 2015 13:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyk5gy6G7YforQWEsI8uktTSYs0=; b=xvP++N
	QltYX9jcRazWJXDvA4CCLd6dXRbxzc4D1norNwfRIPolzA+eQVH8TUIbxCKpVJAM
	RFIY2NN9MIM1WVTKfHN+lWamO37psQ6DUc16ZYM2EYl8F69t3CrV3JVoDJ3ILlUp
	D76s8tcYGPFppsJ7ZfbW8KX63w17pRQMvcg0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DiJ2ruGDzZtMSYQzFjb7JmeNQ8SUnHYJ
	vryig0VckaXrCm9IdezLESHMtINlhJNwGEvYVlobvqaTv+GgkseGzHgbDv/GL+ou
	W+GoTdggq2RcUIl8Jvid16TDF6PPfP341H06unSblaKb++q5x005dbEE/KMU7I12
	PaK1EkjIV6Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC3604F80E;
	Wed,  6 May 2015 13:53:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A3144F80B;
	Wed,  6 May 2015 13:53:55 -0400 (EDT)
In-Reply-To: <CAN0XMOJ8QJ14B15BoFrr7d7L-jE06yUbquo8pW3OCj4wmUk2Rw@mail.gmail.com>
	(Ralf Thielow's message of "Wed, 6 May 2015 19:49:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD1A4520-F418-11E4-A5F4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268476>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Danny Lin <danny0838@gmail.com> wrote:
>> git branch -r -d(D) currently says "delete remote branch",
>> which should be "remote-tracking branch".
>> ---
>
> No "Signed-off-by" line. (see Documentation/SubmittingPatches)
>
>>  builtin/branch.c | 6 +++---
>>  po/bg.po         | 6 +++---
>>  po/ca.po         | 6 +++---
>>  po/de.po         | 6 +++---
>>  po/fr.po         | 6 +++---
>>  po/git.pot       | 6 +++---
>>  po/it.po         | 6 +++---
>>  po/pt_PT.po      | 6 +++---
>>  po/sv.po         | 6 +++---
>>  po/vi.po         | 6 +++---
>>  po/zh_CN.po      | 6 +++---
>>  11 files changed, 33 insertions(+), 33 deletions(-)
>>
>
> You don't need to update messages within "po/*" as they're
> updated by the l10n coordinator and translators.

Thanks for pointing it out, but the language should be stronger; not
"don't need to", but "you must not".

Thanks.

>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index dc6f0b2..3560c51 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -242,7 +242,7 @@ static int delete_branches(int argc, const char
>> **argv, int force, int kinds,
>>                          sha1, &flags);
>>          if (!target) {
>>              error(remote_branch
>> -                  ? _("remote branch '%s' not found.")
>> +                  ? _("remote-tracking branch '%s' not found.")
>>                    : _("branch '%s' not found."), bname.buf);
>>              ret = 1;
>>              continue;
>> @@ -257,7 +257,7 @@ static int delete_branches(int argc, const char
>> **argv, int force, int kinds,
>>
>>          if (delete_ref(name, sha1, REF_NODEREF)) {
>>              error(remote_branch
>> -                  ? _("Error deleting remote branch '%s'")
>> +                  ? _("Error deleting remote-tracking branch '%s'")
>>                    : _("Error deleting branch '%s'"),
>>                    bname.buf);
>>              ret = 1;
>> @@ -265,7 +265,7 @@ static int delete_branches(int argc, const char
>> **argv, int force, int kinds,
>>          }
>>          if (!quiet) {
>>              printf(remote_branch
>> -                   ? _("Deleted remote branch %s (was %s).\n")
>> +                   ? _("Deleted remote-tracking branch %s (was %s).\n")
>>                     : _("Deleted branch %s (was %s).\n"),
>>                     bname.buf,
>>                     (flags & REF_ISBROKEN) ? "broken"
>
> Looks good to me.
