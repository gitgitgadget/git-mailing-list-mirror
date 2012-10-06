From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 1/5] Fix some asciidoc layout problems
Date: Sat, 06 Oct 2012 11:39:13 -0700
Message-ID: <7vfw5rqwby.fsf@alter.siamese.dyndns.org>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <244418682.269701.1349538839518.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZHe-0004og-SA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab2JFSjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:39:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab2JFSjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:39:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB2129239;
	Sat,  6 Oct 2012 14:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rvlz7BGe8ejJjbzpTjEHUfvVxAI=; b=l4lfOn
	QyMcTvTqJguT8IqEB31V9d7LkKdruor4RDcuRfH68pRcs0+YlUmhFP5JGRVA2p6o
	s0IVNg5AOwHOEA9x7Q1NIDt033s32hVZKWsS4AS3VDmPzbNpyu35S2rRA/IEZVFK
	pABT23dJtf4sddHv1+WQIyEVztrCFSKr2KQTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NJp7GiSElaVHPLrN7LWRCatmYmOiR7wj
	pBHM8qbqYMF9anTuUiwqhGPPuS3cRv3wSqwLjxEepql/2NiIYgdmfhSne4GiGpy7
	8C301ZSC3P+36lys4bFPYjX2TtqMkKo3kj3tQToHctJWllXpuNlM0Cc3kEy7fGs6
	SZmzc6GlWK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D947F9238;
	Sat,  6 Oct 2012 14:39:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F7449237; Sat,  6 Oct 2012
 14:39:14 -0400 (EDT)
In-Reply-To: <244418682.269701.1349538839518.JavaMail.ngmail@webmail08.arcor-online.net>
 (Thomas Ackermann's message of "Sat, 6 Oct 2012 17:53:59 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21091812-0FE5-11E2-9F07-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207164>

Thomas Ackermann <th.acker66@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/git-bisect-lk2009.txt | 12 ++++++------
>  Documentation/git-fetch-pack.txt    |  5 ++++-
>  2 files changed, 10 insertions(+), 7 deletions(-)

You didn't say what "layout problem" you are fixing, or what the
approach you took to "fix" it.  From the patch, I can guess that the
latter is to lengthen the lines that surround the displayed examples,
but as far as I know and can tell, the existing ones are long enough
so I cannot tell why you needed such a change to the source in the
first place.

A better explanation, please?

The synopsis section of git-fetch-pack manual is a long single line
which is unsightly.  A fix to that issue is indeed needed.  Please
make a separate patch only for that issue.  Is git-fetch-pack the
only one whose synopsis section is overlong, by the way?

Thanks.

>
> diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
> index 8a2ba37..99bdb46 100644
> --- a/Documentation/git-bisect-lk2009.txt
> +++ b/Documentation/git-bisect-lk2009.txt
> @@ -248,7 +248,7 @@ Bisecting: 5480 revisions left to test after this (roughly 13 steps)
>  And after a few more steps like that, "git bisect" will eventually
>  find a first bad commit:
>  
> --------------
> +------------------------------------------------------------------------------------------------------------
>  $ git bisect bad
>  2ddcca36c8bcfa251724fe342c8327451988be0d is the first bad commit
>  commit 2ddcca36c8bcfa251724fe342c8327451988be0d
> @@ -257,8 +257,8 @@ Date:   Sat May 3 11:59:44 2008 -0700
>  
>      Linux 2.6.26-rc1
>  
> -:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
> --------------
> +:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
> +------------------------------------------------------------------------------------------------------------
>  
>  At this point we can see what the commit does, check it out (if it's
>  not already checked out) or tinker with it, for example:
> @@ -305,7 +305,7 @@ to launch a script or command at each bisection step to know if the
>  current commit is "good" or "bad". To do that, we use the "git bisect
>  run" command. For example:
>  
> --------------
> +------------------------------------------------------------------------------------------------------------
>  $ git bisect start v2.6.27 v2.6.25
>  Bisecting: 10928 revisions left to test after this (roughly 14 steps)
>  [2ec65f8b89ea003c27ff7723525a2ee335a2b393] x86: clean up using max_low_pfn on 32-bit
> @@ -331,9 +331,9 @@ Date:   Sat May 3 11:59:44 2008 -0700
>  
>      Linux 2.6.26-rc1
>  
> -:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
> +:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
>  bisect run success
> --------------
> +------------------------------------------------------------------------------------------------------------
>  
>  In this example, we passed "grep '^SUBLEVEL = 25' Makefile" as
>  parameter to "git bisect run". This means that at each step, the grep
> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
> index 474fa30..12cd8a2 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -9,7 +9,10 @@ git-fetch-pack - Receive missing objects from another repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
> +'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] 
> +				[--upload-pack=<git-upload-pack>] 
> +				[--depth=<n>] [--no-progress] 
> +				[-v] [<host>:]<directory> [<refs>...]
>  
>  DESCRIPTION
>  -----------
