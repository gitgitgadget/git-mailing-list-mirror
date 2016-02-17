From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver.perl: fix typo
Date: Wed, 17 Feb 2016 10:00:35 -0800
Message-ID: <xmqqegcbjjy4.fsf@gitster.mtv.corp.google.com>
References: <1455675298-75332-1-git-send-email-obliviscence@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mmogilvi_git@miniinfo.net
To: GyuYong Jung <obliviscence@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6P4-0002hs-7K
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423389AbcBQSAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:00:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423122AbcBQSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:00:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5A6142BEF;
	Wed, 17 Feb 2016 13:00:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YnqKdAIhQC/nNfrP5U6EYvI1o/c=; b=WK6CV6
	jVNLmUqRrfflJodNSlmFpc9RCRWtUOU/Sj8f0qA5JHXI95uLeQuJGwLa21Y4tVns
	X5R3QNp70RSHR6Y0N3mfdcSMaM57HLzG1mTpNLWwa2K/+iIp0pCc/1apAaTLkpon
	HxQ5Yp9XyQ2yIJI8i89EIHdpfMEF+FVEQd+Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcIHrO6fTP+BaWwDfeYZnzrS5XWWulvR
	RY1kw6bTOyekUlSnxUM6TjIpMUyOoMJ4mpZlRxE6Kotxpm4sVgBku5SZqDPNAttP
	jrz3tnWFhFBmkMVCo9E2WHtXMwx+xHnY4DcgNEzcA0aBwgN5xidyTwTeIpSJ9oB8
	UEpLGtIFO7k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC99542BED;
	Wed, 17 Feb 2016 13:00:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B78542BEC;
	Wed, 17 Feb 2016 13:00:36 -0500 (EST)
In-Reply-To: <1455675298-75332-1-git-send-email-obliviscence@gmail.com>
	(GyuYong Jung's message of "Wed, 17 Feb 2016 11:14:58 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58AD0506-D5A0-11E5-A6C5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286516>

GyuYong Jung <obliviscence@gmail.com> writes:

> Signed-off-by: GyuYong Jung <obliviscence@gmail.com>
> ---
>  git-cvsserver.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 95e69b1..02c0445 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2664,7 +2664,7 @@ sub argsfromdir
>      #   co  # Obtain list directly.
>      #   remove # HERE: TEST: MAYBE client does the recursion for us,
>      #          # since it only makes sense to remove stuff already in
> -    #          # the sandobx?
> +    #          # the sandbox?

Thanks.

>      #   ci # HERE: Similar to remove...
>      #      # Don't try to implement the confusing/weird
>      #      # ci -r bug er.."feature".
