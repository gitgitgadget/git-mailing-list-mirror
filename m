From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] user-manual: add addition gitweb information
Date: Wed, 30 Dec 2015 15:29:09 -0800
Message-ID: <xmqq7fjvcy7u.fsf@gitster.mtv.corp.google.com>
References: <xmqqoad7d1g0.fsf@gitster.mtv.corp.google.com>
	<1451517920-30703-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 00:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQBE-0000eU-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 00:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbbL3X3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 18:29:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbbL3X3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 18:29:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E6C236ADF;
	Wed, 30 Dec 2015 18:29:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EQw4X09UOGEXFawFCXFSWzRekOA=; b=a52UnT
	2l+3PAS52aDQUtIetYeBvf4xqDG5IuIahbDUP7rQcOxGj4rb16/pYUrfnxf3yIVQ
	rTwuW7FEekQNiJOboLpidHbY6jcFgjNml3zZ342+l1ZYjgMEhW2O3qnxtU/4XchW
	1GpMZTz/pasNYB9fAijqPut5thHvHiKrhVWJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mcppf3yyy/8jRX2i5+VPCq/t7szRp82U
	14TUlJJXJHWUjDn/UTTQhRbriRmdvyILybDncm5k593QNmA1m4e3spKWA4ZW5032
	NPwlSE3i6Sb88pK0lCdU/S89anQzazbMKLC15cU5LrJ0omTmr6SWQ7v7dwqpj8hL
	sKkM2Xmtv38=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9590436ADE;
	Wed, 30 Dec 2015 18:29:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A83336ADD;
	Wed, 30 Dec 2015 18:29:14 -0500 (EST)
In-Reply-To: <1451517920-30703-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Wed, 30 Dec 2015 16:25:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23AD3976-AF4D-11E5-800B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283216>

"Stephen P. Smith" <ischis2@cox.net> writes:

>  The gitweb cgi script provides users an easy way to browse your
> -project's files and history without having to install Git; see the file
> -gitweb/INSTALL in the Git source tree for instructions on setting it up.
> +project's revisions, file contents and logs without having to install
> +Git. Features like RSS/Atom feeds and blame/annotation details may

Thanks.  Was there a reason to rewrite "files and history" into
"revisions, file contents and logs"?  The words "revisions" and
"logs" both refer to the same thing and "history" is a good word for
it already, so I am puzzled.  No strong objection, though...

> +optionally be enabled.
> +
> +The linkgit:git-instaweb[1] command provides a simple way to start
> +browsing the repository using gitweb. The default server when using
> +instaweb is lighttpd.
> +
> +See the file gitweb/INSTALL in the Git source tree and
> +linkgit:gitweb[1] for instructions on details setting up a permament
> +installation with a CGI or Perl capable server.
>  
>  [[sharing-development-examples]]
>  Examples
> @@ -4651,8 +4660,6 @@ documentation.
>  Add a section on working with other version control systems, including
>  CVS, Subversion, and just imports of series of release tarballs.
>  
> -More details on gitweb?
> -
>  Write a chapter on using plumbing and writing scripts.
>  
>  Alternates, clone -reference, etc.
