From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remotes
Date: Tue, 03 May 2016 13:38:22 -0700
Message-ID: <xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
References: <20160503181624.1504eb0a@laborpc>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Lev <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:38:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axh5S-0005Ao-16
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbcECUi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 16:38:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756337AbcECUiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 16:38:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4804418E2D;
	Tue,  3 May 2016 16:38:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8/58bc0bSyeJqj+KoIVH6Uk0NM=; b=ZvZ3WM
	dGqbFEbDiOpWaz/bzbGdO0Extv1iIgk8RRJoJuGIavwhHh3bus3CJMqXSfi3SCZA
	Vi782hQtXnX0LSLAocnvYepNVReVmzm4hT7xsswdsov4UxH4zew+pjvOb5C8HNfW
	SMqyuNOhb/3OiYhpjINyQ1EDxOfpu1jFjTChk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZwPnAYdAMkgJENEH4gQag/zmyEZoRUoX
	Ga3R0hFZCpEbfNiSaR8QlKJ06pQNN5xcYvFxLEB8par8wuriV+65lLn3RcjZVBr/
	ZnyVyBEQFc4Tgdp5LLFFlENLghS8qCB1mL2d/6mtG+s5IKibkTq9aIyIITxko5di
	/3mlUjaPEEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FAAD18E2C;
	Tue,  3 May 2016 16:38:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A059C18E29;
	Tue,  3 May 2016 16:38:23 -0400 (EDT)
In-Reply-To: <20160503181624.1504eb0a@laborpc> (Lev's message of "Tue, 3 May
	2016 18:16:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB02B0C6-116E-11E6-898F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293452>

Lev <leventelist@gmail.com> writes:

> I accidentally added a remote of another repository to my config file. And so I
> merged two different repositories together. Is there any real user case for
> this?

Using multiple remotes is a perfectly normal way in which you are
expected to interact with a single project with other participants.
Perhaps there is one single authoritative and canonical repository
where everybody initially clones from, and it is likely that that
repository is your "origin".  Often there are cases where another
participant has a topic that is not yet ready for the mainline but
is worth considering for early adopters and/or is solid enough for
other project participants to build their work on.  In such cases,
you can add the repository of that other participant as the second
remote and fetch from her.

It makes no sense if the two repositories hold histories of totally
unrelated projects, of course.
