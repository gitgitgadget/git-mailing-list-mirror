From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Documentation/git-checkout.txt: Inconsistent naming of paths arguments
Date: Fri, 19 Jul 2013 07:36:16 -0700
Message-ID: <7va9lizkf3.fsf@alter.siamese.dyndns.org>
References: <CAJTcR-1RxLEaUe+c5yXEuKeC5Ert4FGm0=kUi7H-M-a+-Cp9-g@mail.gmail.com>
	<CACsJy8DdVxwsf5xyDSDCe97kTPGdjvwQcMEPRNCCGXjF1z4eyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam =?utf-8?Q?Brengesj=C3=B6?= <ca.brengesjo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 16:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0BnE-0000C6-C9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab3GSOgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 10:36:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab3GSOgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 10:36:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F7AE2F743;
	Fri, 19 Jul 2013 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wmntt5XDtung
	pzqe2rsFpZkjOEk=; b=d42M19SMXQrrdYH5neif3CLsc3Tv2X0U1nIV2YEEDdlm
	nT914TBe3vG+aJdltoNWGocMcY2ajO303VRgJXN3gWf2hCqJ03s21preQbpLxq2t
	2k8BLgsTsWz5JGynq4HMVtQtOtXFQ2UwAMl2TqcSIcogpD9CwUawVWAwpLzkoFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qetOrV
	rfq4Jl3ejNo5oPCNI3qJHRN/H7TWhPd7bIro75CwoH8TnhMAtyAjYXHP4GsaGhmh
	pA3et33hz8vS0Ia38vqAXALqKRxIF/qyX0J/A0+vRd6vb5oK34Z1M07xDp7OpdfY
	XsB/gNJ9XAFPx4/9fngcaWeLvn+4aGz7jPgto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33DA72F741;
	Fri, 19 Jul 2013 14:36:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 814062F73F;
	Fri, 19 Jul 2013 14:36:18 +0000 (UTC)
In-Reply-To: <CACsJy8DdVxwsf5xyDSDCe97kTPGdjvwQcMEPRNCCGXjF1z4eyw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 19 Jul 2013 14:40:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92E393FA-F080-11E2-8017-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230809>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jul 19, 2013 at 2:16 PM, Adam Brengesj=C3=B6 <ca.brengesjo@gm=
ail.com> wrote:
>> From SYNOPSIS:
>>
>> git checkout [-p|--patch] [<tree-ish>] [--] [<paths>=E2=80=A6]
>>
>>
>> From DESCRIPTION
>>
>> git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>=E2=80=A6
>>
>>
>>
>> 1. Named <paths> in SYNOPSIS, but <pathspec> in DESCRIPTION. (It's
>> referred to as <path> in the body text).
>>
>> 2. <paths> is marked as optional in SYNOPSIS, but <pathspec> is not.
>>
>> I'm not submitting a patch now, as I'm not sure which is correct.
>
> If I'm not mistaken, "git checkout" takes pathspec in all cases.

Correct.

And I think -p form (which I do not use myself so please double
check) can be run with an empty pathspec.

It looks somewhat idiotic that

	git checkout master
        git checout -p next

will finish on the 'master' branch, with random selected bits of
differences for 'master' to go to 'next' applied to the index and
the working tree, but that seems to be how it works.
