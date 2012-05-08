From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Mon, 07 May 2012 21:06:44 -0700
Message-ID: <7v62c71fl7.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 06:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRbhM-0001bM-9O
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 06:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab2EHEGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 00:06:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074Ab2EHEGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 00:06:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B358EDA;
	Tue,  8 May 2012 00:06:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5EMbeZE9NkVc
	Hi8U0/lXLdBNFlo=; b=BvUYjLNkUqyCo1tqY5pL8Bh/A57iI8NC4WrVbOkzlzEw
	N+EEir76lG/lM3Seqh9BF/DpazDs1xGAwt6eQoLBQKQB/MotG+IxYzVY4z6JpOUo
	tmFGapCW6A7EXzL/rYX1lx9/ereEREPu2LaVMx4R/duV6pMBIHEgCDEzwvsc7to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NnMGVn
	/NQbKpEfYUv/gZuBbloKHKhWeKWETf4SQi5gkyt5OWjjh8o3KZMaF4R5RCm3mgA0
	fpWUCLXoiyu25TG7xLBTs1HZfaypT63yEsB4ggaSRO5gI435f1x4jreGxzPVdKQO
	xkx3J5BJVcXecZPOGP2H0Fe2Ve68iekZXvMkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964D28ED9;
	Tue,  8 May 2012 00:06:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20FBA8ED8; Tue,  8 May 2012
 00:06:46 -0400 (EDT)
In-Reply-To: <CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 7 May
 2012 22:05:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A491CBC-98C3-11E1-89F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197337>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, May 7, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
>> ... I actually was having a hard time to come up with Japanese
>> translation (not that I have plan to contribute to ja_JP.po), as the
>> shipping/logistics term "to stage" does not cleanly translate to the
>> language without unnecessary connotation that imply what is describe=
d is
>> something the our "index" actually is _not_.
>
> Because there's no equivalent of "stage" in Icelandic that would make
> sense as both a verb and a noun. There's a word that means "step" (as
> in a step on a ladder"), but it doesn't make much sense to say that
> you'd "step something".

Japanese stopped inventing their own words for imported concepts mid 20=
th
century and mostly use English words phonetically transliterated these
days. The word "index" is quite well understood: that which points at t=
he
information given a headword that refers to it, which is exactly what t=
he
"index" we have is. On the other hand, "to stage/staging area" is not a=
s
widely used outside the narrow shipping/logistics circles.

I actually was hoping that Japanese was a minority to have trouble with
the word "stage" (and my not being a professional translator did not he=
lp
the matter), and we could declare "it is stage from now on", update the
documentation, rename the .git/index to .git/stage (not strictly needed=
,
and I am not looking forward to it, as it would be a messy and pointles=
s
transition with backward compatibility headaches) and be done with it, =
if
we wanted to.

But sadly it seems that it may not be the case, at least unless you are
familiar with the shipping/logicstics lingo in English, if you are not
native.  I didn't necessarily wanted to use "stage", it is "sad" becaus=
e a
new word-hunt may be needed for a replacement to "index" (as "stage" ma=
y
not be a good word for i18n audience), and then we would need to keep
"index", "stage" and that third word as interchangeable terms.

Spliting the userbase by introducing a new form to an established
terminology was bad enough, and making that three is worse.
