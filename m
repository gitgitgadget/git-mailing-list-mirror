From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase: fix typo
Date: Mon, 29 Jul 2013 10:32:15 -0700
Message-ID: <7vsiyx1dcw.fsf@alter.siamese.dyndns.org>
References: <1375071883-3017-1-git-send-email-ralf.thielow@gmail.com>
	<CALkWK0=8Ue7-a0nz0NafB6-a6J=3Waw4oy0rr5Q-Cj8ypA0FdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:32:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rJF-0002yq-HA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360Ab3G2RcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758355Ab3G2RcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:32:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 343A534BD2;
	Mon, 29 Jul 2013 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S71MEYLDE0i6fg241n/F5RZB1Jk=; b=DVvvFM
	uOILF+TuPJ/mU37C31wQboMODmCnK9FZnh0T1pjHBxX6xC2UNwPmsgtw4LxoS1+2
	mZcfj6onTbgvRxWCceCcaMXK+AfxMxjiopeBIApbsKT5t9MRufvBnL5ffr32rvf7
	nH7uI0OH3e8lpimZG/f+wYpqmMsLzTAVeuWpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPxQTlL+LGwe/KFacP6W44SxjwgOafXs
	nbHeheT6jpg9gXDwfch5YkObkZZA1Tz4i8KpzoCpFb9W7uuDjuxZlzRuZBAzM4O7
	2//wFUmm5aPEAy18stlNfRiTBRTS+dXte7WbkwCsWZkkAYclSb+L4vA/lbeIWUAX
	O0KCdukRRgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2795334BD1;
	Mon, 29 Jul 2013 17:32:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FC2B34BCE;
	Mon, 29 Jul 2013 17:32:18 +0000 (UTC)
In-Reply-To: <CALkWK0=8Ue7-a0nz0NafB6-a6J=3Waw4oy0rr5Q-Cj8ypA0FdQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Jul 2013 15:58:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1128644-F874-11E2-B889-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231304>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ralf Thielow wrote:
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 0039ecf..8d7659a 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -159,7 +159,7 @@ finish_rebase () {
>>                         die "$(eval_gettext "Cannot store \$stash_sha1")"
>>                         gettext 'Applying autostash resulted in conflicts.
>>  Your changes are safe in the stash.
>> -You can run "git stash pop" or "git stash drop" it at any time.
>> +You can run "git stash pop" or "git stash drop" at any time.
>
> Good eyes, thanks.

Thanks.
