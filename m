From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] add basic tests for merge-tree
Date: Wed, 14 Jul 2010 12:59:29 -0700
Message-ID: <7veif5ygv2.fsf@alter.siamese.dyndns.org>
References: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
 <1279127047-3273-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 21:59:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ87N-0003Fv-JG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 21:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979Ab0GNT7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 15:59:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab0GNT7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 15:59:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 937D8C44B2;
	Wed, 14 Jul 2010 15:59:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EQKsXaGFNoeHTwHhdJGQBdPT78o=; b=wu+ZhH
	vZCFgqnAOdJh6sV9Dgq2TUxs3olcw5y+xUiTHzMA7N6N68GtIZu/5JyCLtj+xQM/
	PcQAZOjgrBuN5GMzKWPMDrVO+5emPJJA10olgTa+0yxn/zdjzUrN/rdQ3yzibNxs
	lnq5awQ5WOgSa5C9IF9yWjQoZmyvOKe9kPN+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGxjMDpIp8dsK7M/6xtHsRcCdrq0W1vM
	UCNsancNfY2MP4s7N2cg4PLlKlmjFT9lhF5hzpNfpAkLmnK7dNF14RDiStxzM5nQ
	0zPeO276ov5u4K8dK2luoGrrj/WQ+qbu0RL/JvYX+IstNTPqG9hzX6Dk9OVy4DnV
	x+IN6sPzD7A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A6D1C44AF;
	Wed, 14 Jul 2010 15:59:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A88D5C44AD; Wed, 14 Jul
 2010 15:59:31 -0400 (EDT)
In-Reply-To: <1279127047-3273-2-git-send-email-wmpalmer@gmail.com> (Will
 Palmer's message of "Wed\, 14 Jul 2010 18\:04\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53830DC4-8F82-11DF-B000-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151031>

Will Palmer <wmpalmer@gmail.com> writes:

> merge-tree had no test cases, so here we add some very basic tests for
> it, including some known-breakages.
>
> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> ---
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> new file mode 100755
> index 0000000..c02c986
> --- /dev/null
> +++ b/t/t4300-merge-tree.sh
> @@ -0,0 +1,257 @@
> ...
> +test_expect_'file add A, !B' '

Oops?

I'll queue with obvious/trivial fixups.  Thanks.
