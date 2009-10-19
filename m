From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use "--no-" prefix to switch off some of checkout 
 dwimmery
Date: Sun, 18 Oct 2009 23:16:36 -0700
Message-ID: <7vhbtv7vsr.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <20091018210222.GA5371@blimp.localdomain>
 <7vzl7omi5z.fsf@alter.siamese.dyndns.org>
 <81b0412b0910182307n53b4a51cvaa14829ea8b40207@mail.gmail.com>
 <81b0412b0910182312h583e74e4v2678eb4375164c34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzlY6-0002Kl-Pz
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbZJSGQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 02:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZJSGQp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:16:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZJSGQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 02:16:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB6C5E3CD;
	Mon, 19 Oct 2009 02:16:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2yXpbRRX+LRY
	EAtWifX0maj6jCE=; b=kCA3TCIbVKU+gj5T4YUWuuawDlWgxZslsJygH5UuUO3M
	j5WXzZuhrIPFosD5KLKXVrioSEv/YqzuAlrF5Yiq/Xk8v61SVZE7snCnYOnemLz+
	BnjFP0w9hWXivG9Zz7lghAWfdXDyQouIDe9zN3PAyS1zIldyo1Mj3l0pLCMSTqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nB58gF
	Ql7Fa3vPCpIatkKC7mOvXGL/pckbavIztGBHIgAE2WIYc7BALTFLP7eIEV1j49ev
	UDNHhC3hL7udU7jHUOiJakxlOedSOoWl4KyAl4LlqpWzL0OX85/D4DNWYeiZLJ+H
	egjRP378jwVh3rsPTYyaS+qzPFeutvQJ9rvwM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E70F35E3CC;
	Mon, 19 Oct 2009 02:16:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 161065E3CB; Mon, 19 Oct
 2009 02:16:37 -0400 (EDT)
In-Reply-To: <81b0412b0910182312h583e74e4v2678eb4375164c34@mail.gmail.com>
 (Alex Riesen's message of "Mon\, 19 Oct 2009 08\:12\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F91BA7A8-BC76-11DE-B947-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130658>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Mon, Oct 19, 2009 at 08:07, Alex Riesen <raa.lkml@gmail.com> wrote=
:
>> On Mon, Oct 19, 2009 at 00:49, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "dwim",=
 &dwim_new_local_branch,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Guess local branch from remote reference (default)",=
 0),
>>>
>>> Humph, how does SET_INT know to set it to 1 with --dwim and set it =
to 0
>>> with --no-dwim?
>>
>> It seems to do, though (I checked before sending).
>>
>
> Right, just looked at the parse-options: it is defined for all types.
>
> parse-options.c +/get_value
>
> 	const int unset =3D flags & OPT_UNSET;
> ...
> 	case OPTION_SET_INT:
> 		*(int *)opt->value =3D unset ? 0 : opt->defval;
> 		return 0;
>
> Very useful.

Ah, did you mean to change the default value to 1 as well?
