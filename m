From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 12:24:32 -0700
Message-ID: <7vtxmvbukv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5J1-0001Le-DF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab3DXTYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:24:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797Ab3DXTYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:24:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D46199E0;
	Wed, 24 Apr 2013 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x74v5RkmoqdM2XbIwnjN0tfi1pI=; b=h/a9A8
	NJJfAEjehBxy9HPDNmB6SsrUjMgb3mfPL5dEExBrSYcA/qIHbNuEO5EqI0UOXSqQ
	aG66ST/OlB9eSfbrF82SWqHEBI9chPUa5aVmEdgiA6D4IouYDxbpEfNbFB08hAdm
	yuAg9ozE04vS4dJoDMtxqLHJiTUH+DJ3pWm2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Il/mpaQGfNHovFJObUwl4fO9NbiJ1T35
	jOvO5p/NZ47qt5Dq77SINVQpxIHcgKoqSBAOjYOa525YmYWcxr8TxPHZY6HZUBzk
	4mJXk1DOv2KJk2MEadOrXgVYK7mqwZj5WAmYlmFtuvHvLW+7QUk3C5EN6Gio5Qoz
	NDA7hLb+8oQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2729A199DF;
	Wed, 24 Apr 2013 19:24:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D90A199DE;
	Wed, 24 Apr 2013 19:24:33 +0000 (UTC)
In-Reply-To: <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 00:30:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 980DAD34-AD14-11E2-A197-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222305>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> I'm also considering making the first
>> argument optional (just git log ~rebase.autostash), and defaulting to
>> mean [nearest fork point].
>
> Actually both can be optional.  In A~B, A defaults to [nearest fork
> point] and B defaults to HEAD.
>
>     git log ~
>
> Isn't it beautiful?

I now have to go and wash my eyes.

You will stay in my killlist for the coming few days ;-).
