From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch_merged: fix grammar in warning
Date: Sun, 27 Feb 2011 01:17:07 -0800
Message-ID: <7vy6514z1o.fsf@alter.siamese.dyndns.org>
References: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
 <AANLkTimN2ba8Ab2BRp=sU4NT_e6UYh4HH2L7afgEkHg8@mail.gmail.com>
 <7vbp1z8apg.fsf@alter.siamese.dyndns.org>
 <AANLkTikL1KkSTeNgT2dhE2bGBu5FHY8HiqxfjPMd90sT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Eric Hanchrow <eric.hanchrow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptckk-0007B7-Lj
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab1B0JRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:17:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1B0JRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:17:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40EB026B6;
	Sun, 27 Feb 2011 04:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iTSfLgpYW05j1QGjsl7ub+n4Tlg=; b=qt+n3k
	lfW4/Wj76J2ujtKA1LD3MJKtMMKLmOMhLUOtl5wkODmGVvsOKyu+oBWmgecA035l
	o7vEuqfIOi5fm5+autHYF0g0Yxf3NtIgOV356EQoW0Sex5kRjU5g6uTrZzh4goqd
	OKBO6Qqce9x6l7upsY3dLq55QyzbSuin0Hn5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vnw3xV4V8tToiazam8SbaeT0u3n1ZfL2
	2FCq54OpenD/7t/EOaKZamccR5qPLLa4BxNSHzqc58qyVkfAn35bTb0irXUvoHOV
	j1aakf/6tVNl+OmiTkssF2deu0ViZ863sSw0SabdloeMkjRwH9AkBLOWlRIW5VpK
	RmPxuBhv3eU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FFD426B4;
	Sun, 27 Feb 2011 04:18:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E8C8826B0; Sun, 27 Feb 2011
 04:18:24 -0500 (EST)
In-Reply-To: <AANLkTikL1KkSTeNgT2dhE2bGBu5FHY8HiqxfjPMd90sT@mail.gmail.com>
 (Eric Hanchrow's message of "Sat\, 26 Feb 2011 05\:03\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89F2D456-4252-11E0-9ADF-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168016>

Eric Hanchrow <eric.hanchrow@gmail.com> writes:

> OK, here it is again:

Thanks, applied.  I ended up also dropping "has", though ;-)

> From: Eric Hanchrow <eric.hanchrow@gmail.com>
> Date: Fri, 25 Feb 2011 19:29:42 -0800
> Subject: [PATCH] branch_merged: fix grammar in warning
>
> Signed-off-by: Eric Hanchrow <eric.hanchrow@gmail.com>
> ---
>  builtin/branch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 9e546e4..27c2000 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -134,7 +134,7 @@ static int branch_merged(int kind, const char *name,
>  	    in_merge_bases(rev, &head_rev, 1) != merged) {
>  		if (merged)
>  			warning("deleting branch '%s' that has been merged to\n"
> -				"         '%s', but it is not yet merged to HEAD.",
> +				"         '%s', but has not yet been merged to HEAD.",
>  				name, reference_name);
>  		else
>  			warning("not deleting branch '%s' that is not yet merged to\n"
