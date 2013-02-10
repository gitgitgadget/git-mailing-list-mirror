From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/15] User manual updates
Date: Sun, 10 Feb 2013 14:31:11 -0800
Message-ID: <7v621zsswg.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fQw-0007sY-7y
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938Ab3BJWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:31:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab3BJWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:31:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14423CD15;
	Sun, 10 Feb 2013 17:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8uEGgElA3vnppAtcivovzitm2qw=; b=LLWr+H
	4cA7Q+omGP5TR8Rcx9/oEXtKetRzZfGvZHbralUWbHiEtvIuoVGyzVnLKf+PtN7T
	xp8xLy69CVhAZhwsSzLTvtV3kIyJ5psZuL1bdJl0CMqiv18XQaKg2PglfqRLE0uf
	iUkRouTNzPYe5SN+PHPA2YtypcBxkxdFFylL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GgAG6Xjx+8BXxc654tsxTVzzo3yDggSc
	1xobFwgxcrdbHYG2jMkpHsaVTYjRr9Hu2/06obzvbdO95IrFhA99uNJ9BoBDPpCI
	o5qqKVmHuSQwPkjIPSzK21tjAjeNLPsDLRY8gIlbVfv+XkMlZSEiZKzah+zJm3IC
	DO3G/ZpK544=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08F08CD14;
	Sun, 10 Feb 2013 17:31:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66283CD05; Sun, 10 Feb 2013
 17:31:13 -0500 (EST)
In-Reply-To: <cover.1360508415.git.wking@tremily.us> (W. Trevor King's
 message of "Sun, 10 Feb 2013 10:10:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 937BFA7C-73D1-11E2-8B58-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215956>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This combines my ealier patches:
>
> * user-manual: Rewrite git-gc section for automatic packing
> * user-manual: Update for receive.denyCurrentBranch=refuse
>
> With a number of additional fixups.  Changes since v1:
>
> * user-manual: Rewrite git-gc section for automatic packing:
>   - Reworded following suggestions from Junio.  This removed the
>     phrase containing the 'comression' typo pointed out by Javier.
> * user-manual: Update for receive.denyCurrentBranch=refuse
>   - No changes.
>
> Most of the patches are well-focused, with the exception of
> "Standardize backtick quoting".  I can break this up into smaller
> chunks (e.g. "Standardize backtick quoting in Chapter 1", "Standardize
> backtick quoting in Chapter 2", …) if this is too much to bite off in
> one patch.
>
> I may add additional patches onto the end of this series as I make new
> fixes and the series cooks on the list.

Thanks.  I queued 01, 10, 11, 13 directly on 'maint'; they looked
not just good to me but I wouldn't expect any objection to them.

Others patches may see comments from reviewers, so I didn't pick
them up even for 'pu'.
