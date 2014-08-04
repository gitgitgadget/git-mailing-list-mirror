From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Mon, 04 Aug 2014 11:29:33 -0700
Message-ID: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
References: <1407023821-103681-1-git-send-email-sandals@crustytoothpaste.net>
	<1407024847-104449-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN12-0000yO-ES
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaHDS3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:29:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62909 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbaHDS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE9662DCBF;
	Mon,  4 Aug 2014 14:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fMBHm6kqvbsoMK2BFsePSAH7sJg=; b=e2f1Y8
	LRPwMXr8Mh0ld8ldiEaX5DTUAmJ+/5XgTBmwvZmdbwMO7AAe4zkI0pX58BdfRHAc
	2qvzurcjiG28eoEFWfRqQTTXvtnKDebygz0A+NXnLaFOGoNmLmalDBCgdw1tW/i5
	0wU13sUGKY5NCVwYqNmUiJbIjXHFLfwH13yKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vex8B5Pg5BBwoWhKfAENZociY/KXMgHO
	ySoyTnRNzNrPJ/GEEyOHgQuWifKD8ebRbj+lzYOJiN2c+3FeRiecxfTchDkTbOSP
	QQ2aJfj7CPje6seUvuS31VjvoxNwcllSgFlb5nR8RMceTYDPvCCNV+I6o1DW5GwL
	6peupR3hVMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1C7B2DCBE;
	Mon,  4 Aug 2014 14:29:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59C402DCA9;
	Mon,  4 Aug 2014 14:29:36 -0400 (EDT)
In-Reply-To: <1407024847-104449-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 3 Aug 2014 00:14:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 49A2F468-1C05-11E4-8134-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254751>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Avoid a nonsensical misreading by moving the modifier closer to the
> word it modifies.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-imap-send.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 875d283..23231e1 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -43,7 +43,7 @@ imap.folder::
>  imap.tunnel::
>  	Command used to setup a tunnel to the IMAP server through which
>  	commands will be piped instead of using a direct network connection
> -	to the server. Required when imap.host is not set to use imap-send.
> +	to the server. Required to use imap-send when imap.host is not set.

To be honest, I find both versions are equally confusing.

How about dropping the three words "to use imap-send"?
