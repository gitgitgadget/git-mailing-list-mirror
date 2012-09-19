From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] Doc branch: show -vv option and alternative
Date: Tue, 18 Sep 2012 21:01:14 -0700
Message-ID: <7va9wmirud.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-9-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEBTa-00079T-9R
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 06:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab2ISEBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 00:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2ISEBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 00:01:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A800C9989;
	Wed, 19 Sep 2012 00:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V1oa1ir6bS4WkCrbxSq/748DSNU=; b=rFtnTV
	gqVD5hbOwlpeGTSBH7ZB4DxTzSJtzLN9sGBNvKIFSeyStVSOxnoTZuVNTcpbyRut
	WEd8/Laa6ijquuJ6CG2AjpPSRhoM8/FxHsjIj4p9zt5AQPwbe5xX9IBWi0i0wMtH
	pMkGccmeJzS1fcJDUjafN7UMHN13Y3gTKlNAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZnsgxPrxvtdEXQYXXtgZ8z7p3hBQ+r9
	ZT8WKVHUEIv5fE1M6FIX1ffDavj9MLVU7K56yliRhWA5Pyej8HNf985hIW5zYkfZ
	FTI9MCa6idbtp2VZVmQzZecMt1vE9QsAAZKS4HgEDwxJFM7wo6a4TfQShVIYwk1F
	MXwIvpfJ8AQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 955FC9988;
	Wed, 19 Sep 2012 00:01:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D1789987; Wed, 19 Sep 2012
 00:01:15 -0400 (EDT)
In-Reply-To: <1348010734-664-9-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8E05276-020E-11E2-B5A2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205906>

Philip Oakley <philipoakley@iee.org> writes:

> --v::
> +-v, -vv::
>  --verbose::
>  	When in list mode,
>  	show sha1 and commit subject line for each head, along with
>  	relationship to upstream branch (if any). If given twice, print
> -	the name of the upstream branch, as well.
> +	the name of the upstream branch, as well (see also `git remote
> +	show <remote>`).

Can you try

	-v::
        -vv::
        --verbose::
		The description...

instead?  Cf. http://thread.gmane.org/gmane.comp.version-control.git/205184/focus=205315
