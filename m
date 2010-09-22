From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Wed, 22 Sep 2010 12:26:57 -0700
Message-ID: <7veiclshoe.fsf@alter.siamese.dyndns.org>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
 <7vsk11sjf9.fsf@alter.siamese.dyndns.org>
 <AANLkTimKp+u2QGhR=zFYTSALcxRUr=LQewYRK83uh+U1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 21:27:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUyN-000406-4J
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab0IVT1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 15:27:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab0IVT1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 15:27:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91B0BD634E;
	Wed, 22 Sep 2010 15:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MdVtEFLbFPKg
	TDCeEf8K+XDoC4w=; b=aAXZOP+Pi0pwjZodFjA1KSKkE2XX5QOAP+FtXFHX8Ji1
	fPnKd68cqTzyYZ01x9zN1ihkV+gCR0D880WCHk+oCjgfY2RZQY9LYiexdQHIezu5
	gwJ0x363l8AShdBjEXsEf1mkSi64LeO3/Tn40paVY4pqRuslXSIg9ZMOfUtXchE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fAi/ut
	nrTH4zHTs4w4VcTnsFvDY6Q2GcOO98J7X9COB4SANUtAQzixipK4P+lKtfbjYLtK
	dReDW5yN7fh72tbITwPFAz+qZxhPb5+fSWgEGovsVU1vUF9Cu4orLtFza6EddUXd
	voav1mLnJO6G6qWPgfWprXUGmEenFCEf+2A7s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D5D6D634C;
	Wed, 22 Sep 2010 15:27:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5B43D634A; Wed, 22 Sep
 2010 15:26:59 -0400 (EDT)
In-Reply-To: <AANLkTimKp+u2QGhR=zFYTSALcxRUr=LQewYRK83uh+U1@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 22 Sep
 2010 18\:52\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 605C1BC4-C67F-11DF-918A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156830>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Oops, I didn't try running "make doc". I could write a
> Documentation/git-sh-i18n.txt manpage, but it would probably be bette=
r
> to just remove the patch adding it to command-list.txt, no?

If it is not a documented end-user level command, it shouldn't be in th=
e
list.  Don't you however want to help developers by describing what the
helper offers, similar to how e.g. Documentation/git-sh-setup.txt does?
