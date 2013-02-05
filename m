From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/13] contrib/subtree: Add vim modeline
Date: Mon, 04 Feb 2013 20:32:11 -0800
Message-ID: <7vtxprxtx0.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-9-git-send-email-greened@obbligato.org>
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
X-From: git-owner@vger.kernel.org Tue Feb 05 05:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2aD0-0007zu-IS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab3BEEcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:32:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468Ab3BEEcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:32:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87F2EC69E;
	Mon,  4 Feb 2013 23:32:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYC5c5uCGaHrA7FgQxSt2coYlDg=; b=g7zdpH
	MQnIPNYnDOWXU9yQRqXTGJdLO16RFfjt7pU24v5hrdeUdJecSrUlTs62ImewvoyV
	1Xmemd2CBB+A4agkFkvcVutQEJL7WpHHu//fzS3XTtnJ2iPmbGfn8XOf4fD0bQXO
	4GHvLxQxYcbnqZS3bC0qupa1pa0idVKKhjCF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqP3me+vl5gEM0aBN5rJlIG6rT4JprfZ
	gAiiJDi0SvcaY+3L9BTFx3RWKz4UpFiDUQtPUuf/iqxSx4zZIsq/bjKSzqdixgYc
	cAb+Iva8sbf77nQJ7qVKA8NHCf70rWVj2yY+SbJULh+O+iWYGMSi0BHWRlo65dBK
	5UZXLzdomgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CE28C69D;
	Mon,  4 Feb 2013 23:32:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF257C69C; Mon,  4 Feb 2013
 23:32:13 -0500 (EST)
In-Reply-To: <1360037173-23291-9-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 4 Feb 2013 22:06:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03A7986C-6F4D-11E2-A280-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215450>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh     |    2 ++
>  contrib/subtree/t/t7900-subtree.sh |    2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 6c3929b..c72af95 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -722,3 +722,5 @@ cmd_push()
>  }
>  
>  "cmd_$command" "$@"
> +
> +# vim: set ts=4 sw=4 noet
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index e6a3702..e6bcd50 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -466,3 +466,5 @@ test_expect_success 'verify one file change per commit' '
>  '
>  
>  test_done
> +
> +# vim: set ts=4 sw=4 noet

Please don't.
