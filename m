From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Sun, 28 Feb 2016 10:28:55 -0800
Message-ID: <xmqqbn70g048.fsf@gitster.mtv.corp.google.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-2-git-send-email-s-beyer@gmx.net>
	<xmqqoab3jokp.fsf@gitster.mtv.corp.google.com>
	<56D1A873.1090709@gmx.net>
	<xmqqk2lqghdw.fsf@gitster.mtv.corp.google.com>
	<56D1FB53.2020404@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:29:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa65a-0003LI-Hu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 19:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbcB1S27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 13:28:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbcB1S26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 13:28:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 876B244D21;
	Sun, 28 Feb 2016 13:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uogHhgUy2mi4zzlxXfVqcT/t+X8=; b=IM3g7G
	ay6Sr1P8mXr0BQ+k/uuL1/8/gyVcV264yeKOlM7+MrB9oMY+R5KKKUDkl3e2hLIK
	7U6aQQG7KcnXe9c0l/5E/F9TVYj3xG9/mJgFgu8TZ8C0tPZoGjtEVKhiChrj+qiu
	phQFWizkkHThZDunjAXi0UK0av4c3zLaWvn4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X8VYAqAiWgUL0dVKI0vqzSuSHpN3Qm2B
	yuGlijjkWfSJL7bJIPt9J20nG6uDtgzFfmUgpUu74zKcC/vMYcropBsvL8i4Bu64
	vpOHX2Hok64+DBz3d6a4C3dhPZCueZj4IT3avDTCzaGSnX1Vf/HTk6b6ibL5ogdY
	HmXbWldB/50=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F67144D20;
	Sun, 28 Feb 2016 13:28:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0272C44D1D;
	Sun, 28 Feb 2016 13:28:56 -0500 (EST)
In-Reply-To: <56D1FB53.2020404@gmx.net> (Stephan Beyer's message of "Sat, 27
	Feb 2016 20:38:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20E0E528-DE49-11E5-9CFD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287781>

Stephan Beyer <s-beyer@gmx.net> writes:

> However, it probably should be documented what "git bisect next" does
> after you've specified bad and good commits.
>
> For that, I'd like to have an extra informational paragraph.
> What about: "In general, the command computes the next commit for the
> bisection and checks it out."
> This would be neutral, in the meaning that no use case is involved.

Good thinking.  Thanks for being careful; I often pretend to take an
extreme position to invite a well-thought-out rebuttal, and I really
like it when people respond with a good counter-proposal.
