From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Improve description of SHA1 related topics in
 glossary-content.txt
Date: Tue, 02 Apr 2013 09:05:07 -0700
Message-ID: <7v38v8hqa4.fsf@alter.siamese.dyndns.org>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <638015718.727691.1364894866964.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3iQ-000234-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab3DBQFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:05:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760850Ab3DBQFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:05:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C64B12B31;
	Tue,  2 Apr 2013 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lu1Tt/GFpPj+t/Xt2Kxt+nM4uMM=; b=R7CxO9
	LQJj/5QKK70IgDxne9z0vXHqv+Wkecuhyzl5fuWFIg1l3eF06CKCpoXKgxVul2p3
	fk13gnK3xKzGHtrNCtLYmECw5y9Hye+tW91ilsItxP/6hA9a0rqjIgjiyLnnty+q
	uydOcCrQY+FxltYj9s5X4LmG1w/0lSXw+BODY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hKC6XegB50pfJSYIK4VSv8CpkhzP8fcT
	4lhhSGXq2LnrIlWNQ3Z6ulVKWAozD907d3e4w+0HwDUaDJGzBy0GCwv7Ugtl5ZeI
	0owPqekRZMD9+qs2uYfsZnfu+tnvp339xBd3y0c9YzNhQW8EfGkO3hwK8IKAn2gJ
	ftHKZtLIihc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8482C12B30;
	Tue,  2 Apr 2013 16:05:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E376212B2F; Tue,  2 Apr
 2013 16:05:08 +0000 (UTC)
In-Reply-To: <638015718.727691.1364894866964.JavaMail.ngmail@webmail14.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 11:27:46 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 177121CC-9BAF-11E2-997B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219786>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/glossary-content.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index ab02238..05bfebc 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -146,7 +146,7 @@ to point at the new commit.
>  	created. Configured via the `.git/info/grafts` file.
>  
>  [[def_hash]]hash::
> -	In Git's context, synonym to <<def_object_name,object name>>.
> +	In Git's context, synonym for <<def_object_name,object name>>.

OK.

>  [[def_object_name]]object name::
> -	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
> -	of the object's contents using the Secure Hash Algorithm
> -	1 and usually represented by the 40 character hexadecimal encoding of
> -	the <<def_hash,hash>> of the object.
> +	The unique identifier of an <<def_object,object>>: The <<def_SHA1,SHA1>> hash
> +	of the object's contents. The object name is usually represented by the 
> +	40 character hexadecimal encoding of the hash value.

I am torn on this one.  When you have a file A on the filesystem,
the object name of the blob that records the contents of that file
is *not* the same as output from "sha1sum A".

I doubt we should spell out _how_ it is computed.  In the glossary,
it is better to say what it is and what it is used for; the tutorial
and Documentation/technical/ give better details that the readers
who refer to the glossary do not need.

	The unique identifier of an <<def_object,object>>.  The
	object name is usually represented by a 40 character
	hexadecimal string.  Also colloquially called
	<<def_SHA1,SHA-1>>.

might be sufficient.

> @@ -426,7 +425,8 @@ should not be combined with other pathspec.
>  	Source code management (tool).
>  
>  [[def_SHA1]]SHA1::
> -	Synonym for <<def_object_name,object name>>.
> +	"Secure Hash Algorithm 1"; a cryptographic hash function. 
> +	In the context of Git used as a synonym for <<def_object_name,object name>>.

We should spell it as "SHA-1" with a dash.
