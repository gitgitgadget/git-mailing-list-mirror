From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 12:40:04 -0700
Message-ID: <7vr4ehyx2j.fsf@alter.siamese.dyndns.org>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
	<7v8v0p2z45.fsf@alter.siamese.dyndns.org>
	<CALkWK0=dGmMkgvaNV27E3Pb3+SWSZ2pNMOr-wsEcUR_wgLjMFA@mail.gmail.com>
	<7vwqo91dgw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=ZekB9uVtzM_z4wbfZ0JWawaob_PspM9UHbVJKyFGBfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 21:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tIm-0004Hh-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab3G2TkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:40:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab3G2TkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED5F3473B;
	Mon, 29 Jul 2013 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGB4XDIqL7Y0b+LPQFrTNc32HoA=; b=b/ACCV
	NZ7bOogfWuXHHAhGnaWekcuMwteitVs98gsFoWYAIwgTiAQXXA8xiMiQ/5ViVXoB
	n4qCHLZ1E4TiqBL7XyHXjXoE2kD3k2coSPlHVXvKdGM3kj2NvYOaBUQEEZUsADwy
	DXh+h6LJXmPdGYJ11NNqEgDtdhD6v8/gHEZ4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXp49wU5vnOpI5KZ69ptW6IdxjSmar10
	q3b+IggKzQuFgikNcByZ87TKIfvcWNkXHEXpgYJHCBeP0TYXve/LDxdLsWkh2HTA
	XPVNkQoG18Cq/I4Goup/uO20bUtmFQkEp5Er6xzxN7x96KsmZDg/UeUzCv7kNOj4
	fABzQbId+VM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BB063473A;
	Mon, 29 Jul 2013 19:40:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 402F234737;
	Mon, 29 Jul 2013 19:40:06 +0000 (UTC)
In-Reply-To: <CALkWK0=ZekB9uVtzM_z4wbfZ0JWawaob_PspM9UHbVJKyFGBfw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Jul 2013 23:18:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB9872B8-F886-11E2-A547-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231322>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> Junio C Hamano wrote:
>>>> That's a bit strange---the patch text looks like the "how about
>>>> this" patch Duy posted earlier.  Shouldn't it be From: Duy with
>>>> S-o-b: by two of you instead?
>>>
>>> Feel free to amend as you see fit, as always.
>>
>> I was asking what is "correct", without which I cannot "feel free"
>> to do anything, and your answer is not helping.
>
> I don't have a strong opinion either way.

There is no opinion involved.  Maybe the word "correct" had a wrong
connotation, but what I needed to find out was a true provenance of
the change, as that is what the S-o-b chain records.  I did not
know, and I needed to find out, if the patch in question was what
you came up independently without looking at Duy's patch (which is
very understandable as you two were going back and forth digging the
issue on the list), or you submitted his patch after tidying it up.

It appears from your description below that it was an independent
work, so that is what I'll queue.

Thanks.

> Fwiw, I posted the original
> with me as the author because I discovered it, dug through the emacs
> sources for hours to find the exact bug, and contacted emacs-devel
> about it.
