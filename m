From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am.txt: --ignore-date flag is not passed to git-apply
Date: Tue, 09 Dec 2014 12:27:48 -0800
Message-ID: <xmqqegs8lgaj.fsf@gitster.dls.corp.google.com>
References: <1418146098-30099-1-git-send-email-rdwampler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, giuseppe.bilotta@gmail.com
To: Ronald Wampler <rdwampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRNz-0007Jw-RO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbaLIU1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:27:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbaLIU1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:27:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E949B23310;
	Tue,  9 Dec 2014 15:27:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bImzTf1FBVMiA8JOnP2R/CrGYjU=; b=pAof1H
	99f4qbaZ0yuvjaR7+Cmwbzf7gzctun6nPY4T/NSx1fpvfpAVv6zOEayB4ErGlW6c
	+qxSFPKXnr1PbHtLKN+Rgb/ZM/1j5Xg2TRDUAkW4PLDaKVZaMN2dIXxiU8bQdGcu
	/3a9YJtqxEYnIuqHSYwlwWdMVXC4jEYPhxuSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9II4n9w+X8U6hyEa2sGGRGpOtouECII
	54Z5ITjh7qmmv6ZP7Nig6DNn7uD7LvVPJuohcw06ajJeXl6fSXHoYisGUwXQYdVP
	i6I0CAptx2TGdFBdboc4tacnRaUoMTfU6ZTa7Q2GU8V9gML535WgRpfsXK0KpUwN
	DW4JKxWS09Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E08C62330C;
	Tue,  9 Dec 2014 15:27:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58F762330B;
	Tue,  9 Dec 2014 15:27:50 -0500 (EST)
In-Reply-To: <1418146098-30099-1-git-send-email-rdwampler@gmail.com> (Ronald
	Wampler's message of "Tue, 9 Dec 2014 12:28:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8730990-7FE1-11E4-8360-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261162>

Ronald Wampler <rdwampler@gmail.com> writes:

> ---
>  Documentation/git-am.txt | 1 -
>  1 file changed, 1 deletion(-)

Of course ;-)  "git apply" does not care about dates as it does not
make the commit.

Thanks.

>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 9adce37..d4ef16c 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -83,7 +83,6 @@ default.   You can use `--no-utf8` to override this.
>  	it is supposed to apply to and we have those blobs
>  	available locally.
>  
> ---ignore-date::
>  --ignore-space-change::
>  --ignore-whitespace::
>  --whitespace=<option>::
