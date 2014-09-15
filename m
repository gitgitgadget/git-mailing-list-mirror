From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] Documentation: a note about stdout for git rev-parse --verify --quiet
Date: Mon, 15 Sep 2014 15:34:16 -0700
Message-ID: <xmqqbnqg4ion.fsf@gitster.dls.corp.google.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
	<1410808059-1459-2-git-send-email-davvid@gmail.com>
	<1410808059-1459-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeqn-0001XN-KO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759047AbaIOWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:34:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58383 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756765AbaIOWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:34:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C2173B37E;
	Mon, 15 Sep 2014 18:34:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d3XaCrcQn9epm/37flTNpwpIYwQ=; b=YePA4x
	f7GPqTZXHr9clA2ttQWKEIbB9cQkLmBXqsaplRMzbBbZh35PjHr2FWouH+Xr8oo1
	f2RQ//D9KWSU2p+MdNPrVV7U2U5/tobbYJd0YsluoFlTO1nfiOc1QKvS/6dfs14l
	ysmIH1P9Q7Zc366e0f3guIFdmAT5Vu+V5RG2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h80vV8zo8luRulYjkHiNz31qLgs3i1WX
	CVG3mBeVz/E0qZPjroPeLoQAVSP/Gx3Bo+TfT0Dod+8MJLz4Y7VrVuU061uO6VnY
	Zxoje7yMyfPu+YjPTueOdrMOD6yVUmi7JYcq5qhsOI3IkVxj6WdS+T2/ul1l+I5g
	699PNfcNSkE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6308F3B37D;
	Mon, 15 Sep 2014 18:34:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC9C83B37C;
	Mon, 15 Sep 2014 18:34:17 -0400 (EDT)
In-Reply-To: <1410808059-1459-3-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Mon, 15 Sep 2014 12:07:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DDD622A-3D28-11E4-BA2D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257114>

David Aguilar <davvid@gmail.com> writes:

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This patch is new: we now mention that stdout contains the valid object name
> when --quiet is used, which may not be clear when reading this paragraph in
> isolation.
>
>  Documentation/git-rev-parse.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 0b84769..fa4a8c3 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -114,6 +114,7 @@ can be used.
>  	Only meaningful in `--verify` mode. Do not output an error
>  	message if the first argument is not a valid object name;
>  	instead exit with non-zero status silently.
> +	SHA-1s for valid object names are printed to stdout on success.

OK.  Thanks.

>  
>  --sq::
>  	Usually the output is made one line per flag and
