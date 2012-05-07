From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Mon, 07 May 2012 10:52:19 -0700
Message-ID: <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 19:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRS6o-0005Q6-4s
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 19:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab2EGRwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 13:52:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982Ab2EGRwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 13:52:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 310B76707;
	Mon,  7 May 2012 13:52:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=S5Yo5V8CTuIZ
	pz5glI+/5ErJQlw=; b=SPsjoFgWGMQjYotGqUDqcaHqLTHaFgnn/de3F3kv9NaO
	AH9gzJAbNdKbitYnz4FGHQqB/MWzubA7s1eETN9RJRSOHdKL2EmZzlOIdC4EM/A6
	cc0Tdrl85EwfK5ieIYio91mH7xFfcGQaleUJSd8qu7/wVJfltdeRdlkJMZqHU5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZoMlKu
	EOIuvuYyH8VGuyt2pxBY/f465Wq9WPxbjEwVikcNp4TE5iGtSslu66TKydP6/NWn
	nTJvEzdLHEWU6RJVeRLNjLhsN5jgTirGsuDx5VSn1JCshsqvP1UNtljO2YGJnNWx
	7ZKjTFFFCz0osEegOT3/feMadfFAjm2yD0d8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CF26706;
	Mon,  7 May 2012 13:52:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB5FA6705; Mon,  7 May 2012
 13:52:21 -0400 (EDT)
In-Reply-To: <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 6 May
 2012 23:30:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65878A7C-986D-11E1-8ACE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197287>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, May 6, 2012 at 11:16 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I don't know, precommit is not an English word, and it was discussed
>> before, but not many people vouched for it.
>
> FWIW in the Icelandic translation I translated "index/stage" to the
> equivalent of "the commit area".

Care to explain why you did not use a translation of the verb/noun
"stage"?  I actually was having a hard time to come up with Japanese
translation (not that I have plan to contribute to ja_JP.po), as the
shipping/logistics term "to stage" does not cleanly translate to the
language without unnecessary connotation that imply what is described i=
s
something the our "index" actually is _not_.
