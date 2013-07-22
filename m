From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Random typofixes.
Date: Mon, 22 Jul 2013 16:06:02 -0700
Message-ID: <7vfvv69ov9.fsf@alter.siamese.dyndns.org>
References: <20130722210223.GA26492@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Jul 23 01:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1PBF-0006C0-9K
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab3GVXGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 19:06:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab3GVXGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 19:06:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B64128156;
	Mon, 22 Jul 2013 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QczxftB/joI1
	vOUnvJ1juK6cvRo=; b=cpfm5HichsVGPsIobZ3AuriarVwbql07cPJo7NkTdN3J
	uujKqPRYrHklYynW1aDEhlq1YV4BPJdnqiL7SmeDEthOupaRg+HzKRy8D3gXh4ah
	h6z4vU7TzQCshf0NbLQazV+wnUUgFzvL1xqxcl7caDMbZ4071g9eRkdxTj/4emA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kfH7ZX
	BUG00spce5K6cJlRWBZZTEOwhIYWjBiR1NIshpmuF4cJR24FLffwocNrC2AiZ5z3
	xNkkIxQobo1bIaLZ5rb/YVSLcoMvKDrzUeQ8FDaw+oyEpScxVZUdUuXsd7hePyT0
	Qw4IIPs1SCjygejBgWF76rP4DhUUU00blr6Wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A3428153;
	Mon, 22 Jul 2013 23:06:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B34C28151;
	Mon, 22 Jul 2013 23:06:04 +0000 (UTC)
In-Reply-To: <20130722210223.GA26492@domone.kolej.mff.cuni.cz>
 (=?utf-8?Q?=22Ond=C5=99ej=09B=C3=ADlka=22's?= message of "Mon, 22 Jul 2013
 23:02:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48B5CCEE-F323-11E2-84CD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231009>

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:

> Hi, this is refactored version of my previous typofix patch. I avoid
> here controversional fixes.
> I am writing a https://github.com/neleai/stylepp tool to handle
> various style issues.
>
> To simplify review I wrote a utility:
>
> stylepp_strip_diff
>
> That takes a patch file, strips surrounding lines and prints interval=
s
> that were changes.
>
> Its output is below and patch follows:
> ...

Next time please omit all of the above.  We can test-apply and then
run "diff --word-diff" to get a comparison that is much easier to
read.

> diff --git a/Documentation/RelNotes/1.8.2.txt b/Documentation/RelNote=
s/1.8.2.txt
> index fc606ae..5da2a9d 100644
> --- a/Documentation/RelNotes/1.8.2.txt
> +++ b/Documentation/RelNotes/1.8.2.txt
> @@ -67,7 +67,7 @@ UI, Workflows & Features
>   * The completion script (in contrib/completion) used to let the
>     default completer to suggest pathnames, which gave too many
>     irrelevant choices (e.g. "git add" would not want to add an
> -   unmodified path).  It learnt to use a more git-aware logic to
> +   unmodified path).  It learned to use a more git-aware logic to

I'd leave the original as-is (cf. http://bit.ly/1bH8OlT).

> diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documenta=
tion/howto/revert-branch-rebase.txt
> index 84dd839..29a7cfa 100644
> --- a/Documentation/howto/revert-branch-rebase.txt
> +++ b/Documentation/howto/revert-branch-rebase.txt
> @@ -12,7 +12,7 @@ How to revert an existing commit
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  One of the changes I pulled into the 'master' branch turns out to
> -break building Git with GCC 2.95.  While they were well intentioned
> +break building Git with GCC 2.95.  While they were well intended

Likewise (cf. http://bit.ly/12HZx4x), but it needs a hyphen between
these two words, which I'll add before applying the patch.

> diff --git a/Documentation/technical/racy-git.txt b/Documentation/tec=
hnical/racy-git.txt
> index f716d6d..242a044 100644
> --- a/Documentation/technical/racy-git.txt
> +++ b/Documentation/technical/racy-git.txt
> @@ -46,7 +46,7 @@ because in-core timestamps can have finer granulari=
ty than
>  on-disk timestamps, resulting in meaningless changes when an
>  inode is evicted from the inode cache.  See commit 8ce13b0
>  of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> -([PATCH] Sync in core time granuality with filesystems,
> +([PATCH] Sync in core time granularity with filesystems,
>  2005-01-04).

This is dubious, as it is referring to what is already cast in
stone, but I'll apply the update as-is, with the rest of the patch.

Thanks.  It really shows we cannot spell X-<.
