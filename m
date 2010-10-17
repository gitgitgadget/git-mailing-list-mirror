From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4203 (mailmap): stop hardcoding commit ids and dates
Date: Sat, 16 Oct 2010 21:43:33 -0700
Message-ID: <7vpqv95szu.fsf@alter.siamese.dyndns.org>
References: <87tyksd9er.fsf@meyering.net> <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
 <20101015061821.GE21830@burratino> <20101015075954.GA8557@burratino>
 <20101015171219.GC10204@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	git list <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6C-0003NB-0u
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab0JQEnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 00:43:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0JQEnq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 00:43:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0418DFC1C;
	Sun, 17 Oct 2010 00:43:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=3SfrenKAgd40XPErPKfQ0h2yk
	90=; b=W4B9eBk4ZhfvXH0xKHoLP49vf88Hr/b5VxzOVLejJn5gGhRm3HFroRkGC
	VOeHQEg2negaMYpXp/k0PUffeVQoFptxVwqOVq9bTiD6suH/rGgjhxs1xtSwWo/2
	MMSBKRqvV6F/3cl+1Ya8b2l5RsY+LqX+zUTmxEFfD0OA2FI0a0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=J2yfh4/304UfT4CbABQ
	dNZFF/1mTVyC2dU7AcpyTQQJwUMVw+WHqdrLkPAK2jR5pzcYcD72KL5GTMbtPwtC
	qPjDzItszhkGuBv18c0Yzh0gS+wDFiHeS6pOieC6sehIwnxMhvDH1/gEqV9A1Qws
	uB3GHqzjGr3zWjnL1roq8N68=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74982DFC17;
	Sun, 17 Oct 2010 00:43:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87CA3DFC12; Sun, 17 Oct
 2010 00:43:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D0C158A-D9A9-11DF-BB93-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159193>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here's a better fix.  Still no idea about the other failures =C3=86va=
r
> and Thomas were seeing.

I saw intermittent failures too.  Thanks for the objid fix.
