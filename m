From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Tue, 18 Dec 2012 08:43:38 -0800
Message-ID: <7vvcbzgvk5.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley>
 <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
 <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
 <7vobhsjq6a.fsf@alter.siamese.dyndns.org>
 <7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
 <CAEUsAPa1XMeymEXbLu=iy8VTdLO=iPUeVN3QPH+FbQecL8XnsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl0Gt-0004AS-E6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265Ab2LRQnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 11:43:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab2LRQnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:43:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55B189254;
	Tue, 18 Dec 2012 11:43:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3Fta4+AwyPiAVojBsCJ8G0ooh3g=; b=u6iQyv
	8IHnz2q5lxUM25XY/L/q1CUNmrqTViiPPHunDj9KhySa4OasJu2VNgYSMLjCNVpe
	hpA9zDLMvChvVl1hM6vNvQSU8rjxMjxOIBlgMBsblVNVOWNVrBO2YBWCLXQaaoQr
	awBwjU6AgVFFRIRUqjDt6XxXK2F8l+XqWHR1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Chir7gTkdUTYddlpFVQVAwPgAgcbHm5K
	DvCueJaCQmyjUwzntx0YwHOffB7YN+noISLIH1VyH8v5yynAY8X3HtSMHFBHFrjf
	ZjlWgRwPvF3wEWJWiWG07m6OIpetoFqvuB3B0XWwaJYuG7MbCBKuJMmhU+EjUiUM
	T2/J+tDnm+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E939253;
	Tue, 18 Dec 2012 11:43:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF6699252; Tue, 18 Dec 2012
 11:43:39 -0500 (EST)
In-Reply-To: <CAEUsAPa1XMeymEXbLu=iy8VTdLO=iPUeVN3QPH+FbQecL8XnsA@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 17 Dec 2012 21:33:09 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 136AF0BE-4932-11E2-9B77-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211761>

Chris Rorvick <chris@rorvick.com> writes:

> I like Johannes' suggestion of using "<branch>" in the --detach case
> instead of "<commit>" as I think it makes the reason for the
> separation more obvious at a glance.

Sounds sensible; even though the option does not require its
argument to be a branch name, the user does not have a reason to use
the option if it is not giving a branch name, either, so it all
balances out ;-).

>
> --->8---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index dcf1a32..4fdf41a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -61,8 +61,8 @@ $ git checkout <branch>
>  that is to say, the branch is not reset/created unless "git checkout" is
>  successful.
>
> -'git checkout' --detach [<commit>]::
>  'git checkout' <commit>::
> +'git checkout' --detach [<branch>]::
>
>         Prepare to work on top of <commit>, by detaching HEAD at it
>         (see "DETACHED HEAD" section), and updating the index and the
> @@ -71,7 +71,8 @@ successful.
>         tree will be the state recorded in the commit plus the local
>         modifications.
>  +
> -Passing `--detach` forces this behavior even if <commit> is a branch.
> +Passing `--detach` forces this behavior in the case of a <branch>, or
> +the current branch if one is not specified.
>
>  'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
