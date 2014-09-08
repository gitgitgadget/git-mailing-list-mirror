From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] strbuf: export strbuf_addchars()
Date: Mon, 08 Sep 2014 11:32:10 -0700
Message-ID: <xmqqvboym09h.fsf@gitster.dls.corp.google.com>
References: <540C0344.9060002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR3kH-0006Is-3L
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbaIHScx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 14:32:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56898 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbaIHScw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2014 14:32:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3369A36806;
	Mon,  8 Sep 2014 14:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SIoLi8NxQygp
	lRhYsJ5TbcXp/7Q=; b=r6GywE3qfhpIk0ARjEuDWkPFb6ebpcggOScL2VIXe/XT
	RbdSioWFBrbSw+H3oA+m+SR/1x8CM+Yy5IcXwH/pAlJ6Io09TlyVO2Tbvz2bkbR6
	IBawD+ZQqabNyN4dsc9ELN8h23ebMNc1SPYHui23z4okM2nMpN8wNNbEFmEheCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FSC14s
	DzKLMtGSEHURx/UvE9pC+h2du7xe9NbMeAzJ7SOAmFcOKFwwm8rVyb69TFo04FjI
	jXtgY94MuQdqjdfZAurdhpl1P13OvMAZfQkYP0s07PQAKCJhYgm1EzGxMGjXdfmb
	w90A29eWQ9HKf1stjU9veffE2k6GvjqYcSqMw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 287ED36805;
	Mon,  8 Sep 2014 14:32:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07FA8367CE;
	Mon,  8 Sep 2014 14:32:13 -0400 (EDT)
In-Reply-To: <540C0344.9060002@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sun, 07
	Sep 2014 09:03:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 741240E0-3786-11E4-90C2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256667>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Move strbuf_addchars() to strbuf.c, where it belongs, and make it
> available for other callers.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Wow, fixing up v1.7.0.2~9^2~2?

Both patches look correct, but I have to wonder where you are
drawing these clean-up opportunities from?  Almost as if reading
through dormant part of the codebase one of your hobbies or
something ;-)

Jokes aside, I very much appreciate it.  Thanks.
