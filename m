From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 13:59:25 -0800
Message-ID: <7vobhsjq6a.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley>
 <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
 <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkiix-0004ac-DU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2LQV73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:59:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab2LQV72 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:59:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B82DA676;
	Mon, 17 Dec 2012 16:59:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kyMSJxVHWxCcoAFojP25B2k8IuQ=; b=qVWuEY
	1BgJtyCCInWEUvIzg7QjhWxu+Dv/AnWXN8ZGFg2FUFMwdcyUhXkh1uNeEVX6QEkT
	Q3hxEsuMWq5h20LGAzF46jRxk+49+a4j7FQBiG4oG/pXVSvgVPGSjqwGRqibHew1
	BflUnngStSafCHCpA0ZtGEDzSerB+I8x4LVdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BbHYd1/yFHtYzVxj1P6R+X+Ve8fiKi6x
	LCEeoW8E+sh57Gz6pFrJkZuaiX3+kz0Ao+LjLkACuJyGSYFkPc6ml+qzqqIPHj3t
	qaZvipWzSSxSreYlJCnN/zu8qLQ/pU228zTvbmumLsKov4LlyU0FnsnewLkPqpqj
	VE2YaJlm2Uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4859CA675;
	Mon, 17 Dec 2012 16:59:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3F6AA674; Mon, 17 Dec 2012
 16:59:26 -0500 (EST)
In-Reply-To: <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com> (Andrew
 Ardill's message of "Tue, 18 Dec 2012 08:50:15 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06415236-4895-11E2-8120-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211708>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Even if the primary purpose of "git checkout <branch>" is to "check
> out the branch so that further work is done on that branch", I don't
> believe that means it has to be stated first. In fact, I would say
> that there are enough other use cases that the language should be
> slightly more use-case agnostic in the first situation. For example,
> someone might switch to another branch or commit simply to see what
> state the tree was in at that point.

I've been deliberately avoiding the term "switch", actually.  I
agree that it may be familiar to people with prior exposure to
subversion, but that is not the primary audience of the manual.

> Some people use checkout to
> deploy a tag of the working tree onto a production server. The first
> example in particular is, I think, a common enough operation that
> restricting the opening lines of documentation to talking about
> building further work is misleading.

I agree with you that sightseeing use case where you do not intend
to make any commit is also important.  That is exactly why I said
"further work is done on that branch" not "to that branch" in the
message you are responding to.
