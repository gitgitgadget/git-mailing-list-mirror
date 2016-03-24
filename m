From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] completion: add option '--guides' to 'git help'
Date: Thu, 24 Mar 2016 13:01:25 -0700
Message-ID: <xmqqbn638x2i.fsf@gitster.mtv.corp.google.com>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
	<1458844034-12855-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 21:01:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajBRq-0000Y4-9S
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 21:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcCXUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 16:01:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbcCXUB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 16:01:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C72684D529;
	Thu, 24 Mar 2016 16:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfB/S1kwUjObZw6/+3lxmh7C/0g=; b=c8l+vn
	cU/+in0Jo/fvJjK0qZvWDNuj8rUSwqorrHYNq9IyTWrMe987YPExRidYJmUoJH6L
	pVdNNcIS4c9YQhjDwAW7GVW24xrMGhL2HK21MAsmp/ZKCFvL4ZTg6QeOaqK2CueM
	KFMTxpPZQSHOMphwDf/Z4ZLeDym7i7/Qz9g4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DY9HwqhIy4xGZv2sCdGz2TXCS4CHT0hC
	MmFcct1Bps1bgVqKzoNsPUM9Yi/cD0UCZKg3cPXqRzimD6Wljn25DsKFiwt6VAen
	pg4fdPrhIVSt+1NARQomWCukrWVTYlb6fiCfLsgq5VthmEqZs6jojtoWVUxj/WsI
	1/DsdqLF4Mw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BECDE4D528;
	Thu, 24 Mar 2016 16:01:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42D464D527;
	Thu, 24 Mar 2016 16:01:26 -0400 (EDT)
In-Reply-To: <1458844034-12855-2-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 24 Mar 2016 19:27:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30D28FE8-F1FB-11E5-89C5-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289793>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sounds sensible.  Thanks.

>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e3918c8..70f4171 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1339,7 +1339,7 @@ _git_help ()
>  {
>  	case "$cur" in
>  	--*)
> -		__gitcomp "--all --info --man --web"
> +		__gitcomp "--all --guides --info --man --web"
>  		return
>  		;;
>  	esac
