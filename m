From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/9] user-manual: Mention 'git remote add' for remote
 branch config
Date: Sun, 17 Feb 2013 18:26:25 -0800
Message-ID: <7vwqu6cq7i.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <1ef8fd5d7754ef65a9aaf26250b7b9f0488ff59c.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7GRR-0005dW-5z
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466Ab3BRC03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:26:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab3BRC02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:26:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BD66B360;
	Sun, 17 Feb 2013 21:26:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X94x40FCWDY23ypoVimeqk2qLN8=; b=sVlUtc
	DiCNZjeaZke+jvPVQ+UwCPZCLfD4qP+HofauzM36zaH4C+qMlLvfcBolZf5EBt8+
	Ryx4vms8H59+iBJE3OG3yyAaWt4Bf7AKdAqUY3Ft+aXRAd6LO40Eln9VFxd0aPGN
	3T8zRFMwR8Yu2RPu3yBiJ3yjs4BwJSAmj87AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZ8ZsLE2b7wTinu24XkTouefnDy6+xc0
	OnpMh//YTPmWcfeY1j0Qy2lQpLfxSK+WJOtY1/OlEETIWeXm06OTEqoIl5Z6v4n7
	ktUufRlYhAbMNPwsAnVoRWyhFTIDwv0V4tj7LwCiAumCTERSDdw7KBYu1m+St4Ds
	NUJBfb5ypPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF5EFB35F;
	Sun, 17 Feb 2013 21:26:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67C80B35B; Sun, 17 Feb 2013
 21:26:27 -0500 (EST)
In-Reply-To: <1ef8fd5d7754ef65a9aaf26250b7b9f0488ff59c.1361146398.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 17 Feb 2013 19:15:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98FA9976-7972-11E2-A381-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216431>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> I hardly ever setup remote.<name>.url using 'git config'.  While it
> may be instructive to do so, we should also point out 'git remote
> add'.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This looks like a good 'maint' material that can be applied straight
away there in preparation for 1.8.1.4 to me (modulo one nit);
reviewers watching from the sideline, please stop me if you see
issues.

> +After configuring the remote, the following two commands will do the
> +same thing:
>  
>  -------------------------------------------------
> +$ git fetch git://example.com/proj.git +refs/heads/*:refs/remotes/example/*
> +$ git fetch example +refs/heads/*:refs/remotes/example/*
>  $ git fetch example
>  -------------------------------------------------

These _three_ commands will do the same.
