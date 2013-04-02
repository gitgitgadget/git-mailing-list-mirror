From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Remove outdated/missleading/irrelevant entries from
 glossary-content.txt
Date: Tue, 02 Apr 2013 08:56:51 -0700
Message-ID: <7v7gklgc3g.fsf@alter.siamese.dyndns.org>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <1051288663.727673.1364894817858.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 17:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3aO-0004vi-0a
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab3DBP4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:56:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760123Ab3DBP4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:56:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5E8127D9;
	Tue,  2 Apr 2013 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bPFPiBUjp/haMJEsGtWWx8SFXTg=; b=FxZN2r
	pnWO3loqcLyqwADAimJfYvYtTwfSJMeApyzzRIay+J+VwF15oriHObwhAxH+rEKG
	7dHmjMCz7hTNzfCWzkLSpNwWDGnn0NJA/WlMwo7eHRMImPxyy6JMpxF+jKql3lf1
	YCwx7nrEY26M5tQAD1YqLqmtj5UM81taAeKO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QIdMfu4jEwtzr4m4wZ/PnO0BYec+IEKL
	Ep1L3xc4fInA1huTiBVW+L33myZwIIbxZV0Kja2zec9kV+CgFLWQ8+rLJUk3irlB
	BWbeQttYREEKsXVx6Olk/AGBgBf9F5NWrm2uyJq11HZt3YOLMzCwyVU+uJv6LXng
	3ozOR560j7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C6C127D8;
	Tue,  2 Apr 2013 15:56:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48D0C127D6; Tue,  2 Apr
 2013 15:56:53 +0000 (UTC)
In-Reply-To: <1051288663.727673.1364894817858.JavaMail.ngmail@webmail14.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 11:26:57 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0056450-9BAD-11E2-8B65-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219785>

Thomas Ackermann <th.acker@arcor.de> writes:

> -[[def_directory]]directory::
> -	The list you get with "ls" :-)
> -

The text indeed has a room for improvement, but it probably makes
sense to have an entry for `directory` here, as folks who are used
to say "Folders" may not know what it is.

> -[[def_evil_merge]]evil merge::
> -	An evil merge is a <<def_merge,merge>> that introduces changes that
> -	do not appear in any <<def_parent,parent>>.

Which one of outdated, misleading or irrelevant category does this
fall into?  It certainly is not outdated (diff --cc/-c is often a
way to view evil merges), the text defines what an evil merge is
precisely and I do not think it is misleading.  Is it irrelevant?

> @@ -468,9 +452,7 @@ should not be combined with other pathspec.
>  	object of an arbitrary type (typically a tag points to either a
>  	<<def_tag_object,tag>> or a <<def_commit_object,commit object>>).
>  	In contrast to a <<def_head,head>>, a tag is not updated by
> -	the `commit` command. A Git tag has nothing to do with a Lisp
> -	tag (which would be called an <<def_object_type,object type>>
> -	in Git's context). A tag is most typically used to mark a particular
> +	the `commit` command. A tag is most typically used to mark a particular
>  	point in the commit ancestry <<def_chain,chain>>.

Even though I personally am slightly in favor of removal, I suspect
that is primarily because I already know what Git tag is, and it is
different from the type tag in the Lisp-speak.

It's similar in spirit why I would prefer to keep `directory` to
help people who speak of "Folders".

Other changes in this patch look OK to me.
