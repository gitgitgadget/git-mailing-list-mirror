From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 11:34:52 -0700
Message-ID: <7v1vaym27n.fsf@alter.siamese.dyndns.org>
References: <20100720163822.GA8492@localhost.localdomain>
 <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil> <7veieym3sh.fsf@alter.siamese.dyndns.org> <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHes-0005kc-WB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761376Ab0GTSfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 14:35:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab0GTSfG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 14:35:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E5FC62F5;
	Tue, 20 Jul 2010 14:35:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=euMoTr7xMPeh
	c0Nuu6YjpmdtBy4=; b=QgIplWPfq2k4C4U8HGSSlbX1mVLbCN9YXt4EjeJms9nQ
	wzhO2eZdlNd8r27+yMKehWtBb+74fgjjjEG7bExsgTwyM/cRTJvdnHwwezXf0Qb/
	eIiFF1PSo4OKzTxq97SQTMMmzZN/Eyq6f32yo7m1sbce5CIDqbtQNeSVkzznx1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cFKiWX
	g2jBhJImCEPqK7RaF+FvAohtzUzgG3M9KX9SeHMDicneHtm0Zy9sufCb1gcoDArR
	1tbUi8jQoJLqy8Qjy06NekE7RNH5kZCXXUeiCRWNzvi5AqASOOETmZBEYr9F7pQx
	6wPCfGTekyndQKotvMOa0y3hHWYlyaAYlHs0Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2DBBC62F2;
	Tue, 20 Jul 2010 14:34:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F200C62E9; Tue, 20 Jul
 2010 14:34:53 -0400 (EDT)
In-Reply-To: <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 20 Jul
 2010 18\:06\:58 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8099A160-942D-11DF-AA20-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151346>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 20, 2010 at 18:00, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> =C2=A0 =C2=A0Run a git command and ensure it fails in a controlled w=
ay. =C2=A0Use
>> =C2=A0 =C2=A0this instead of "! <git-command>". =C2=A0When git-comma=
nd dies due to a
>> =C2=A0 =C2=A0segfault, test_must_fail diagnoses it as an error; "! <=
git-command>"
>> =C2=A0 =C2=A0treats it as just another expected failure. letting suc=
h a bug go
>> =C2=A0 =C2=A0unnoticed.
>
> To add to that:
>
>     Don't use test_must_fail to negate the return values of commands
>     on the system like grep, sed etc. If we can't trust that the core
>     utilities won't randomly segfault we might as well die horribly.

I think you are being incoherent.  If we can't trust system "grep" and =
it
randomly segfaults, then a test:

    git some-command >actual &&
    ! grep string-that-should-not-be-in-the-output actual

would _pass_ when the command segfaults.  I do agree with you that "We
might as well die horribly", and the way you do so is by protecting the
test with test_must_fail, like this:

    git some-command >actual &&
    test_must_fail grep string-that-should-not-be-in-the-output actual

Having said that, as we _do_ trust system tools to a certain degree, we=
 do
not care very deeply about this.  IOW, I wouldn't want to see a patch t=
hat
rewrites "! grep" to "test_must_fail grep".

Thanks.
