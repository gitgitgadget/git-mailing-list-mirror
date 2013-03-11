From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/23] contrib/subtree: Add commands pull_all and
 push_all
Date: Sun, 10 Mar 2013 22:03:07 -0700
Message-ID: <7vk3pebkac.fsf@alter.siamese.dyndns.org>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
 <1362958891-26941-6-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	bibendi <bibendi@bk.ru>, "Peter Jaros" <pjaros@pivotallabs.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Win Treese" <treese@acm.org>, "Wayne Walter" <wayne@tickzoom.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 06:03:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEutd-0001yg-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 06:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab3CKFDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 01:03:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab3CKFDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 01:03:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE6C2975F;
	Mon, 11 Mar 2013 01:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7LoC1KjzM1ulVCN3c9HCpjAwgzM=; b=oeBgo7
	HmViEd7jSwx0q43ctt/FkO7ve6vmh8UYOp3ceZUnrMR4I/4RLBAHjnDQ0zUEn06z
	F1CD+dMWHGKuGv5v+W2y/dLs5RA8yuj4UGUBWAMGaCGrGLH0pMSROVOzu3QZCwTs
	b/u0XMM559LjftV1KpZlC3xJIiB053ph/sqeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gx09e4wtdLcl4XG7to5lapRNIGGr1PEB
	X6F0fqT8z8/PE4OIeErkgMfm6ye4hjNfDc4ZNJ+bGy1cNwpHqYd9VYOPZPp/k6q5
	4SnY3zznqn/+HWtxvoomhUCjeGn12az0IbgfaRhKB0hnL+06Kgoxq9HJoFvSh/ki
	irbsx8tduwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1F7B9758;
	Mon, 11 Mar 2013 01:03:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3149753; Mon, 11 Mar 2013
 01:03:09 -0400 (EDT)
In-Reply-To: <1362958891-26941-6-git-send-email-pcampbell@kemitix.net> (Paul
 Campbell's message of "Sun, 10 Mar 2013 23:41:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7968E08-8A08-11E2-A9D8-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217853>

Paul Campbell <pcampbell@kemitix.net> writes:

> From: bibendi <bibendi@bk.ru>
>
> For each subtree listed in .gittrees perform a push or a pull.
>
> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
>
> Conflicts:
> 	contrib/subtree/git-subtree.sh

The "Conflicts:" part is totally irrelevant.  Please remove.

> ---
>  contrib/subtree/git-subtree.sh | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 1aff956..ddae56e 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -12,6 +12,7 @@ git subtree add   --prefix=<prefix> <commit>
>  git subtree add   --prefix=<prefix> <repository> <commit>
>  git subtree merge --prefix=<prefix> <commit>
>  git subtree pull  --prefix=<prefix> <repository> <refspec...>
> +git subtree pull_all

Why isn't it "pull --all"?

>  git subtree push  --prefix=<prefix> <repository> <refspec...>

Where did "push_all" go?

> +cmd_pull_all()
> +{
> +    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |

"grep -o" is not even in POSIX.  Besides, what is this trying to
parse?  Is it expected to match lines like

	path.subtree=trash

with this, or is it more like you only want something like this:

	subtree.over/there.path=foo

in which case you would want to read with something like

	sed -n -e 's/^subtree\...*\.path=\(.*\)/\1/p'

instead (modulo the usual caveat on $IFS whitespaces in path)?

> +        while read path; do
> +            git subtree pull -P $path master || exit $?
> +        done
> +}

I'd stop looking at this series myself at this step for now.
