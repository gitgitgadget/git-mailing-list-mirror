From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] glossary: improve description of SHA-1 related
 topics
Date: Sun, 07 Apr 2013 10:24:52 -0700
Message-ID: <7vhaji45jv.fsf@alter.siamese.dyndns.org>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
 <824604721.1719644.1365347429662.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtKu-00047j-2V
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133Ab3DGRY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:24:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934124Ab3DGRYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:24:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B27613249;
	Sun,  7 Apr 2013 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VTDMHgEbuZS0GpFRjBGgfO1yMzI=; b=Ba0UicIon+5Bp1N1yVCE
	gCjAFrgIWfZh1fDmLIePPMi/yeacOkT6hST/95oJtXlqquCP7rO4XNY6NdYPQVIv
	9z/acGK/J4ZVabocOq0HHlNQubP5uSKk5V3ZZTzt1/937G3wjnwD0HjogKPx3WZr
	t+3gFSjW0ICilxVHeQV3ZJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=c+TIZ4Zi6S9psj2ksUshccvw6+Zuu84SuIOPI/Tg/Z9G8x
	ANKVyojws8JR67DZcB4BAR55vAarHC43Pul75rAq/wUGRGC92tr5/cXJ+3Ng492h
	Os/IXVJsa/DP+e2Ab9HSux7j86GlA1/gonhREyPlu0NnhyBYe3M884VoJYp94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1371813248;
	Sun,  7 Apr 2013 17:24:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FECC13246; Sun,  7 Apr
 2013 17:24:54 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FD34A1A-9FA8-11E2-8FCC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220336>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

The readers of the history may still want to see "improve how"
explained in the log.

	The name of the hash function is "SHA-1", not "SHA1".

	Also to people who look up "object name" in the glossary,
	the details of which hash function is applied on what to
	compute "object name" is not important (the fact that the
	name is meant to be an unique identifier for the contents
	stored in the object is).

or something?

(no review comment below this line; patch kept for others' reference)

>  Documentation/glossary-content.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 5a7a486..4dd0a52 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -153,7 +153,7 @@ to point at the new commit.
>  	created. Configured via the `.git/info/grafts` file.
>  
>  [[def_hash]]hash::
> -	In Git's context, synonym to <<def_object_name,object name>>.
> +	In Git's context, synonym for <<def_object_name,object name>>.
>  
>  [[def_head]]head::
>  	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
> @@ -225,7 +225,7 @@ This commit is referred to as a "merge commit", or sometimes just a
>  
>  [[def_object]]object::
>  	The unit of storage in Git. It is uniquely identified by the
> -	<<def_SHA1,SHA1>> of its contents. Consequently, an
> +	<<def_SHA1,SHA-1>> of its contents. Consequently, an
>  	object can not be changed.
>  
>  [[def_object_database]]object database::
> @@ -237,10 +237,9 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	Synonym for <<def_object_name,object name>>.
>  
>  [[def_object_name]]object name::
> -	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
> -	of the object's contents using the Secure Hash Algorithm
> -	1 and usually represented by the 40 character hexadecimal encoding of
> -	the <<def_hash,hash>> of the object.
> +	The unique identifier of an <<def_object,object>>.  The
> +	object name is usually represented by a 40 character
> +	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>
>  
>  [[def_object_type]]object type::
>  	One of the identifiers "<<def_commit_object,commit>>",
> @@ -376,7 +375,7 @@ should not be combined with other pathspec.
>  	to the result.
>  
>  [[def_ref]]ref::
> -	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
> +	A 40-byte hex representation of a <<def_SHA1,SHA-1>> or a name that
>  	denotes a particular <<def_object,object>>. They may be stored in
>  	a file under `$GIT_DIR/refs/` directory, or
>  	in the `$GIT_DIR/packed-refs` file.
> @@ -432,8 +431,9 @@ should not be combined with other pathspec.
>  [[def_SCM]]SCM::
>  	Source code management (tool).
>  
> -[[def_SHA1]]SHA1::
> -	Synonym for <<def_object_name,object name>>.
> +[[def_SHA1]]SHA-1::
> +	"Secure Hash Algorithm 1"; a cryptographic hash function. 
> +	In the context of Git used as a synonym for <<def_object_name,object name>>.
>  
>  [[def_shallow_repository]]shallow repository::
>  	A shallow <<def_repository,repository>> has an incomplete
> @@ -447,7 +447,7 @@ should not be combined with other pathspec.
>  	its history can be later deepened with linkgit:git-fetch[1].
>  
>  [[def_symref]]symref::
> -	Symbolic reference: instead of containing the <<def_SHA1,SHA1>>
> +	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
>  	id itself, it is of the format 'ref: refs/some/thing' and when
>  	referenced, it recursively dereferences to this reference.
>  	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic
