From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Documentation/SubmittingPatches: Explain the rationale of git notes
Date: Tue, 30 Dec 2014 08:19:36 -0800
Message-ID: <xmqqzja5rtyf.fsf@gitster.dls.corp.google.com>
References: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
	<1419874942-9901-1-git-send-email-sbeller@google.com>
	<CAPig+cQgG5Ua-k1D8yKF5K+tfXeSB_wTN9W3m08F+K7AtKWDaw@mail.gmail.com>
	<CAGZ79kZxsWZRdaQ-0_9Ou3y0KOruD0WVrC0Drkjgu=TbgUjiSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 17:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5zWN-0006JC-LL
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbaL3QTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 11:19:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbaL3QTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 11:19:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7ED728BBB;
	Tue, 30 Dec 2014 11:19:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=3y82XeBbs3Dc0SdauAZU5kopwnM=; b=tb8zt176IcWSQX19ND/x
	+2ny2Ky58qXjnvcq3+HbLxxRniBrCxVQSZxm9//O8un113ni5hrc/DawTgkPVD8F
	VlN7cqW5Vc1oCzEed2S88tIS8xEnKPXf1N5O12ZQZGPXU8s7NyfUJ3DyVq3PuaNK
	JWtZ0EQKUWZihYbj6IGsccc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hB6Q8fy9LeLeC3mRnKQmz01BxwlddK2ANEXtHQFpQf6I/Z
	Hz8Zoltx+gpWlp6lQIoGFpNPCXYelPUMiRhx76/XJFzUWyLPtWBZacV4G8mwDzL/
	HEOnr3JeA3YMb2A9VgveGI5xwe4rrDRvCzoB6NejB7nAB0laBYsm3wwQHlHkc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEC5B28BBA;
	Tue, 30 Dec 2014 11:19:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7945D28BB2;
	Tue, 30 Dec 2014 11:19:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A648A3D0-903F-11E4-A545-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261925>

Stefan Beller <sbeller@google.com> writes:

>>> +can also be inserted using the `--notes` option. If you are one
>>> +of those developers who cannot write perfect code the first time
>>> +and need multiple iterations of review and discussion, you may
>>> +want to keep track of the changes between different versions of
>>> +a patch using notes and then also use the `--notes` option when
>>> +preparing the patch for submission.
>>
>> Perhaps this could be rephrased in a less derogatory fashion like this:
>
> This wasn't meant to be derogatory at all. It was more of subtle humor.
> Sorry for the confusion.
>
> If this is offensive in any way I'd rather go with your suggestion indeed.

I too found it very close to the borderline between being funny and
being unnecessarily condescending when I first read it and couldn't
tell which side of the line it was on.

It is not if the readers need multiple iterations to get things
perfect (most of us do, anyway).  It is if the readers already have
a good procedure to manage the changes (if they do, they do not need
us to making suggestion to use notes) or they are actively in search
of a good tool to add to their toolbox.  From that point of view,
Eric's rewrite does present a useful tool to keep track of changes
that the readers may want to consider in a lot tamer way.
