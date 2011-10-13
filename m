From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] refs: rename some parameters result -> sha1
Date: Thu, 13 Oct 2011 11:42:06 -0700
Message-ID: <7vmxd44ttt.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 20:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQES-0001BL-8n
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1JMSmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:42:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab1JMSmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:42:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28C73373;
	Thu, 13 Oct 2011 14:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UZb82BkJowdIK6gwwOIAb/iVjdM=; b=Jx1hdb
	IbZ+rm6AYgnMh8JTq7CReS2Cc9L6X9E6M3yR4JlS/hf8Cl5SnflFv+h9h68xQDHn
	F6zww0DOvMy80BktJbeI4UuKYyfT8wuxd/TiBuNEFdvgG2m+UBGYXuagYxP240ux
	aLC1ffbTjFFrVyBntUDjfbXVD+KQbviFbi2aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j7eqkvxXTNxyPYvlXyJjFtt2wLF/Ch6k
	JZ95gWZyrft1ILRs6I3cBCzifVz4gHiN2dpjARB0uBsD9KCLApxUDTs04+wuOS8r
	KYHXVf2GBRbpsflKRuN4IJfgj+SC7W6s2JjnLpujk+awbEH+dWfuoYa8heqQnM3V
	oT5rHKIWBwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D94703372;
	Thu, 13 Oct 2011 14:42:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39E833371; Thu, 13 Oct 2011
 14:42:08 -0400 (EDT)
In-Reply-To: <1318492715-5931-5-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DFA0D9C-F5CB-11E0-BE0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183510>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

[PATCH 03/14] was about a similar topic and explained itself a lot
better.

Even though it hinted as if it may be incomplete by saying "some" in the
subject, it was clear from the description that it consistently renamed
all the "name"s that are about references, not just "some" randomly chosen
ones. It would have been better if the subject did not say "some" to avoid
such implications.

Please give similar love to these sha1[] object names in this patch.

> ---
>  refs.c |   16 ++++++++--------
>  refs.h |    2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 2ae5d0d..c466fcd 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -398,7 +398,7 @@ static struct ref_array *get_loose_refs(const char *submodule)
>  #define MAXREFLEN (1024)
>  
>  static int resolve_gitlink_packed_ref(char *name, int pathlen,
> -				      const char *refname, unsigned char *result)
> +				      const char *refname, unsigned char *sha1)
>  {
>  	int retval = -1;
>  	struct ref_entry *ref;
> @@ -406,14 +406,14 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen,
>  
>  	ref = search_ref_array(array, refname);
>  	if (ref != NULL) {
> -		memcpy(result, ref->sha1, 20);
> +		memcpy(sha1, ref->sha1, 20);
>  		retval = 0;
>  	}
>  	return retval;
>  }
>  
>  static int resolve_gitlink_ref_recursive(char *name, int pathlen,
> -					 const char *refname, unsigned char *result,
> +					 const char *refname, unsigned char *sha1,
>  					 int recursion)
>  {
>  	int fd, len = strlen(refname);
> @@ -424,7 +424,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
>  	memcpy(name + pathlen, refname, len+1);
>  	fd = open(name, O_RDONLY);
>  	if (fd < 0)
> -		return resolve_gitlink_packed_ref(name, pathlen, refname, result);
> +		return resolve_gitlink_packed_ref(name, pathlen, refname, sha1);
>  
>  	len = read(fd, buffer, sizeof(buffer)-1);
>  	close(fd);
> @@ -435,7 +435,7 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
>  	buffer[len] = 0;
>  
>  	/* Was it a detached head or an old-fashioned symlink? */
> -	if (!get_sha1_hex(buffer, result))
> +	if (!get_sha1_hex(buffer, sha1))
>  		return 0;
>  
>  	/* Symref? */
> @@ -445,10 +445,10 @@ static int resolve_gitlink_ref_recursive(char *name, int pathlen,
>  	while (isspace(*p))
>  		p++;
>  
> -	return resolve_gitlink_ref_recursive(name, pathlen, p, result, recursion+1);
> +	return resolve_gitlink_ref_recursive(name, pathlen, p, sha1, recursion+1);
>  }
>  
> -int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *result)
> +int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
>  {
>  	int len = strlen(path), retval;
>  	char *gitdir;
> @@ -472,7 +472,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
>  	}
>  	gitdir[len] = '/';
>  	gitdir[++len] = '\0';
> -	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, result, 0);
> +	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, sha1, 0);
>  	free(gitdir);
>  	return retval;
>  }
> diff --git a/refs.h b/refs.h
> index 13e2aa3..c6b8749 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -133,7 +133,7 @@ extern char *shorten_unambiguous_ref(const char *refname, int strict);
>  extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
>  
>  /** resolve ref in nested "gitlink" repository */
> -extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *result);
> +extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
>  
>  /** lock a ref and then write its file */
>  enum action_on_err { MSG_ON_ERR, DIE_ON_ERR, QUIET_ON_ERR };
