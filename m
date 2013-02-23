From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/githooks: Explain pre-rebase parameters
Date: Sat, 23 Feb 2013 13:21:59 -0800
Message-ID: <7vobfa7mko.fsf@alter.siamese.dyndns.org>
References: <20130220163621.GI14102@odin.tremily.us>
 <c8b19dc074a81b009399ff1011102737761658ec.1361633106.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9MYB-0007Qc-9B
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 22:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759288Ab3BWVWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 16:22:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759273Ab3BWVWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 16:22:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93219B9F7;
	Sat, 23 Feb 2013 16:22:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ap3EiqkD0SZhQcqwQxmKhBCz8KA=; b=dXlV9E
	o01RjFcKlnDXSOHD0sszc7Mo0fmxTlmGOEq6CttuaaA3+qi/YBe1lj5VRNCQ4Aia
	nc5C5uezXNf7RHB6i2zzkQDQjS+HDudggHmuPSuU49GXfVahvzF8hQ4T/Za4rGtR
	YGDhdJgvgzWFb/a9ONMQKR1pVO95FUQTpnIaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kFA9edj0AZpxJSt0eUbNV86zw1IV/WPy
	qy6M8ZdR9w2S0fFffSdGkbOlg3fPvOPJM8R/1shYMXe46hg4R/2xBEny7xSIZQPV
	L+Q6wL0Hs//yOffaiooTT+qnzfb89j2083453lj9xl4F3HYZMTcVpojury6rNQeS
	Dfm6WUc+QOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD42B9F6;
	Sat, 23 Feb 2013 16:22:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 833B5B9F0; Sat, 23 Feb 2013
 16:22:01 -0500 (EST)
In-Reply-To: <c8b19dc074a81b009399ff1011102737761658ec.1361633106.git.wking@tremily.us>
 (W. Trevor King's message of "Sat, 23 Feb 2013 10:27:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10372942-7DFF-11E2-9724-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216915>

"W. Trevor King" <wking@tremily.us> writes:

> +This hook is called by 'git rebase' and can be used to prevent a
> +branch from getting rebased.  The hook takes two parameters: the
> +upstream the series was forked from and the branch being rebased.  The
> +second parameter will be missing when rebasing the current branch.

takes one or two parameters?

Other than that, looks good to me, but it took me two readings to
notice where these two parameters are described.  I have a feeling
that a comma s/forked from and/forked from, and/; might make them a
bit more spottable, but others may have better suggestions to make
them stand out more.

Thanks, will queue.

>  
>  post-checkout
>  ~~~~~~~~~~~~~
