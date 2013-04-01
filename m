From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/5] merge/pull: verify GPG signatures of commits
 being merged
Date: Mon, 01 Apr 2013 07:55:29 -0700
Message-ID: <7v1uaul2qm.fsf@alter.siamese.dyndns.org>
References: <20130331144452.GF2286@serenity.lan>
 <cover.1364742659.git.jaseg@physik-pool.tu-berlin.de>
 <51585E10.8090505@physik.tu-berlin.de>
 <7vsj3bm0gr.fsf@alter.siamese.dyndns.org>
 <5159832D.3030400@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Mon Apr 01 16:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMg9R-0000eT-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 16:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538Ab3DAOzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 10:55:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758437Ab3DAOzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 10:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04AC911EA0;
	Mon,  1 Apr 2013 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=858YG57sTNjq
	9Wwmbv2Gz7Y3CzQ=; b=FontFWaJ18vaBrI5UvvUOZTZUn5wlHYQt6KAnwV1+EtT
	qrTZPujGnNYOh3dVfrA3J1rdaE2pvGV/0jInstRM2g6DRUqAo/O4tt4hW8b1PNLq
	PCm7KaX60ZYdGJ6fjqP2lmSSCa63CZnwKvEKI5VTYAnfMm641M5H9pTFhhd3khg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o/Utqy
	mfth5RdTkrowiiJJIIbcen2OsRSgptJ12F/nmUbiqn42Z9Yr5PeiYtiO7L0wElYo
	BUtE/+cIBgnXYiz6FIx6JCRP3Y+XoUUVb6F4/7JxkkZ7uLvdchgTzgESXgkyVk3P
	OzuQp+kc/hP8MzDik5tHMeng/3wm7lDw/MhwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0DB011E9F;
	Mon,  1 Apr 2013 14:55:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7510511E9C; Mon,  1 Apr
 2013 14:55:31 +0000 (UTC)
In-Reply-To: <5159832D.3030400@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?= message of "Mon, 01 Apr 2013 14:53:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3312574E-9ADC-11E2-9435-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219690>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> On 04/01/2013 04:47 AM, Junio C Hamano wrote:
>> I'll squash in something like the following and push out the result
>> on 'pu' tonight.  Please check to see if I made silly mistakes while
>> doing so.
>>=20
>> Thanks.
>>=20
>...
> Looks fine to me.

Thanks for a quick response.
