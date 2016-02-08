From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/20] refs backend
Date: Mon, 08 Feb 2016 15:37:45 -0800
Message-ID: <xmqq8u2u6aeu.fsf@gitster.mtv.corp.google.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSvNQ-0006Vu-9O
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbcBHXhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 18:37:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752912AbcBHXhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 18:37:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 212E243149;
	Mon,  8 Feb 2016 18:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G2HtJg1PFOr0
	xWD0zd2bDt9ufMY=; b=uMxG4rGtFIbOe46ezMrkWi8QJTK0HBDTUVce82Q/ZTNQ
	X7smlf2F+nBJdMksf0Vz/Wxk9gv2J78g/wSldzH4DoKoxTZF4zsDSOVCLvGyUZd5
	BmcQJZtiXEzXfiUHKaplV2k1gL4RW9c9ibm/27ite5DJ6TwmVtnjfsbo/D9ntT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zhkree
	NBpTXQh0s/iKHPZmdFvQ/4VVrGDZIbz1zNrfFbE14vvYaCHlyoZRuZNUxyRzd8/V
	PVYHtgwfZWzFrtzlZ3hwuLqb7YtgAogTZYeDsLIM2AybxrQf+U+7+b+J0qFbMSj3
	jRPezAyQ0OQfq1ONeKlzOcGmTYKj5sKT09k9w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1891243148;
	Mon,  8 Feb 2016 18:37:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8903F43147;
	Mon,  8 Feb 2016 18:37:46 -0500 (EST)
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 5 Feb 2016 14:44:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F5169F46-CEBC-11E5-A593-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285826>

David Turner <dturner@twopensource.com> writes:

> Changes to this version:
> re-rolled on top of pu as-of 9db66d9f1aa.
>
> Bug fixes include:
> For submodules: memory leaks; segfault on bad config. (thanks to Peff=
)
> In symref splitting: check that would always succeed (thanks to Peff)
> A bogus double-declaration of a var (thanks to Ramsay Jones)
> Two memory leaks (thanks to Thomas Gummerer)
> An unused var (thanks to Duy Nguyen)
>
> Other improvements are:
> Strings prepped for 18n (thanks to Duy Nguyen)
> Cleaner submodule handling (thanks to Peff)
> Whitelisting instead of blacklisting in git-new-workdir (thanks to
>   Thomas Gummerer)
> Allow older gits to recognize lmdb-backend git repos (thanks to Duy N=
guyen)
> Tab completion and cleaner commit messages (thanks SZEDER G=C3=A1bor)
> Removed some #ifdefs, moving all backend setup to one place (thanks t=
o Duy
> Nguyen)
>
> Thanks to all for reviews.

Thanks for a reroll.

Applied this on top of a merge between the current 'master' and
'sb/submodule-parallel-update' topic to untangle the dependency;
otherwise there is no way for this topic to make progress X-<.

Let's see how well this round goes.
