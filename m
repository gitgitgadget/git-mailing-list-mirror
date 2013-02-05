From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] contrib/subtree: Fix whitespaces
Date: Mon, 04 Feb 2013 20:42:58 -0800
Message-ID: <7v6227xtf1.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-8-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene <greened@obbligato.org>"@b-sasl-quonix.pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2aNW-0004Hd-IH
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab3BEEnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:43:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755601Ab3BEEnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:43:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD620CE5A;
	Mon,  4 Feb 2013 23:43:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JcwKuFALK816IlcpkuYfYjg3Xq8=; b=sQJyfc
	2bDicou/F4GCaIpZPIPisMA6Qlu7hyxlFrtC7aESc3pFOH5Hw+bjrWq/Ew8sSld0
	mVbmXNTl9uOMJ4Z7e22kts5+4qsAxIUSTAiNnKS3Qi06SmAX4oTwgANkA2LZnj2r
	AwLLf1ySSg06MiPnk7QeUj2/varXWS5gE/hFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+f8dx5UXtLt9XyVIOt5WzOmwbu0X+9V
	3/WdsCaoYA1K96ptCyCZAEHcO5+34bVxiUFJHiiPM3dhCvUt2D99lMuUOJ1uqqr+
	0gTxuYrTSkHhMC2EFiCItBmm5Ihl98q5cuzenoQ9/4URZfgc/X+MnYy9Toyc9hqD
	SHBQzB4FU8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C193CCE57;
	Mon,  4 Feb 2013 23:43:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A96FCE53; Mon,  4 Feb 2013
 23:43:03 -0500 (EST)
In-Reply-To: <1360037173-23291-8-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 4 Feb 2013 22:06:07 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86D5F7E6-6F4E-11E2-8CBE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215457>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Previous code does not fulfill Git's whitespace policy.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---

This does not seem to apply; I hand-tweaked it to make it apply, but
the reindentation of t/t7900 does not look correct.

> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 3f17f55..e6a3702 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -23,7 +23,7 @@ check_equal()
>  {
>  	test_debug 'echo'
>  	test_debug "echo \"check a:\" \"{$1}\""
> -	test_debug "echo \"      b:\" \"{$2}\""
> +	test_debug "echo \"		 b:\" \"{$2}\""
>  	if [ "$1" = "$2" ]; then
>  		return 0
>  	else
> @@ -61,17 +61,17 @@ last_commit_message()
>  }
>  
>  test_expect_success 'init subproj' '
> -        test_create_repo subproj
> +		test_create_repo subproj

Perhaps this was originally done with an editor whose tabwidth was
set to 4?  It gives too much indentation when standard tabwidth of 8
is used.
