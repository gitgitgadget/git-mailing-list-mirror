From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull suggestion
Date: Mon, 12 Apr 2010 14:35:23 -0700
Message-ID: <7vpr24jqw4.fsf@alter.siamese.dyndns.org>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
 <201004081754.24954.trast@student.ethz.ch>
 <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
 <20100408231154.GB13704@vidovic>
 <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
 <20100409034911.GA4020@coredump.intra.peff.net>
 <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
 <20100410043535.GA22481@coredump.intra.peff.net>
 <m2v3abd05a91004102301i95bf7091ib2bd9da5e8a208c1@mail.gmail.com>
 <7vaataphi7.fsf@alter.siamese.dyndns.org>
 <s2m3abd05a91004121318x22b1f712tdd5600ad656c6b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 23:35:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1RIK-0004n3-Bp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 23:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab0DLVfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 17:35:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab0DLVfl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 17:35:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BEBF3AA5A2;
	Mon, 12 Apr 2010 17:35:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=20UL5Vrda71/MuwhLuZo6JXlnxY=; b=rBH3WX
	We+xsJ+hvA2Qc4z+aWT1gTXCEjmSerecyJ8IFAo5+6sO4HujNVVb3ijR/OcnRH2T
	vqnoYQAjAJPkySifNK72Hx3JVscvJFk/T5Tlvw8kc57tohGja5/ScR4Zfk88AScR
	i664WP455RhvOtMeSzwuFVN2o2gDDL7tTTaTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NP9OXUdSb9IQrF6gLgZ/iQPUxabn+Ke+
	Pb9Cd1H4M7AteUeGX3/FrF14iD+aDY2L9nCpD6Ry7jlirICQGSMLwzfVNeyNsS+e
	obNiuyYSAdP1lEgdy3d5+g22QcHtjtWuW6MAyq/B3CwhIVi/g5dhxLQWO5EpeKi7
	lXE3w8cd/YE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44600AA59A;
	Mon, 12 Apr 2010 17:35:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7E1AA590; Mon, 12 Apr
 2010 17:35:24 -0400 (EDT)
In-Reply-To: <s2m3abd05a91004121318x22b1f712tdd5600ad656c6b13@mail.gmail.com>
 (Aghiles's message of "Mon\, 12 Apr 2010 16\:18\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5306FDB0-467B-11DF-B74F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144769>

Aghiles <aghilesk@gmail.com> writes:

> On Sun, Apr 11, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>
>> The other answer would initially appear a bit sad, but after you think
>> about it, it would turn into an enlightenment, especially for people whose
>> brains have rotten from years and years of CVS/SVN use.
>
> My brain was rotten even _before_ CVS/SVN use, so you can picture
> the damage.

Please don't take that too seriously; it was just me imitating these:

    http://www.youtube.com/watch?v=4XpnKHJAok8
    https://git.wiki.kernel.org/index.php/LinusTalk200705Transcript

;-)

>> ... so I'll leave that as an exercise
>> to the readers but will leave a pictorial hint.
>
> Before I start thinking I already have a question (which says a lot about
> my thinking capacity): can't git detect this problematic case?

The pictorial hint is to illustrate that the case is not necessarily
problematic.
