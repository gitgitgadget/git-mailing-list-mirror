From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] grep: add more information to hunk separators
Date: Mon, 26 Mar 2012 14:19:01 -0700
Message-ID: <7v8vinnjqy.fsf@alter.siamese.dyndns.org>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
 <4F709664.1060206@lsrfire.ath.cx> <7vobrjp7gu.fsf@alter.siamese.dyndns.org>
 <4F70DBAC.4010609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:19:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCHJm-0004D4-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 23:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab2CZVTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 17:19:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756212Ab2CZVTE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 17:19:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA687B02;
	Mon, 26 Mar 2012 17:19:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h3jCv+xJoPCR
	Q099qyfFpcrNto0=; b=b2tZ/y/P9lyKnfRy5CbbjVZKjzY4i3ug5cKJaXjOPunK
	4kgjPtL1LD4LU+6UyFnfTI2DMMzgp79avtqj7D3YAJBYwbRAZDTo35xpDV6S1WXr
	+XbS6twnM0x/KcyQVPypDqU3iZJk9otf6owGw8RABdy2Xd+5uqXGmlSU4SXptOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NV+oZC
	cxo0rLl0KPc4oQL49oZH0tuNw2gp63pSJ2djKFzLt8v4ohUr+PdVTXDd44HkWHAj
	V8TREoqWzA7l/hWyTjsuoVJMNLycyg3ZUE+cKgKGErQeyJriDtstL17YgzTvDkat
	Fog+QFf42x2/ESLDcOE8/syzdLCfqtasALq4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D381E7B01;
	Mon, 26 Mar 2012 17:19:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDCCD7AFE; Mon, 26 Mar 2012
 17:19:02 -0400 (EDT)
In-Reply-To: <4F70DBAC.4010609@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 26 Mar 2012 23:12:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FB33EC6-7789-11E1-8FC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193978>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> What we also could do: Produce a valid unified diff that would remove
> the matching lines if we were to apply it (or the --reverse, i.e. +
> instead of -).  Then we wouldn't need to invent a special format, but
> the output would be a bit more verbose due to the added +++ lines.

Hrm, certainly that is an option that saves a lot of thinking.

As people tend to learn to focus more on '+' lines when reading patches=
 in
the unified context format, the reverse option would produce output tha=
t
is easier to read, I would guess.

> I guess it's time to implement these options in order to try them out
> against real code.  Won't have time to do so before the second half o=
f
> the week, however.

That's OK---we are in no hurry.  Have you heard about pre-release featu=
re
freeze already ;-)?
