From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 06 Aug 2010 16:01:45 -0700
Message-ID: <7viq3n73c6.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
 <7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
 <AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
 <7vmxszamwd.fsf@alter.siamese.dyndns.org>
 <AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
 <7viq3nagje.fsf@alter.siamese.dyndns.org>
 <AANLkTimJCgZ8kU0Nrm6Zi-PXSgT96bFfTi0oaaX2t-6v@mail.gmail.com>
 <AANLkTik1KVpb25nuwSFA2z4ezRJKWdTwRrS_KXzwM+2D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 01:02:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhVvX-0008Mc-IW
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199Ab0HFXCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 19:02:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab0HFXCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 19:02:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DEF5CB4A0;
	Fri,  6 Aug 2010 19:02:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KDBccMa4Bj7t
	PRd1KUBTAA8p5VA=; b=EcG+YmfH6IjaA3zHuAGklHfaYfp/eN31wJ6Mpd4pODFy
	rH7M1I9cQN5wlhlgeIs81MMTJ+DYKi84XLDRtNzIGMfs/lPUV8PItv8QK30KgGI1
	ha3J5S/lx1pG7G5rY0pV0h9eJj/9PYX3DdoSCadRI7QTVvzGMESQEzP+/4imFAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lYIjpN
	Erbfry7i18cp866m4XJbODALxvKORIusKWT84qfvHQoV2r24MP7Utvyso0P2AgLw
	NRhElvvwNMPrlWePf/oLKhNhG4am/wcCsaQHU29RZVgmCIshx6kXcIoVzS52XiA7
	TZqmS77zv/Ld3xqJ7ynrgNw0x8W3a76IrZSYc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2DF1CB49A;
	Fri,  6 Aug 2010 19:01:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC763CB496; Fri,  6 Aug
 2010 19:01:48 -0400 (EDT)
In-Reply-To: <AANLkTik1KVpb25nuwSFA2z4ezRJKWdTwRrS_KXzwM+2D@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 6 Aug
 2010 19\:28\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9A7E5C54-A1AE-11DF-82B7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152824>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> My mental plan for this series has basically been as follows:
>
>   1. Get it to a state where it can cook in pu [You Are Here]
>
>   2. After it's been there for a while get it to master
>
>   3. Once it's there for a while and we're sure the new dependency /
>      code doesn't harm some more obscure systems..
>
>   4. Start submitting patches to the main porcelain $(grep
>      'mainporcelain common' command-list.txt) to make the most common
>      user-visible messages translatable.
>
>   5. Recruit translators to translate the strings in #4. Send
>      translations in as patches adding/altering the *.po files.

Matches my expectations modulo s/master/next/.  The stuff parked in 'pu=
'
was primarily because most of the work to get to this point was done
during the pre-release freeze for 1.7.2 and I didn't want to get
distracted, while I obviously did not lose patches.

> Now, your main concern is that this doesn't break plumbing output....

That's not 'main'.

'Breaking plumbing' is merely an example of a larger 'main concern' whi=
ch
is 'unintended consequences'.

And please don't ask me to enumerate them exhaustively.  By definition
'unintended consequences' cannot be enumerated.  They are discovered ov=
er
time either by code inspection, by people guinea-pigging a version outs=
ide
'master', and by careful thinking.
