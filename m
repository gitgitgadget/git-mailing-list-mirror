From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 06 Aug 2010 08:48:21 -0700
Message-ID: <7viq3nagje.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
 <7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
 <AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
 <7vmxszamwd.fsf@alter.siamese.dyndns.org>
 <AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 17:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhP9w-0004NP-LG
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 17:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761146Ab0HFPsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 11:48:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0HFPsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 11:48:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B9E4CBD24;
	Fri,  6 Aug 2010 11:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v6JNeFmTND32
	0Fnx6qJtRb/mlwY=; b=jG6NUNSVH7VIgfGf5RuHcJ8ULwlFdCF36V3RJBenjw4W
	Xol1SvaG3CQz4JDmb1MOqnBc15tAz8spOMkhTbHm9n68F5oUVUGClU2a+LUo5jaH
	EeSlSEQGELIdV7luRVjON2YRNNwtnX13cHsV9aF9ITA5uc30WrVtgPtUJwiAmAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N0pFOr
	LqXszUMCxw1WVGvQCf8TLIRT8u+HFxUSDVuo4en7+QaqRgh6gt/mkPmfwLDro9En
	v5f4fSp2aSRzrno31nSkTc50fWP0qvFF3g85dNhzehcXAkkkwQNNhI1yuITU2jGJ
	f6JgyApaVkVFk047ghHFfWVqDoLaJy3bcok6Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34339CBD22;
	Fri,  6 Aug 2010 11:48:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56A57CBD21; Fri,  6 Aug
 2010 11:48:23 -0400 (EDT)
In-Reply-To: <AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 6 Aug
 2010 14\:03\:54 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DA7345E-A172-11DF-B39D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152791>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 6, 2010 at 13:30, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> That is one good example. =C2=A0Perhaps we can get a list of message=
s that we
>> can place in Documentation/ area (e.g. "'Not up-to-date' - this mess=
age is
>> given when you have local changes in a file in the working tree; giv=
en by
>> command X, Y and Z") out of that effort for free? =C2=A0Perhaps such=
 a list can
>> help us verify that i18n does not break plumbing output (because the=
 list
>> does not contain plumbing messages)?
>
> We'd get this sort of list out of "TRANSLATORS:" comments for
> free. They're automatically extracted and presented to translators an=
d
> others with the xgettext program.
>
> Maintaining a list of messages in Documentation/ somewhere that's
> bound to get out of date with the source code doesn't make sense give=
n
> the TRANSLATORS support.

Read it again---I didn't say "maintaining" a list at all; we are saying
the same thing more or less ;-)  You might need to massage the output f=
rom
TRANSLATORS: comment to a more readable form suitable for inclusion in =
the
documentation (depending on how that thing looks like), though.
