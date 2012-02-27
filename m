From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/symbolic-ref.c: add option to output
 shortened ref
Date: Mon, 27 Feb 2012 15:04:50 -0800
Message-ID: <7vpqcz514d.fsf@alter.siamese.dyndns.org>
References: <1330380638-9738-1-git-send-email-jk@jk.gs>
 <7vwr7752s8.fsf@alter.siamese.dyndns.org> <4F4C07AD.3050404@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Feb 28 00:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S29co-0007kD-56
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 00:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab2B0XEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 18:04:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab2B0XEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 18:04:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F6D769C0;
	Mon, 27 Feb 2012 18:04:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C5ARaS+y+Grc
	0O1dHwmB9FVRUQw=; b=mvD/gT25uPrr+uVi0dIwsXtzzRgnbJZZboojkHpqVtFs
	DvL+uDNJqWIVKWsHLfY0Q8Cr+NA7Udzp/7HgOOSdo5A+a4VqcrK5E9iTeSWLEWDp
	oTku6Q1W/JrtiLBQfwb9FVDYd23VahWhonsMalx34Gv8LM5jUWwEbJJe6Wmkr6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o2i6ys
	jamsFlF2XGjzSEUOe4XDITJVb5jJSKKXOmV7ZzNfv2AJ+5MoKe0RNz0MYJLc//Y3
	VmFoZVuijO/mMFYkcZeMHGpJ1XkDb9y/VtVOp2goEoowotccn9g1IdrqzzVBYogC
	/rfBi6Ukgl3Jrb3Pvn6S/I5XRiq2OGeQgpCrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 078AB69BF;
	Mon, 27 Feb 2012 18:04:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9426469BE; Mon, 27 Feb 2012
 18:04:51 -0500 (EST)
In-Reply-To: <4F4C07AD.3050404@jk.gs> ("Jan =?utf-8?Q?Kr=C3=BCger=22's?=
 message of "Mon, 27 Feb 2012 23:46:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7440DF3A-6197-11E1-89F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191690>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> On 02/27/2012 11:28 PM, Junio C Hamano wrote:
>> I think this one (unlike 1/2) makes sense, but a single letter -s fe=
els a
>> bit too vague.  Always spelling in long option "--short" so that it
>> matches "%(refname:short)" in for-each-ref might be better, I would =
think.
>>=20
>> Especially given that the expected use case is primarily in scripts =
not
>> from the command line, being more explicit and easier to read has va=
lue
>> over being short and easier to (mis)type.
>
> Good point. If we can agree on what to do with the first patch, I'll
> change that in the next iteration.

Dropping the first patch would be my preference.  I do not think this
change deserves to be taken hostage to it.
