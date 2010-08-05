From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cooking of the ab/i18n series
Date: Thu, 05 Aug 2010 15:18:39 -0700
Message-ID: <7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:18:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8m7-0005Un-6a
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab0HEWSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 18:18:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0HEWSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 18:18:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5461CCB9CA;
	Thu,  5 Aug 2010 18:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l9NNJYc8eKv2
	8pZIgYNBTH5upCQ=; b=TRdXaPHW991msx+G8My3Ln2L8H/5Z/vpy3/zoo3vc++u
	v3pF/AmBxOedZU11KLShXu+6yWz4tD7embbHi8iQjSY3XXxzmAyLC8rJlvovOrIp
	RZ5WVOU0JSd55upPd1IQ+697HzQ1+Pcjhqr/kvnVBaooGAJ0NoMonsSH2jnTS5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jMiBMo
	0Q27P0uu8Dv2dICd49V72tbfcteaK60Wk/SjqSaxx9pk5bLqH22G2qaXDQ3EjwAF
	gGl1ekokW/SvriOUy5EWowfqrVJjevAHsVWgv5XvZKCvZ3rX6oHzbEVPAmO+QA3o
	zEzCRc8TFWcKYoZC5Wb9Qepe1b+HFfaqhLnps=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30DB3CB9C3;
	Thu,  5 Aug 2010 18:18:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 702E7CB9BC; Thu,  5 Aug
 2010 18:18:41 -0400 (EDT)
In-Reply-To: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 5 Aug
 2010 21\:09\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68DAD99A-A0DF-11DF-8804-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152730>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Aug 4, 2010 at 22:24, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Since we're asking about the status of series...
>
>> * tr/ab-i18n-fix (2010-07-25) 1 commit
>> =C2=A0- tests: locate i18n lib&data correctly under --valgrind
>> =C2=A0(this branch uses ab/i18n.)
>
>> * ab/i18n (2010-07-19) 2 commits
>> =C2=A0- tests: rename test to work around GNU gettext bug
>> =C2=A0- Add infrastructure for translating Git with gettext
>> =C2=A0(this branch is used by tr/ab-i18n-fix.)
>
> Do you have any plans for when to merge the i18n series?

When people see the benefit of doing so.  I currently do not see much n=
eed
for it myself but I am a minority ;-).

> It's been cooking for a while now, and it'll need a lot of follow-up
> work (gettextizing) once it gets merged.

Yeah, and s/once/before/ probably.
