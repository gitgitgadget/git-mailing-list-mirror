From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] remote-hg, remote-bzr fixes
Date: Mon, 11 Nov 2013 10:35:19 -0800
Message-ID: <xmqqob5qlrbs.fsf@gitster.dls.corp.google.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwKd-0002WS-2k
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003Ab3KKSfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:35:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab3KKSfV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:35:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50769502E9;
	Mon, 11 Nov 2013 13:35:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTMxJnly9jdjv0k8Wn3Hn8NDj1g=; b=aeEcxZ
	yI/TBEFRmHwle9yxEmVZ56J4DNF0zqTvwIiIu0vR5+/bl4sXJqyGYr9XJCgkMQai
	1QLZ6sEO26Faj9gcwY1STAdu7nHJuus6zkaThTniWegA3j/BJ/O9Wf+1qQ8ozgrh
	QwI45iML9y1i7cMiNFy0iuFMC6Ql1RYwzqZQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aePNbg07a2vVlyLKaPJy4L+VMbfLtelE
	VXoNDhpLjEwXPm5jkeyO5H3TxiCLlQ1YDXenhTtgEyjx6hc/GtaN6v7QKhHhkEE0
	DTtezK02EfsEmFS76Zk70UJ1nBsVpHp2CKIgj532g2rYnqiFS7acA9XBEMWUYmcu
	DPrOYQjHgCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F80D502E8;
	Mon, 11 Nov 2013 13:35:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94D85502E7;
	Mon, 11 Nov 2013 13:35:20 -0500 (EST)
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Sun, 10 Nov 2013 23:05:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04F044FA-4B00-11E3-954F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237629>

Richard Hansen <rhansen@bbn.com> writes:

> A handful of fixes for the git-remote-hg and git-remote-bzr remote
> helpers and their unit tests.
>
> Richard Hansen (7):
>   remote-hg:  don't decode UTF-8 paths into Unicode objects
>   test-bzr.sh, test-hg.sh: allow running from any dir
>   test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
>   test-hg.sh: eliminate 'local' bashism
>   test-hg.sh: avoid obsolete 'test' syntax
>   test-hg.sh: help user correlate verbose output with email test
>   remote-bzr, remote-hg: fix email address regular expression
>
>  contrib/remote-helpers/git-remote-bzr |  7 +++----
>  contrib/remote-helpers/git-remote-hg  |  9 ++++-----
>  contrib/remote-helpers/test-bzr.sh    |  6 +++++-
>  contrib/remote-helpers/test-hg.sh     | 31 ++++++++++++++++++-------------
>  4 files changed, 30 insertions(+), 23 deletions(-)

I'll defer to Felipe for the meat of the logic in these scripts; the
POSIXify part of the fixes look all good to me.

I see there already are review comments, so let me know when the
reviews have settled with a final reroll.

Thanks.
