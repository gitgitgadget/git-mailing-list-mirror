From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-filter-branch.txt: clarify ident variables usage
Date: Thu, 21 Feb 2013 12:46:34 -0800
Message-ID: <7vwqu1tmxh.fsf@alter.siamese.dyndns.org>
References: <5126821A.9020800@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8d2m-0000Mq-7T
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3BUUqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 15:46:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab3BUUqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 15:46:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F4D6B9F7;
	Thu, 21 Feb 2013 15:46:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6PVgAOdgJFDX
	lpmTy1A0cW7W0dU=; b=fBRRFXDaxRvTYfxfOqs3/s72xzKiVxmK8tU5W85l3XT8
	ve1e3tweG4/I4sSWcs3roq7TjCnWRpwg++7fy105v+vdb8G/ACT2Igh+SXK8hUmI
	ODwey/aq5u4Bn90T4uFbmTAbdGmmyXy7WgVfqiFEDYrRULtKb12icTnxDcaXsEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G2wNcM
	waULb3s0g3/Hhgw7naEHv0SuE7NS6a1Y0M8mupk1HxSDjzKMX/z/KmGRAcf/Fnxl
	B6bmbkaZbbxT+hphhnJaumQW9KBZBSR0/9jjqDBbxSz6aMGIBchhgNUIfDh0U3Ep
	dK4BZWbuEir+kT6YSCj8y0odPGkaAjHZDFc8k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851A1B9F6;
	Thu, 21 Feb 2013 15:46:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 917BCB9ED; Thu, 21 Feb 2013
 15:46:36 -0500 (EST)
In-Reply-To: <5126821A.9020800@hell.org.pl> ("Tadeusz Andrzej =?utf-8?Q?Ka?=
 =?utf-8?Q?d=C5=82ubowski=22's?= message of "Thu, 21 Feb 2013 21:22:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8E2989E-7C67-11E2-80CC-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216797>

Tadeusz Andrzej Kad=C5=82ubowski  <yess@hell.org.pl> writes:

> There is a rare edge case of git-filter-branch: a filter that unsets
> identity variables from the environment. Link to git-commit-tree
> clarifies how Git would fall back in this situation.

I find it unclear in the updated text _why_ the reader may want to
refer to that other documentation.

> Signed-off-by: Tadeusz Andrzej Kad=C5=82ubowski <yess@hell.org.pl>
> ---
>  Documentation/git-filter-branch.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-=
filter-branch.txt
> index dfd12c9..e50ee2f 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -65,9 +65,9 @@ Prior to that, the $GIT_COMMIT environment variable=
 will be set to contain
>  the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
>  GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER=
_EMAIL,
>  and GIT_COMMITTER_DATE are set according to the current commit.  The=
 values
> -of these variables after the filters have run, are used for the new =
commit.
> -If any evaluation of <command> returns a non-zero exit status, the w=
hole
> -operation will be aborted.
> +of these variables after the filters have run, are used for the new =
commit
> +(see linkgit:git-commit-tree[1] for details).  If any evaluation of =
<command>
> +returns a non-zero exit status, the whole operation will be aborted.

Here is my attempt to clarify it a bit.

	Also, ...<variables>... are taken from the current commit
	and exported to the environment, in order to affect the
	author and committer identities of the replacement commit
	created by linkgit:git-commit-tree[1] after the filters have
	run.

A user who contemplates to unset them should be able to guess the
consequences, even though the above text does not single out such an
insane misuse to put an undue stress on it.

>   A 'map' function is available that takes an "original sha1 id" argu=
ment
>  and outputs a "rewritten sha1 id" if the commit has been already
