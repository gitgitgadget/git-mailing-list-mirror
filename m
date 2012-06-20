From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 05/11] Makefile: do not replace @@GIT_USER_AGENT@@ in
 scripts
Date: Wed, 20 Jun 2012 13:06:20 -0700
Message-ID: <7vobodu4sj.fsf@alter.siamese.dyndns.org>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183142.GE30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShRAa-00006l-2v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab2FTUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:06:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932265Ab2FTUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:06:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A658224;
	Wed, 20 Jun 2012 16:06:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KX/vpbv7qCIHQHx0kIEaSMzmEMA=; b=eEY1Vx
	XvUbacmb53qDgUi2UlkdSVAE32DV6dy2QYsrAiWECtcOksa6F91ySrsj6RCmZuh7
	IgXEzhgcGkQskURbPmjRzrohYeLDwg+QmoSIwf4m5/DzdC/7IL7l1x0dnI8cPq/E
	xajCREeOQ03SbKqUVymw+dw17nVHwtFY5dQls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V7WOz9MLsxk5xtLtzwoMFRyy+8k9lEYi
	h5CqLwtk9H3udMsPYivLtd/RcePic2ELcgWYhXZKqFbg1ybR2Z3juOebeRQ7n29x
	/COVp0tnspynOyoS/ZjR1bCbHwL/PlLXDwQQVwlLU3ZEAzPgJMpWnoCsxAm2KLae
	2Dkxtdt1y28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C158223;
	Wed, 20 Jun 2012 16:06:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E3AB821E; Wed, 20 Jun 2012
 16:06:22 -0400 (EDT)
In-Reply-To: <20120620183142.GE30995@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 14:31:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 681CEB92-BB13-11E1-B2CB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200354>

Jeff King <peff@peff.net> writes:

> No scripts actually care about this replacement. This was
> erroneously added by d937411.

d937411???

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index d2112f8..336cfc4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2010,7 +2010,6 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \
>      -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> -    -e 's|@@GIT_USER_AGENT@@|$(GIT_USER_AGENT_SQ)|g' \
>      -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
>      -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>      -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
