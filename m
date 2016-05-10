From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 10:07:08 -0700
Message-ID: <xmqqtwi5rgeb.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
	<B50A244E-05FE-48FF-9C9B-ED7AE35C5C7C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0B7w-0001bB-W3
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbcEJRHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:07:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbcEJRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D261F19A56;
	Tue, 10 May 2016 13:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uno/fwFRuwqwsiHmG4W6to/aehg=; b=JUn4IS
	7sZ35OtchoXT4ba+8jL9azCnVxR/vLLHq5y78b+WjvrYTy3rTIuHRQMaAG0Lin+f
	Xmq6Clf4GECgwitkeGPryjZmompKWRNFhvHmavftE21wfflc2RZc9LIzi3jjAx2r
	gs5fKqYs1z0JZ6XlkQJ28p+MDPfScmp4Cq4zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OCzT7ZbdVpgrQEGhbgTRyJ/+v/9imUrI
	TOe+Ikngsv+0yqN1Uq/34HVQP4k5F8Ar3xUYHaDik0Xxj4J4GS9tgtlfgds4SmUd
	P6fKah93SafjBPCQ+h/kfotrkjTiIprbpT0FE97sLuqeMXVfjGF+P7QmuWb3RCiI
	ev8RtW2j6W4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C71E719A53;
	Tue, 10 May 2016 13:07:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2326319A52;
	Tue, 10 May 2016 13:07:11 -0400 (EDT)
In-Reply-To: <B50A244E-05FE-48FF-9C9B-ED7AE35C5C7C@gmail.com> (Lars
	Schneider's message of "Tue, 10 May 2016 08:27:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A27F8830-16D1-11E6-A187-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294154>

Lars Schneider <larsxschneider@gmail.com> writes:

> A version with at least one section error is here:
> http://article.gmane.org/gmane.comp.version-control.git/293521
> Should I fix and reroll this patch?

I just compared this with jc/linkgit-fix, which was done until the
script introduced by jc/doc-lint gets happy.  293521 covers the same
spots, but misses the incorrect section numbers, so your reroll of it
would end up looking exactly like jc/linkgit-fix, I would think.

> The Travis-CI documentation check build step did not make it in:
> http://article.gmane.org/gmane.comp.version-control.git/293523
> Is there something I can improve?

Let me take another look later.

Thanks for carefully going through the "What's cooking" report.  It
really helps to make sure we move forward topics that need to.
