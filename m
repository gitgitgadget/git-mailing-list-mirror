From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/10] Add colors to interactive git-clean
Date: Sun, 12 May 2013 22:28:41 -0700
Message-ID: <7vhai7qwhi.fsf@alter.siamese.dyndns.org>
References: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
	<vpqfvxsi0gw.fsf@grenoble-inp.fr>
	<CANYiYbGqZ6FiHTZgejrA3a-njffQNJyaefFmCWfycuE6PGjwbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 07:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UblJj-0006aw-At
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 07:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3EMF2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 01:28:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab3EMF2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 01:28:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A681ADBA;
	Mon, 13 May 2013 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=afI4sDIgJ64rtBDY/o1S+sVXHmU=; b=OSFwwa
	ZszKNGRMvCF2uXoivqNLZzGQuFK5rYlOOgOODrbn3ZIAm1abAORVk84tm3nYyKi7
	06dX2/TA5mEeg9qwIIpTImiq0nI+gNsuTJn9goT31lY1m3BNLC6pWAiCyDtDgJab
	h2uif9Fw66W8QWvv0YUkIUMGxAhWuN5gsw3bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhExBLe3P74BU4aMDoXK8oZ0X3oAvukO
	ADviXqPyMzpdGEbZ+GziQqoS3lp0hBABSNuwLyYSiCG/anz9mqSaVhmNoq4LsCkb
	aRxylCie1+RCUkF0WqDfuEIbO45E+Uh6L75Z5k4N/hPwp0yvHNFpbjNHuxuhMu5x
	pmTIro115ao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5CB61ADB8;
	Mon, 13 May 2013 05:28:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6631D1ADB7;
	Mon, 13 May 2013 05:28:43 +0000 (UTC)
In-Reply-To: <CANYiYbGqZ6FiHTZgejrA3a-njffQNJyaefFmCWfycuE6PGjwbA@mail.gmail.com>
	(Jiang Xin's message of "Mon, 13 May 2013 10:47:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA0A6CC0-BB8D-11E2-874A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224091>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/5/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>>  * color.interactive.<slot>: Use customized color for interactive
>>>    git-clean output (like git add --interactive). <slot> may be
>>>    prompt, header, help or error.
>>
>> This should go to the documentation (a short summary is welcome in the
>> commit messages in addition, but users won't read this...)
>>
>>> +     if (!prefixcmp(var, "color.interactive.")) {
>>> +             int slot = parse_clean_color_slot(var, 18);
>>
>> For readability and maintainability: please use
>> strlen("color.interactive."), not 18.
>
> Feel like conventional:
>
>     git grep -C2 prefixcmp builtin/apply.c builtin/archive.c
> builtin/branch.c builtin/checkout.c
>
> But maybe 18 characters are too long. ;-)

Why does it even have to know where the prefix ends or how long the
prefix is?

Doesn't it suggest that perhaps the parse_clean_color_slot()'s
external interface is misdesigned?  In the other examples you
showed, e.g.

    builtin/apply.c:	if (!prefixcmp(buffer, "delta ")) {
    builtin/apply.c-		patch_method = BINARY_DELTA_DEFLATED;
    builtin/apply.c-		origlen = strtoul(buffer + 6, NULL, 10);

we are calling external libraries that are designed to take a
pointer to a character, but the parse-clean-color-slot knows that it
is fed the name of a configuration variable and it knows the shape
of its input far better than a generic function like strtoul(), no?
