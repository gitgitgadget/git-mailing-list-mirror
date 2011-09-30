From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Updated tag 'junio-gpg-pub' ?
Date: Fri, 30 Sep 2011 08:21:31 -0700
Message-ID: <7voby2oy2s.fsf@alter.siamese.dyndns.org>
References: <4E856676.3050209@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 17:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9euB-0006yl-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 17:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab1I3PVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 11:21:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab1I3PVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 11:21:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B27A14F0C;
	Fri, 30 Sep 2011 11:21:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yPhWhhK2rLtq
	ED1Sbahz8wtb7Pg=; b=XNwvlMykiJgO5zXepiQtvAgJKDyVI/XFgptpivhvHVeY
	NT4wrQ0vvsSMHBZDSdhCQIB34CfRSd7a+MmIANtYRYVRbRtVbMSFkvkbRgL+Qfiu
	9l1g53kgkko4mfUHcPr44PmXozK2a2ns3/nYf5fCY7oROjPLvhNxOOHrngbOBBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oKXvOI
	cRW0FaLqd8ncK2B3nwOKrDDt2jUUv6OSp5O1sT8eCiOj7cFxY5R1cVlAn+ZrMl6n
	xwP40qrWTT4MH1XpO/VaOR245TV8qO13s30K9kN8M/eo28v7X4sx/Sj0iLFf1IhF
	IeFILXsomCDjAsrPx9jMOGnsxVkQwbRIig2SM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA64D4F05;
	Fri, 30 Sep 2011 11:21:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28EFC4F03; Fri, 30 Sep 2011
 11:21:33 -0400 (EDT)
In-Reply-To: <4E856676.3050209@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of "Fri, 30 Sep 2011 08:49:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E120EB2C-EB77-11E0-814C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182485>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

> Junio,
>
> I haven't seen any announcement of this:
>
>> Fetching origin
>> >From http://github.com/gitster/git
>> - [tag update]      junio-gpg-pub -> junio-gpg-pub
>
> Did you update your GPG key ?

I removed a user@my-old-isp.com from the list of uids contained within =
the
public key, and I updated that tag to point at a blob that records a ne=
w
export of the result.  The "key" itself is not updated (it uses the sam=
e
crypto material).  People who got my public key from the old tag should
still be able to run "verify-tag" and get the right result.

Thanks for noticing.
