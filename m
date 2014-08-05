From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] imap-send doc: omit confusing "to use imap-send" modifier
Date: Tue, 05 Aug 2014 13:48:21 -0700
Message-ID: <xmqqvbq6oe7e.fsf@gitster.dls.corp.google.com>
References: <20140805025108.GW12427@google.com>
	<1407207410-26443-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 22:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEleu-0005Uy-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 22:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaHEUsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 16:48:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52575 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbaHEUsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 16:48:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC3692EEB6;
	Tue,  5 Aug 2014 16:48:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TDn1qy9RPDzQXMpv5gYjvmfesuE=; b=V0Rul+
	gU32YZZeVaK2iNMtSJr6aNNqSjx9qzoqc0A/awQn54LlLAGFmdoF+j5YTJTpKEMa
	Bmv2zTkNYgpj7WsUvSiz6e7UihkcPMCi60xtReAvSKb8LLJe31YWgVaIBHySvNSc
	AiVTDiwl3V0JoY+lYHt0jXd/XZTCfkQLUFB6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jO5wZ7UOFvBeE1666fNdNdcKtIhYIdT+
	lj6Xc/OcR5nvbX82enXGKrMtO6j6PjzNuJTrGglBxlUvJDNjHrG2hoNWxU4X/8A7
	2DaFnCDX0dFevGGd5aAw5RJJ1lLr9lYvzrXFD5TkHFr8Lznr3+hbvHan5RzsQbKO
	+uoyt9vRiyI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D11412EEB5;
	Tue,  5 Aug 2014 16:48:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 160EB2EEA1;
	Tue,  5 Aug 2014 16:48:23 -0400 (EDT)
In-Reply-To: <1407207410-26443-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Tue, 5 Aug 2014 02:56:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D729E99A-1CE1-11E4-B67B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254826>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It wouldn't make sense for these configuration variables to be
> required for Git in general to function.  'Required' in this context
> means required for git imap-send to work.
>
> Noticed while trying to figure out what the sentence describing
> imap.tunnel meant.
>
> [jn: expanded to also simplify explanation of imap.folder and
>  imap.host in the same way]
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks, both.  Will queue and squash the "required. otherwise." fix in.

>  Documentation/git-imap-send.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 875d283..d3b465d 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -38,17 +38,17 @@ Variables
>  imap.folder::
>  	The folder to drop the mails into, which is typically the Drafts
>  	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
> -	"[Gmail]/Drafts". Required to use imap-send.
> +	"[Gmail]/Drafts". Required.
>  
>  imap.tunnel::
>  	Command used to setup a tunnel to the IMAP server through which
>  	commands will be piped instead of using a direct network connection
> -	to the server. Required when imap.host is not set to use imap-send.
> +	to the server. Required when imap.host is not set.
>  
>  imap.host::
>  	A URL identifying the server. Use a `imap://` prefix for non-secure
>  	connections and a `imaps://` prefix for secure connections.
> -	Ignored when imap.tunnel is set, but required to use imap-send
> +	Ignored when imap.tunnel is set, but required.
>  	otherwise.
>  
>  imap.user::
