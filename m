From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Sun, 07 Oct 2012 13:27:37 -0700
Message-ID: <7v7gr2qb7q.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7v7gr75s40.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0ZzOmwFxAt40gHXi98JEq+==9ctiLYVYf4UE5GB+V8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:28:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxSV-000805-Ls
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab2JGU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 16:27:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab2JGU1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 16:27:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14D679153;
	Sun,  7 Oct 2012 16:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2IC5zW3gqqL9JencB+JXBxMRPnc=; b=JmdGQe
	XB+bdUHrHe0BrZ1HquDgdyXyHQ0RCD941XNZ55P/YE8WmzRoBVNSQd3c1+CEX9yi
	QizekhI66Zw0PuCE3WV7EPu2lxbhHHncphS3g3sm1VaEQHefy0LdDetyGat2cJ/N
	k2n20K4JnLYPllbJAIDK5UUgD46Vx7jpZz9Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=db4HZp0tHjyu2+4SesT+GgkPvunGIZ5o
	jD0quiH6D9pc+2HTHBC6DYeH19rxoAnfG/4YGbuB2rTjY+QewgL0ZdYgoqw2EiAO
	xl9w3xl7Cj8xDVMa/+zE9n+lhD12a23hTpKHOoGIzaaJ5tO3le3DUvwtYHCQVAXz
	/p8aRGSHBy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 022829152;
	Sun,  7 Oct 2012 16:27:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34654914E; Sun,  7 Oct 2012
 16:27:39 -0400 (EDT)
In-Reply-To: <CALkWK0m0ZzOmwFxAt40gHXi98JEq+==9ctiLYVYf4UE5GB+V8A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 7 Oct 2012 21:39:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7039B364-10BD-11E2-B609-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207191>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>
>> With a weaker phrase, e.g. "These configuration variables may be of
>> interest", such a list may not hurt readers, but personally I do not
>> think it adds much value to have a list of variables without even a
>> single line description of what each is used for.
>
> Okay.  Does this work?

Hrm, is it useful without even a single line description of what
each is used for?

Besides, how does it appear in the formatted documents?  A thick
paragraph that lists names of variables enumerated without comma in
between?

> -- 8< --
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Sun, 7 Oct 2012 17:24:36 +0530
> Subject: [PATCH] Documentation/git-push: add a configuration variables
>  section
>
> The list of configuration variables that affect the operation of a git
> command can often be hard to find.  As a first step, add a
> "Configuration variables" section to git-push.  The intent is to
> create similar sections in all manpages.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-push.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index cb97cc1..a125536 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -426,6 +426,30 @@ Commits A and B would no longer belong to a
> branch with a sy
>  and so would be unreachable.  As such, these commits would be removed by
>  a `git gc` command on the origin repository.
>
> +Configuration variables
> +-----------------------
> +
> +These configuration variables may be of interest.  For more
> +information see linkgit:git-config[1].
> +
> +branch.<name>.remote
> +core.gitProxy
> +http.proxy
> +push.default
> +receive.autogc
> +receive.denyCurrentBranch
> +receive.denyDeleteCurrent
> +receive.denyDeletes
> +receive.denyNonFastForwards
> +receive.unpackLimit
> +receive.updateserverinfo
> +remote.<name>.mirror
> +remote.<name>.proxy
> +remote.<name>.push
> +remote.<name>.pushurl
> +remote.<name>.receivepack
> +remote.<name>.url
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
