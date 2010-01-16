From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update documentation: git-commit is not a shell command
Date: Sat, 16 Jan 2010 09:31:08 -0800
Message-ID: <7v8wbyc5yb.fsf@alter.siamese.dyndns.org>
References: <f3271551001160135k569e2692i5e2ab893701e1738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 18:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWCUs-0000VE-GP
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 18:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab0APRbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 12:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824Ab0APRbS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 12:31:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0APRbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 12:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 899BC9174E;
	Sat, 16 Jan 2010 12:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZpeYJwmC43U0F7SSwEMf9Upx/U=; b=CJqxhk
	uMJiUVoc2wJ4JXfQ9QziB1MCIlqBIgX/cg+pb6gf2+I4ohsxhrV3d+V6y6WTRo7G
	ksEIzdOy3cblbet7EHrvd/fxw580t4RduBruQHG+P491rXySJv3Ovq0RdjbhRRyE
	aUzNKv/ckHqf5+kM8EbNeUpTJVm8tU8Wp+/p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VtOjO2oxKBiSJI08K7C13AgtLhMkZyxz
	z+lVJRhVCMBPOtgQ4uEFHlewBx+AnHW6SdbUzbAQ1XYhwshrhWV2hawPAkpG0RtX
	zW4QHyOfGUX2bKYKo0FBGrY822RH0yLf66vEVFrW2eS03sez25zfPiEhcmENLGIw
	3Lhz7CNqk7k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6675F9174C;
	Sat, 16 Jan 2010 12:31:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5AAB9174B; Sat, 16 Jan
 2010 12:31:09 -0500 (EST)
In-Reply-To: <f3271551001160135k569e2692i5e2ab893701e1738@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat\, 16 Jan 2010 15\:05\:40 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F0F61768-02C4-11DF-B15B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137236>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/gitcore-tutorial.txt
> b/Documentation/gitcore-tutorial.txt
> index f762dca..ebc5d0b 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -454,14 +454,7 @@ will be pruned out, and the rest will be used as
> the commit message for
>  the change. If you decide you don't want to commit anything after all at
>  this point (you can continue to edit things and update the index), you
>  can just leave an empty message. Otherwise `git commit` will commit
> -the change for you.
> -
> -You've now made your first real git commit. And if you're interested in
> -looking at what `git commit` really does, feel free to investigate:
> -it's a few very simple shell scripts to generate the helpful (?) commit
> -message headers, and a few one-liners that actually do the
> -commit itself ('git-commit').
> -
> +the change for you. You've now made your first real git commit.

While the issue you are addressing may be a valid one, removing the whole
paragraph and not doing anything else is not an improvement.  Read the
changed text in a larger context and you will notice that the tutorial
sequence around there does not make much sense anymore.

The point of the core tutorial is to introduce the reader to the low level
structure and plumbing, and a major reason for running "git commit" at
that point in the tutorial is to mention that what even a relatively high
level command "git commit" does can be scripted.  Up to that point, the
tutorial showed a much lower level tools to create a commit, and said
"... but you've done that once already, so let's just use the helpful
script this time:" (by the way, you forgot to change this "script").

So after "You've now made your first real git commit" (which is not true,
by the way---the reader has already done so with commit-tree), you would
need to mention that what git-commit does can be scripted, that it indeed
was a script before Git v1.5.4, that if you want to write a command that
makes a commit but in a different way then you can script it using the
same ingredients the scripted "git commit" used to use, and perhaps that
the scripted version is available as a reference in the git source tree in
contrib/examples.

Actually, I changed my mind.  There are many other Porcelain commands in
the core tutorial that are no longer scripted.  It is better to leave the
main text of the tutorial as-is.  In the initial part of the document,
mention that many Porcelain commands were scripts back when the document
was written, that the document uses them as examples of how plumbing are
fit together to form them, that some scripted Porcelain implementations
are found in contrib/examples/ directory of the source tree for reference
purposes, and that the description of what the plumbing layer commands do
in the document is still valid even though the Porcelain commands mentined
in the document are not implemented in terms of the plumbing commands in
shell scripts anymore.
