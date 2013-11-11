From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Emphasize options and force ASCIIDOC escaping of "--"
Date: Mon, 11 Nov 2013 10:06:23 -0800
Message-ID: <xmqq8uwun78g.fsf@gitster.dls.corp.google.com>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfvse-0003ox-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464Ab3KKSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:06:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab3KKSG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:06:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7697B4FB0D;
	Mon, 11 Nov 2013 13:06:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nXZkYFLILbE0NgtS6rM2dz1+DXM=; b=p99mQ7
	E1HWLR2TlMx9TfX3BfuptlO9KNU1N54YfF2Wu3wYCIgrZpJFAYWA5F1tMTIxUz0L
	XISI6TU1OUYIMJTeYBNTF8yLc2lL5usLDToLR2aWhp59LfeQ14rofnqT08sk6H9E
	vl/6IoVvvmch63rAQ/z8yXIclcBe0v1yN5PUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hX1RbTC/ZeDI0Jnx5dE0BHA+pZIG6pLI
	oUzfNkpoT3MYGwvc7wH+k0/3S71fv5V45JAil10Gtf1wov82vQdAoxCJUDs05JeX
	CVawiDCRkXNMO/y20ZTVd1bt0NJE47xkMpuVCvjo+gcHMhTbLxSGVs05ELg5+kmU
	ePaUOM+huz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC7E4FB0C;
	Mon, 11 Nov 2013 13:06:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C51AA4FB0B;
	Mon, 11 Nov 2013 13:06:26 -0500 (EST)
In-Reply-To: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Fri, 8 Nov 2013 19:48:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB830AAA-4AFB-11E3-911B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237622>

"Jason St. John" <jstjohn@purdue.edu> writes:

> rev-list-options.txt: replace e.g. `--foo` with '\--foo'
> rev-list-options.txt: emphasize, instead of quote, some option arguments
>     (e.g. "foo-option" becomes 'foo-option')
> rev-list-options.txt: force ASCIIDOC escaping of "--" (e.g. '--bar'
>     becomes '\--bar')
> rev-list-options.txt: add single quote chars around options missing them
>     (e.g. --grep becomes '\--grep')
> rev-list-options.txt: replaced one instance of "regexp" with "regular
>     expressions"
> rev-list-options.txt: fix typo in "--no-walk" description ("show" -->
> "shown")
> rev-list-options.txt: replaced some instances of double quotes with
>     their ASCIIDOC equivalent (e.g. """a "-" character""" becomes
>     """a ``-'' character""",

Gaah.

Did you really have to repeat "rev-list-options.txt: " on all the
lines?

> Sorry for the messy quoting in the last set of examples in the commit message.

I have a feeling that many of them can and should be turned from
'--opt' to `--opt`.  For example, this original:

>  	Mark which side of a symmetric diff a commit is reachable from.
>  	Commits from the left side are prefixed with `<` and those from
> -	the right with `>`.  If combined with `--boundary`, those
> -	commits are prefixed with `-`.
> +	the right with `>`.  If combined with '\--boundary', those
> +	commits are prefixed with ``-''.

seems to render correctly at

    https://git-htmldocs.googlecode.com/git/git-rev-list.html

without this part of the patch.
