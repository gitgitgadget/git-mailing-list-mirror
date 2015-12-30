From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: add addition gitweb information
Date: Wed, 30 Dec 2015 14:19:27 -0800
Message-ID: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com>
References: <1451510768-28656-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 23:19:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEP5i-00081y-SW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbL3WTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 17:19:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753801AbbL3WTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:19:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FEAE366F7;
	Wed, 30 Dec 2015 17:19:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t3AP2LxPg4+E+vo2Hn3oqP8+HYs=; b=c7JMgK
	wF7q/vSJD6/REPMMH7pCSMltt2ZUZ9490WRWVbeSYrxcVRQ3tIbyGo1WHj/R635k
	RY8dnmhtGdeONwjv9iZmMysl53H4VOu/lWmjFfgf6y5UnlMYT0LDmUz/3sLXwL3o
	FSjzgPi6743tgE8oFG8t/JWefq1Q0r7AV/wVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbXDCwjv8l23erTKRENZ6IT4fQOCO0K8
	yJvOtC2elfDaAl8rKwtU9cuXiKlzoqDTlIbWVjDYzvLoR/UkXgiuHH6TAJN7O4ux
	62PX5/sBtVJrxaqKBsqHOTxXEJWe32udeuXjnYy0hA8Uyvo3DZ0zI1dZubzVz9yx
	Rokbjw0VW40=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2878C366F6;
	Wed, 30 Dec 2015 17:19:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A2808366F5;
	Wed, 30 Dec 2015 17:19:28 -0500 (EST)
In-Reply-To: <1451510768-28656-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Wed, 30 Dec 2015 14:26:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64669566-AF43-11E5-9561-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283209>

"Stephen P. Smith" <ischis2@cox.net> writes:

>  The gitweb cgi script provides users an easy way to browse your
> -project's files and history without having to install Git; see the file
> -gitweb/INSTALL in the Git source tree for instructions on setting it up.
> +project's files and history without having to install Git. The script
> +enables the user to browse the repository revisions, file contents and
> +logs. Features like RSS/Atom feeds and blame/annotation details may
> +optionally be enabled.

Isn't "browse the revisions, file contents and logs" saying the same
thing as "browse your project's files and history"?  Mention of the
additional features in the last sentence is a very good thing to
have here.

> +The linkgit:git-instaweb[1] command provides an simple way to start
> +browsing the repository.

s/an simple/a simple/;

"... a simple way to start browsing the repository using gitweb",
perhaps?  What's notable about "instaweb" is that it talks with an
on-demand instance of "gitweb" and that is the only reason why we
may want to mention it together with "gitweb".  There are other
repository browsers (like "tig") that do not talk with a local
"gitweb", and we are not intersted in mentioning them all here.

> The defualt server when using instaweb is
> +lighttpd.

s/defualt/default/;

> +See the file gitweb/INSTALL in the Git source tree and
> +linkgit:gitweb[1] for instructions on details setting up a permament
> +installation with a CGI or Perl capable server.
>  
>  [[sharing-development-examples]]
>  Examples
> @@ -4651,8 +4661,6 @@ documentation.
>  Add a section on working with other version control systems, including
>  CVS, Subversion, and just imports of series of release tarballs.
>  
> -More details on gitweb?
> -
>  Write a chapter on using plumbing and writing scripts.
>  
>  Alternates, clone -reference, etc.

Other than that, looks good to me.

Thanks.
