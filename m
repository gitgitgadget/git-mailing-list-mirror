From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/14] ls-remote doc: fix example invocation on git.git
Date: Sun, 23 Jun 2013 00:22:51 -0700
Message-ID: <7vy5a1guk4.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqedW-0006Of-8v
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab3FWHWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:22:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab3FWHWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:22:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E59261E1;
	Sun, 23 Jun 2013 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4SC43+k1HBuuuhMNMZUOnUJkICs=; b=wNY/cb
	p6nzJ72CkDhtr1A3duFEgTrobLsHuUuLPpUyCYGza2mwKZ5b0Bsx6k0HQWHhE4HB
	P1oCnS6E+dMaCJopURhFK1sC8WXehJ2AQouoxRQbDm4gf3CR/+kIUZQ0ljnB2gr9
	4EhDLOhctYhKXQqeGMchA2sN7ara4agI1k7OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHvHCF4KNpnRkdIS/xuwlSTFjLaZcFQY
	O3GelUA1fCswW4NdYPx0gZjzeuNKXhRJHfpxXNSvDwnxdSBEmKw2Nr8xyp45Gnt1
	u2wcUFMSW1jMhQ4RW972DKeJITcco2ALnsxgeiUpxM4WB5LXG4TPbekJ4ipEICeZ
	pl7yUP+BsdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9665261E0;
	Sun, 23 Jun 2013 07:22:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D611261DF;
	Sun, 23 Jun 2013 07:22:53 +0000 (UTC)
In-Reply-To: <1371887901-5659-9-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 22 Jun 2013 13:28:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7C1370A-DBD5-11E2-8C81-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228723>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Under the EXAMPLES section, there is one invocation on the git.git
> repository that attempts to list the refs master, pu, and rc.  The ref
> rc does not exist in today's repository, so remove it.  Among other
> things, this example demonstrates that the "<refs>..." argument is
> simply a filter; requesting a non-existent ref is not an error.

These last two lines are better be in the documentation, no?

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 774de5e..cce4f93 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -70,7 +70,6 @@ EXAMPLES
>  	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
>  	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
>  	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
> -	b1d096f2926c4e37c9c0b6a7bf2119bedaa277cb	refs/heads/rc
>  	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
>  	$ git ls-remote --tags public v\*
>  	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
