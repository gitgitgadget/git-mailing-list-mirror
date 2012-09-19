From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/8] Doc: shallow clone deepens _to_ new depth
Date: Tue, 18 Sep 2012 20:45:36 -0700
Message-ID: <7vvcfaiskf.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 05:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBEV-0000MM-LR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 05:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2ISDpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 23:45:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab2ISDpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 23:45:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E35BB972C;
	Tue, 18 Sep 2012 23:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qX+ofMhCcbKyYD3uzve1npgF7SY=; b=Vdq9EV
	zkqXykwPeMXgSQEgBgoy0it3/BaD2AJod8p55o471aaxq3AdMpZWycmt6rVvkqTR
	vC8krPQOR56RqAo+gfZsjTTj9Qaly4R8s/FeBf/ofAkDILXvf8afyMPiM8BcX9xo
	xTTaV9jBFN8bw3Zr8njv8UYbvTYVnfVLNOA4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DCN6ThIa8tELCWSSNdSKLCKpAr9cIz1I
	9XqzJyErOZWeqfX1GsPFzqSjffQcEk0ecaBzxwJuemE6o24bZpE19YawrT4viYPb
	QqNBeNRjlpVO6uoMz/13LOh6br5WQ73VPz9FjqYgpq2pTRmjJ8Oq1v3F27OE9FIR
	P+Uuaz8MI1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D164F972B;
	Tue, 18 Sep 2012 23:45:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D0A3972A; Tue, 18 Sep 2012
 23:45:38 -0400 (EDT)
In-Reply-To: <1348010734-664-3-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79F0DF64-020C-11E2-95C1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205901>

Philip Oakley <philipoakley@iee.org> writes:

> Clarify that 'depth=' specifies the new depth from the remote's
> branch tip. It does not add the depth to the existing shallow clone.
> (details from pack-protocol.txt).
> Clarify that tags are not fetched. (details from shallow.txt)
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 39d326a..b4d6476 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -10,7 +10,8 @@
>  --depth=<depth>::
>  	Deepen the history of a 'shallow' repository created by
>  	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
> -	by the specified number of commits.
> +	to the specified number of commits from the tip of each remote
> +	branch history. Tags for the deepened commits are not fetched.

Looks good; thanks.
