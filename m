From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Write and Submit Your First Kernel Patch
Date: Fri, 23 Oct 2009 13:58:05 -0700
Message-ID: <7vskd9akv6.fsf@alter.siamese.dyndns.org>
References: <dc1d0f40910231146y14028f4el9753debdf334103@mail.gmail.com>
 <alpine.LNX.2.00.0910231621550.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevyn-Alexandre =?utf-8?Q?Par=C3=A9?= 
	<kevyn.alexandre.pare@gmail.com>, linux-newbie@vger.kernel.org,
	kernel-janitors@vger.kernel.org, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: linux-newbie-owner@vger.kernel.org Fri Oct 23 22:58:24 2009
Return-path: <linux-newbie-owner@vger.kernel.org>
Envelope-to: lnx-linux-newbie@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1RDL-00074q-Q4
	for lnx-linux-newbie@lo.gmane.org; Fri, 23 Oct 2009 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbZJWU6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-newbie@m.gmane.org>);
	Fri, 23 Oct 2009 16:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbZJWU6Q
	(ORCPT <rfc822;linux-newbie-outgoing>);
	Fri, 23 Oct 2009 16:58:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZJWU6O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-newbie@vger.kernel.org>);
	Fri, 23 Oct 2009 16:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A720A64B2A;
	Fri, 23 Oct 2009 16:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uWNRx1iptT2l
	cDl6EI4guUpa5Fg=; b=YK3ZAtV6jb29LHh+XSowAMRexc4Ll/6jDH1nlVWQdd3e
	l6+zfn3NY5hK5M/GbLpm6E1FwF38/f0ybWpbqDcQgJCQoNQuTCASuw9H90o46r67
	bMGzUDaLMN6NIdhqvo0fptzw3o38+rcj3719NkxsHHUYR4I6/g+VOZHVvDEKJBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K2xaYS
	QPcmR0z+q2uwroT70z+//ZBxcKABrS78OHmf/vbWX7sFSqojgE7/JA4ggV55fGfs
	LVTuYPejKQ92hDogr7evTHYcJq9+E/Tw0/QKo6K2SocD6oKcrgGgEDON2ugjkIdI
	uWYkCqjkZvN1Em0wEeTdufuIEqmBP1b29QVo8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDEF64B29;
	Fri, 23 Oct 2009 16:58:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A4264B28; Fri, 23 Oct
 2009 16:58:07 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910231621550.14365@iabervon.org> (Daniel
 Barkalow's message of "Fri\, 23 Oct 2009 16\:33\:04 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C73B378C-C016-11DE-BCAA-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-newbie-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-newbie.vger.kernel.org>
X-Mailing-List: linux-newbie@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131132>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 23 Oct 2009, Kevyn-Alexandre Par=C3=A9 wrote:
>
>> Just before I send my patch I got this error with:
>> ./scripts/checkpatch.pl --terse --file
>> 0001-Staging-comedi-driver-fix-coding-style.patch
>
> You're using checkpatch --file on a patch. I hope you don't intend yo=
ur=20
> patch to be added to the kernel source as a file, but rather applied =
to=20
> the kernel source, changing other files. (I bet "gcc 0001-Staging*.pa=
tch"=20
> will get interesting errors, too...) The patch format adds a single=20
> character at the beginning of each line to say whether it's a additio=
n, a=20
> deletion, or a context line, and the context lines are identified by =
a=20
> space character. This means that a blank context line consists of jus=
t=20
> this space character, which is therefore a trailing space. We get the=
 same=20
> type of complaints when we have expected diff output in our test scri=
pts.
>
> I'm kind of surprised that checkpatch doesn't completely blow up when=
 it's=20
> expecting a source file and getting a patch (and maybe tell you what=20
> you've done). But that's the source of your errors, anyway.

Ah, your analysis is correct.  This is a usage error of checkpatch scri=
pt
and there is nothing for us to worry about.

Thanks; I also failed to spot --file option when I responded.
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
