From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] t/t5503-tagfollow: change from skip_all=* to prereq 
 skip
Date: Thu, 12 Aug 2010 10:23:21 -0700
Message-ID: <7vtymzsq2e.fsf@alter.siamese.dyndns.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
 <1281469968-25670-5-git-send-email-avarab@gmail.com>
 <7vtyn1xaom.fsf@alter.siamese.dyndns.org>
 <AANLkTimcft23Tbe9=iFPvNyf6Goyk6jBQ1XCzsQJeNtv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbVE-0001RI-TF
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab0HLRXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 13:23:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab0HLRX1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 13:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71057CDA3A;
	Thu, 12 Aug 2010 13:23:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IqlO6JqBF4WIJIxxpsiYQa9Vn
	CQ=; b=SZyXUxJk6bOuKAgWQDz3yIB7lL87lZVgHlzKbR2GrnAAs4il60kRODDIU
	f+JKR0ZyimImvZ41pLIEYxkEQ6ShuwUYXFPdDkwXTpTobJzySi6a1gMmKd2DF5a1
	e1v/MfnhO3JqDAryi0iogvyKCgRA14or7AAM6zgr7O7qahxz/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=BOINyQb/Emsv/uIkHPf
	pn207+16+SyHC7MrebyqcwFQkcxXAaGBH7oKIWyGW0GY6OOKpXtjLX0ZfNpbfNr+
	KnG9ad1i4SeaC9wPIQHCinCzHAIxQZ4tnOTEHuKTfWrsvyx3nNNb6U37Qk3SEmsq
	fHlgeo/r/hGHat2pcDcNvSqc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC89CDA37;
	Thu, 12 Aug 2010 13:23:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAB9BCDA36; Thu, 12 Aug
 2010 13:23:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5076E4BE-A636-11DF-81D3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153394>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Aug 11, 2010 at 18:32, Junio C Hamano <gitster@pobox.com> wro=
te:
>> To =C3=86var; isn't the prerequisite for these tests "does our git s=
upport send
>> pack debugging?" not "are we not running on mingw?" =C2=A0Let's call=
 it
>> DEBUG_SEND_PACK or something.
>
> I have no idea, sorry. I was just changing the way we do skips. I
> don't have access to a Windows system, and I don't know if this skip
> should be uname -s based.

Ok, somebody who adds a port that does not support git-send-pack debugg=
ing
can worry about updating this later; for now, "the platform is mingw" a=
nd
"the platform does not support send-pack debugging" are the same thing.
