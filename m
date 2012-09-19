From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/8] Doc: 'git' has a discussion section
Date: Tue, 18 Sep 2012 20:50:36 -0700
Message-ID: <7vr4pyisc3.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 05:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBJI-0002kz-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 05:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab2ISDuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 23:50:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab2ISDui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 23:50:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30DF097EA;
	Tue, 18 Sep 2012 23:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qs1MJffGgPd0V2+YztivEzFVxIM=; b=KN8Q6i
	FXX5Ejok78M9M88z9Sqg8UqVpeWC1r53nirJscyMq0MsXgAw/lTED7luxu+0bIdj
	NtKeknswp8oufDbIHpMpE+Q2TEd0h8BzTRVRChCQmgQgLKkO5ukgZ9YZ+W6FcO9B
	9doT1m6k17o3iP6S/U+lxPrvOYM0CxvRpHxEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bre8JIdapU8JxoD/6dQiQSKk/3TaSUKL
	M6ULQNfaEdU7mY6N3IuQJmDAMpyDyJV++dJnDacuPgXUJ68Sc1ueE0OU+XgfHg7Z
	2rvVnTufwSeHnUclppWR3IvyNOrQq7YllxyQVirdx5il2aYcm2P/+KOopiF7XIEG
	cncPYauAxag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E32F97E9;
	Tue, 18 Sep 2012 23:50:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A6C197E8; Tue, 18 Sep 2012
 23:50:37 -0400 (EDT)
In-Reply-To: <1348010734-664-5-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C3C0FA4-020D-11E2-97DD-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205902>

Philip Oakley <philipoakley@iee.org> writes:

> Highlight there is a further discussion section later in
> git man page
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 34d8a1b..d932a3e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -30,6 +30,7 @@ After you mastered the basic concepts, you can come back to this
>  page to learn what commands git offers.  You can learn more about
>  individual git commands with "git help command".  linkgit:gitcli[7]
>  manual page gives you an overview of the command line command syntax.
> +See also the Discussion and Further Documentation sections below.
>  
>  Formatted and hyperlinked version of the latest git documentation
>  can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.

I am not sure if this is appropriate.

The primary objective of this paragraph is to nudge people who try
to dive into the body of this document without understanding the
fundamentals (which tends to waste their time) without spending too
many words.  After they visit these pages, they are armed with
sufficient prerequisite knowledge and are free to go directly to
documentation for individual subcommands, and this page is one of
such pages.  I do not think Discussion and Further Documentation
sections are such prerequisites they should read before coming back
here and looking at the list of subcommands.
