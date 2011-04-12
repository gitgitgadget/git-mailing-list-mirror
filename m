From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 7/7] i18n: mark checkout plural warning for
 translation
Date: Tue, 12 Apr 2011 13:57:19 -0700
Message-ID: <7vzknvnq6o.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-8-git-send-email-avarab@gmail.com>
 <7vipukq6m0.fsf@alter.siamese.dyndns.org>
 <BANLkTimjYxz_7v8gyByjKX2Mf9vRzukWGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9keW-00056b-D5
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 22:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab1DLU5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 16:57:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155Ab1DLU5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 16:57:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2BED4901;
	Tue, 12 Apr 2011 16:59:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A1qP98HeQ7kB
	whv7hu8UTATGyoE=; b=KfOZvaPDiwKvYwhVUUDCh9E4R6keRuYO+XhWPfkrn17F
	mPTkD9VAoia3BXnojxHVGDiMevbvIPubdCpK4i3AJgpFELDFVz8ci8zBLZZ9FhfI
	J1fr5Jeax20jmsIopWy7S++vojgzmrIsIFRoAEba4tl4K2int8vipcxZIHI6V+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WAb4ID
	5/wcHdzME+XUFdUWRcWhKJoJJV+67uPPeXeFjozYbnAcC8p9wOoqxrmvsu4yQlnK
	ygzTG1CbcOCSFAxL6HelCNfRdiDRhHaWGjQd4djn073KSRB7Ah6vEuVjQwMhwCI3
	mkAmtg5xHisxH8QUn3MtSqRRuEQeqBTLYc4lQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 90C7348FF;
	Tue, 12 Apr 2011 16:59:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF2EA48FE; Tue, 12 Apr 2011
 16:59:18 -0400 (EDT)
In-Reply-To: <BANLkTimjYxz_7v8gyByjKX2Mf9vRzukWGw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 12 Apr
 2011 09:54:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD5BFBC0-6547-11E0-BE95-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171419>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +             "Warning: you are leaving %d commit behind, "
>>> ...
>>>               "If you want to keep them by creating a new branch, "
>>
>> s/them/it/ as this is a singular case, no?
>
> I just used the message as-is, we were using that for the singular be=
fore.

Heh, you cannot claim innocence in this case; it used to be "leaving %d
commit(s) behind, ... if you want _them_", which was consistent with th=
e
earlier use of "commit(s)" ;-).
