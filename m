From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow "-" as a short-hand for "@{-1}" for branch deletion
Date: Sat, 05 Mar 2016 00:06:52 -0800
Message-ID: <xmqqpov9wdpf.fsf@gitster.mtv.corp.google.com>
References: <1457163546-11970-1-git-send-email-dpdineshp2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dinesh Polathula <dpdineshp2@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 09:07:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac7Ep-0001Bs-Dd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 09:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbcCEIG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 03:06:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491AbcCEIGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 03:06:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A84C3F525;
	Sat,  5 Mar 2016 03:06:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KnJ3uiGHt1Zo8o2GfyjXWU9Ytas=; b=NhvIlF
	WfhE66NXY73XksnYlnmdj2zQZrg2sdzXZ8UF01P5FAG1evfRWFyLP7ZTkofhFtPf
	XGaYTHGKihpxComQia+U1iMoqyyjyT3zUTtBqfsEdzbE5ZDQsGkAhLXqgZEOyNN+
	xQ9q5jfVPI+gBUcSUEXT6GnqLjdDbVYYqoNCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CaDG1hBK2m1EhxZImF1Jh7CAlvrrGLpx
	OeZ9fqPsHAXMbPQfk+AnsXVQx81JejaVa2bsrbDlcVyZqp5VEsCmLZA9DTmt52j9
	ga7yGjvVlIQcU3LdXgMInc6RuceM6aBwAXqUiPkO35WkQDBcHx7NoBKw+kcwSwc/
	+MVtFHY9Bzo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91D4C3F523;
	Sat,  5 Mar 2016 03:06:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17AA23F522;
	Sat,  5 Mar 2016 03:06:53 -0500 (EST)
In-Reply-To: <1457163546-11970-1-git-send-email-dpdineshp2@gmail.com> (Dinesh
	Polathula's message of "Sat, 5 Mar 2016 13:09:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38922574-E2A9-11E5-BD63-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288303>

Dinesh Polathula <dpdineshp2@gmail.com> writes:

> From: Dinesh <dpdineshp2@gmail.com>
>
> ***
> This patch allows the usage of "-" as a short-hand for "@{-1}" in "git branch -d @{-1}".
>
> Note : This is a microproject that is part of the Google Summer of Code application process.
> I am interested in working on the git Beginner mode implementation as part of Google Summer of Code. The mentor details for this particular project are not available on the Ideas page. The mentors are likely on this mailing list, so I request the mentors to drop me a mail so I can get in contact with you to further discuss the git Beginner mode project.

Please fill your lines to reasonable length like 70 columns or so,
in your code, in your proposed log messages, and in your e-mail.

> ***
>
> Dinesh (1):
>   branch.c: Allow "-" as a short-hand for "@{-1}" in "git branch -d
>     @{-1}"
>
>  builtin/branch.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
