From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 27 Oct 2014 13:19:32 -0700
Message-ID: <xmqqy4s1qn8r.fsf@gitster.dls.corp.google.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
	<CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
	<54461483.9010600@drmicha.warpmail.net>
	<xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
	<54477C18.5060806@drmicha.warpmail.net>
	<20141023010927.GE312818@vauxhall.crustytoothpaste.net>
	<544D44AB.1080305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiqlQ-000335-K2
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 21:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaJ0UTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 16:19:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751593AbaJ0UTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 16:19:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3FD01967B;
	Mon, 27 Oct 2014 16:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M8NATqfeV8vo
	et4Y9lRG9qD8EVo=; b=gB/3/RFCVwpaSxp0q5kpkR2ZWhtVnKgsybHOJJuzVlyF
	clkwFIghJD2tCJHGXjMV+zEU5RQVgxj66D9eJ7FqY99DEJzVnyoGavyqe+/uaNMv
	x9bEy2tDx3kQbRAzjcS6eJDjqTJiYRg/eK2mwmn8oanLsqPF49rj35oWDWOKmFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B9XcAL
	8u7fYJfDzdqyUzUnMy4VKhg34T7P922X3/+r6aSw5lQzcMD5mBkprCBElKtZ1Wbw
	SeWMzeiMO/hBi2eERI5EDmtS7+QskCLHxhMVeAuCwDS0ENfzMI3gaqqXcBWn9DoZ
	5odtktGANYRRdNVtrm8Q8b0doQSMfeVowLFF0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAA5D1967A;
	Mon, 27 Oct 2014 16:19:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DD8D19679;
	Mon, 27 Oct 2014 16:19:34 -0400 (EDT)
In-Reply-To: <544D44AB.1080305@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sun, 26
	Oct 2014 19:59:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91118730-5E16-11E4-B0EC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> That's by design -- extended headers are meant to be extracted as
> plain files by implementations that do not understand them.
>
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/pax.html
> says: "If a particular implementation does not recognize the type, or
> the user does not have appropriate privilege to create that type, the
> file shall be extracted as if it were a regular file if the file type
> is defined to have a meaning for the size field that could cause data
> logical records to be written on the medium [...]."

Ahh, thanks for digging this up.  I knew POSIX said something about
this somewhere when I responded (and that is why I said "even though
I wouldn't have minded if the original implementation were to apply
the same umask for these entries that look like "dummy files" to
them."), but I didn't have patience to read it through myself.

> It's surprising and sad to see *pax* implementations not supporting
> pax extended headers in 2014, though.  It seems long file names
> etc. are not common enough.  Or perhaps pax is simply not used that
> much.

I would say that if we really want strictness, the _right_ way
forward might be:

 - Use tar.paxumask patch from Linus, to allow those who are aware
   of and care about the older pax implementations (i.e. Brian), to
   optionally tweak umasks applied to those extended header entries,
   while keeping the traditional behaviour as the default;

 - Warn that the default will change to use tar.paxumask that is the
   same as tar.umask in some future version of Git;

 - In some future version, flip the default.

Given that it will be a race between us flipping the default and the
affected implementations of extraction tools going extinct, however,
I do not think such a transition would be of high priority.
