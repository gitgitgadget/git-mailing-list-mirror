From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] support completion for git status
Date: Mon, 06 Jun 2016 11:03:29 -0700
Message-ID: <xmqqh9d6xki6.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
	<20160603183426.13140-1-thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ysD-0000la-QP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbcFFSDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:03:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcFFSDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:03:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F47D2230A;
	Mon,  6 Jun 2016 14:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IoxMZWy8cEH/g28nKSgMCuwiCq8=; b=lyheTq
	c5G78q1k4xCrjNsUac2jpXmMexvMb8CH7unFuNekBLUqPH33wJa1qo3vwuOgpfZX
	ngy/AdKEXBY7ra4VlhMjykvQBsgS+cNmYeC7jJTq6cCDKxJimoSWRx/rKwi7kpG9
	z11wWaGXvFESzZA3EqSOvoXT85TtqxgMRYE80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwOK3wRa/BGxVeuIXq25c7gdKQy2k3Vg
	+eGwwa5Oa7aGYZwlwUxJcQEKNrxVw2ho5nvaMhoVL81N67FkVMvXkPrzoWJhwbkc
	vfDAvd0zicNJj+4g99BgcVZUlkhkYkEoH7VJyTw6VPfIXjfhgqEbUQtXJExqo79t
	PCIusE4eow8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BBCC22309;
	Mon,  6 Jun 2016 14:03:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D97F422308;
	Mon,  6 Jun 2016 14:03:30 -0400 (EDT)
In-Reply-To: <20160603183426.13140-1-thomas.braun@virtuell-zuhause.de> (Thomas
	Braun's message of "Fri, 3 Jun 2016 20:34:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA2BFC86-2C10-11E6-BCB3-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296545>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> changes since v3:
> * support short version -u of --untracked-files option
> * introduce __git_get_option_value for general usage
> * fix style issues
> * support order dependent statements like
>   git status -uno --untracked-files=all
>   properly
>
> Thomas Braun (3):
>   completion: factor out untracked file modes into a variable
>   completion: add __git_get_option_value helper
>   completion: add git status
>
>  contrib/completion/git-completion.bash | 98 +++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)

Thanks.

An ack, suggestions to update, or a veto from SZEDER would carry
more weight than what I'd say here, but the three patches looked
alright.
