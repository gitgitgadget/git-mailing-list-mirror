From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 09:49:17 -0700
Message-ID: <7vzjvu6faq.fsf@alter.siamese.dyndns.org>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud1Mu-0002sg-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3EPQtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:49:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3EPQtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:49:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B841F5BB;
	Thu, 16 May 2013 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9QGXOR5wV3uILlKoER9tAyKJiLY=; b=RUDjmy
	Unwx3yrT3GxEMSUFI/0hSHi6WsPT7ft+wJH5Dsy7UcxPWo6l3c7eDcROl+v9fGsN
	u5bzf2G9oojeP6gifNzgY54wAwUD/CAvXH+F5Agm6WM8cmyTr3J0v0sE6km2//3O
	8aMTpPXbODqAoCbwSWX8X2/HGTbg6p6fFl0y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMWR9OUVwNHeDTAj3c6UuAnHYtOT9sVe
	RYLZbZhFm6KaltN0TP4z9mIH9njh/AnWxzCUwPVhuA6CPDPpn1jSmO2qacmavMoq
	1uQzuxES8JIGKA78ScTAQegRxOVe/eh1fd/5S88hMZMfINyukwilYDuRLDOvzGKP
	yCrO2pQR5lI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00AFB1F5BA;
	Thu, 16 May 2013 16:49:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54DF61F5B8;
	Thu, 16 May 2013 16:49:19 +0000 (UTC)
In-Reply-To: <CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 11:32:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D634BE2-BE48-11E2-88C2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224600>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 16, 2013 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> I find it extremely annoying that an obviously correct patch is not
>>> merged...
>>
>> A patch that receives "this breaks style" comments
>
> *Invalid* "this breaks style" comments, because it doesn't break any
> style mentioned in Documentation/CodingGuidelines.

    As for more concrete guidelines, just imitate the existing code
    (this is a good guideline, no matter which project you are
    contributing to). It is always preferable to match the _local_
    convention

The document does not spell out all the details, but that does not
mean you can ignore what others say and many find a sensible style
request.
