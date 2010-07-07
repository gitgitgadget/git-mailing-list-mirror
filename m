From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] use "up-to-date" instead of "uptodate" for
 consistency
Date: Tue, 06 Jul 2010 22:28:27 -0700
Message-ID: <7v8w5n2744.fsf@alter.siamese.dyndns.org>
References: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
 <b49995cd151b36cfff5231b28f5e8ff3970c14a2.1278431239.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	<git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNBe-0008Sk-Sy
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab0GGF2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:28:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GGF2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D77C2429;
	Wed,  7 Jul 2010 01:28:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Xw4htFMshUM7flOGQbR2eoJbWgI=; b=izaJDI9nRsC8zdIfeLWqQbq
	5egoHeiR3KE0bWlxSVbymSJsmfurpUNfShYpCX50qZK7D3cc3orx1fvysf9TL/XG
	YRTr+RaSL+DmArcpmTX7o/Bs/ChL63j8fphLI741ORAwe2kJjRfkLdiayGyLov/W
	psCAj2++fZWo7OSDabfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=b9mcyxOSCS1l6nP+OgFSp4xgY5yYLZvjuf+UivyRk/Yu2Xbu3
	zwb2uZdQJsC4Lpz0PAK92TxJtYy9U3clYw25elU2jOX9ymCULB4vXYM++fNga5t8
	lZRKGfw1Gm5aX8b7V83m7pJOPRntO8n2OeaeT418IZkR3nZZUM+d0uSMwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47F73C2426;
	Wed,  7 Jul 2010 01:28:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E218C2421; Wed,  7 Jul
 2010 01:28:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C8E93BE-8988-11DF-95ED-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150448>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> @@ -22,7 +22,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
>  	"Entry '%s' would be overwritten by merge. Cannot merge.",
>  
>  	/* not_uptodate_file */
> -	"Entry '%s' not uptodate. Cannot merge.",
> +	"Entry '%s' not up-to-date. Cannot merge.",
>  
>  	/* not_uptodate_dir */
>  	"Updating '%s' would lose untracked files in it",
> @@ -34,7 +34,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
>  	"Entry '%s' overlaps with '%s'.  Cannot bind.",
>  
>  	/* sparse_not_uptodate_file */
> -	"Entry '%s' not uptodate. Cannot update sparse checkout.",
> +	"Entry '%s' not up-to-date. Cannot update sparse checkout.",
>  
>  	/* would_lose_orphaned */
>  	"Working tree file '%s' would be %s by sparse checkout update.",

What word do you see before "errors" on the hunk comment line?
