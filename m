From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 09:50:52 -0700
Message-ID: <7vtxusbpub.fsf@alter.siamese.dyndns.org>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
 <7vboh1eew2.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjxw-0002OP-2l
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab2ITQu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab2ITQuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:50:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B7D498A7;
	Thu, 20 Sep 2012 12:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mEnQPDXINTgfX3pCG0FEUVq4eiM=; b=ec0Qht
	MSFR3s0eQONGCnZYphLEHKobRJqchs96n8bFLJT4j2dc8FblgAO2SPiewmGh5GKQ
	uHLdcMTmfbOvwBOwKi+6NyNwRIgLaNTdOc0Pzi3wDEEQQj1MTpTlrNxjHLDb2LCe
	ScDVkOrCmdOZWZm8kzt9ckOw9Jd+l9jEiHoyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XyM+h16HN1pdeQcpsj60jrJFkt/8mGhI
	OMMgDiwDxRJrfqjIV8sqn0H0Eb9knsV9HYslV9yvio+SssfolESAs7gXTexR5QyA
	EFiL1m47U3mJcdmhCOa15ITGGSyGComSk3dC91GhBl4Ntir1qOmj5fQ2CP11Y2Sv
	4vwPF+MNS/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E6898A6;
	Thu, 20 Sep 2012 12:50:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D7E098A5; Thu, 20 Sep 2012
 12:50:53 -0400 (EDT)
In-Reply-To: <CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com> (Adam
 Spiers's message of "Thu, 20 Sep 2012 01:25:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 572960C2-0343-11E2-B28B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206054>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Sep 20, 2012 at 1:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> ---
>>
>> No explanation why this is a good idea, nor sign-off?
>
> I realised I forgot the sign-off seconds after sending :-(
>
> Isn't it completely self-explanatory? e.g.
>
>     test_expect_code: command exited with 0, we wanted 128 git foo bar
>
> clearly makes more sense than
>
>     test_expect_code: command exited with 0, we wanted 128 from: git foo bar

test_expect_code: command exited with 0, we wanted 128: git foo bar

would be shorter and equally legible, I would think.

In any case, the proposed commit log message should have explained
these differences in the first place so that I or others do not have
to ask.

Do you want this queued on top of your other series, or as an
independent change?
