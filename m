From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-patch-id.txt: show that you can pipe in git-log
Date: Wed, 16 Feb 2011 11:35:31 -0800
Message-ID: <7vaahvkc1o.fsf@alter.siamese.dyndns.org>
References: <1297853586-812-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 20:35:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnAC-0004zX-8u
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 20:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab1BPTfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 14:35:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab1BPTfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 14:35:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB4EC35C8;
	Wed, 16 Feb 2011 14:36:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aP0QwDXWgIr0
	V/pZe/hdNZlpuHo=; b=D7V28T+ZtINm5aLduY7fF4DB0EMw/PLDgV0LscY7ClhS
	LgVFblPnn25M4QQX5f1JhteltfJ9/tV8v1UnFleCjwZIZh4zQiVP94IRpkMV96Ck
	LGYViTirrFiZ7IX+jDFcAUPRI8JcdAcVyLX5EGa3d05CDOposcR5x04hvOwhBV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JjR4lO
	uqwz/Xj+F6PmnKCP95b4YBcBV/+yQpzRlsVK0Flvt2WWVu5dtIB3piEr0ouQxf5a
	3SFTXU6P4ZBqAz63+q5MdmiJoob3nSJZ1zkcBJpmctJ0oMJYb0tbE9wg0bQsfU3U
	R2LaklnuPNSBeZg29jCjZhDv5gFI/l9mFfw48=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B406A35C4;
	Wed, 16 Feb 2011 14:36:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E69635C2; Wed, 16 Feb 2011
 14:36:39 -0500 (EST)
In-Reply-To: <1297853586-812-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed\, 16 Feb
 2011 10\:53\:06 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14F2D88C-3A04-11E0-8BA1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166991>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the manual page for git-patch-id(1) to mention in the SYNOPSIS
> that you can pipe in the git-log(1) output.
>
> The manual page only mentioned that you could pipe in `< patch`, I ha=
d
> to grep the test suite to find that you could do things like `git log
> -p -1 | git patch-id`.

I tend to try to keep a command line example in the commit message from
getting split by rewording.

    The manual page only mentioned that you can redirect from a file
    with `<patch`; I found by grepping the test suite that you can
    feed the command from a pipe, e.g. `git log -p -1 | git patch-id`.

It sounds silly to say "pipe in" and "<" in the same sentence, so I'd f=
ix
that while I am at it.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/git-patch-id.txt |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch=
-id.txt
> index 4dae139..fec2cf3 100644
> --- a/Documentation/git-patch-id.txt
> +++ b/Documentation/git-patch-id.txt
> @@ -9,6 +9,8 @@ SYNOPSIS
>  --------
>  'git patch-id' < <patch>
> =20
> +'git log --pretty=3Dformat:%H -p | git patch-id'
> +

The notation "< <patch>" is used as a way to say "this command reads fr=
om
its standard input and acts on it".  Anybody who understands what the
redirection is knows that a normal command would not mind getting fed f=
rom
a pipe instead of a regular file (they _could_ tell the kind of file
descriptors, and there indeed are commands that change their behaviour
depending on the kind of file descriptor they are being fed from, but t=
hey
are exceptions).  So I don't think the new information should live here=
=2E

In a sense, I do not think the original is a material for SYNOPSIS
section, either.  The first paragraph of DESCRIPTION section is also ba=
d
as a manual page; it doesn't say _what the command does_.

>  DESCRIPTION
>  -----------
>  A "patch ID" is nothing but a SHA1 of the diff associated with a pat=
ch, with

How about rewriting the whole thing, along these lines...

	SYNOPSIS
	--------
        'git patch-id'

        DESCRIPTION
        -----------
	Reads a patch from the standard input, and outputs the unique ID
        for it.  When fed a series of patches that records which commit
        they come from (e.g. output from 'git format-patch --stdout' or
        'git log -p'), reads them and outputs the unique IDs for them, =
one
        per line.

	A line in its output consists of two 40-byte hexadecimal values;

            1. the unique ID for the change;
            2. a SP; and
            3. the commit object name for the change if known, or
               40 "0" letters.

	A "patch ID" is nothing but a SHA-1 of ... (original text, but
	needs to rewrite "When dealing with..." paragraph not to mention
	diff-tree because that is not a user-facing command anymore).

        EXAMPLES
        --------

	git patch-id <patch.txt::

            ... (describe what this does) ...

	git log -3 -p | git patch-id::

            ... (describe what this does) ...
