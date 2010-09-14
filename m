From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] git-reset.txt: point to git-checkout
Date: Mon, 13 Sep 2010 17:19:06 -0700
Message-ID: <7vlj759nyd.fsf@alter.siamese.dyndns.org>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
 <520620a60966ebdfa6e1fe8b407b0de51c302b82.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 02:19:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvJFE-0002Xp-EE
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 02:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0INATQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 20:19:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab0INATP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 20:19:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AFE7D6AFD;
	Mon, 13 Sep 2010 20:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XySPaFiyyt0CZpq8/o5GtYXWQ0Q=; b=YXNUVI
	X2fR6jPSB15FcVNlSPNV+n0A8OocvXe/2FnvdsomhCpb4vxYZoRVLW2kVrLLoNXj
	m6RTTlFIWXD76WgmDkHFroT3Pe45LojDXgJSV3ag9lklxnpQy/FnQy+eamHWDJDl
	79vqqmHmyBUHexmSnupcKnq2gjMlQXBGc/Ows=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iG2aKcP/x+lmo3seZbLLl8HJm/aws6do
	tUL1Vi3E4OQ8F++t9ze8XWydNgmEsL33cLjRaChSeYAPq4BL27UQle+jqKvMB7X/
	quxgfCVdBod93SC3QdApuEhC8SFEgogrmFfWqI7i6FuUVwiD71NKvx3JU1YBm818
	aGFpabivYOk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0625D6AFC;
	Mon, 13 Sep 2010 20:19:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE955D6AF7; Mon, 13 Sep
 2010 20:19:07 -0400 (EDT)
In-Reply-To: <520620a60966ebdfa6e1fe8b407b0de51c302b82.1284365021.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 13 Sep 2010 10\:06\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2FB2942-BF95-11DF-9E06-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156154>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> for the case of updating a file in index and worktree.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-reset.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 60b4b80..40e2fd8 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -27,6 +27,9 @@ in all forms.
>  This means that `git reset <paths>` is the opposite of `git add
>  <paths>`.
>  
> +If you want to reset index entry and working tree state of a file,
> +linkgit:git-checkout[1] is your friend.
> +

I am not quite sure if this is an improvement.

You can reset the index entry using git-reset and then check the path out
of the index to the working tree using git-checkout, in two separate
steps.  You can alternatively stuff the contents out of a commit (or more
in general any tree-ish) to the index and check it out to the working tree
with a single git-checkout.  It is obvious to _me_ that you meant to hint
the latter in the above, but for people who need that hint it probably
isn't.  Can we make it clearer?  Perhaps...

    Using linkgit:git-checkout[1], you can copy the contents of a path out
    of a commit to the index and to the working tree in one go.

Or if you meant the former, 

    After running "git reset <paths>" to update the index entry, you can
    use linkgit:git-checkout[1] to check the contents out of the index to
    the working tree.
