From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: quote AC_PREREQ in configure.ac
Date: Fri, 31 Oct 2014 12:55:49 -0700
Message-ID: <xmqqioj0t3ne.fsf@gitster.dls.corp.google.com>
References: <1414765046-15703-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:55:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkIIg-0005Zi-2C
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 20:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbaJaTzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 15:55:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750710AbaJaTzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 15:55:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32D4C1731F;
	Fri, 31 Oct 2014 15:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cC5H+kkyuwDAuxEEe3mAXzVO6lk=; b=t8CrAp
	O1I9jqSUyN8ZVSSuDVtkft7+g+ntsgFvKKMvFh+6sjL/99FlzvVhqPGT7t77oDQd
	8sl7ytvOY14+FcDFH7D4HiBQ6avpgxmd+Zmbn9Tvym8CHCpfcfO1YJQLes1YFo1a
	Ovel/HGGwLdUWUvAzRQds2jpg0SJxMwpBOAWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YpkurdWH0HbhR1JV9MhiFXifJSI9t5kK
	SH6R+ktnVO0kls9M+5pH51boU1RG008ldhskRK/tnqx/6DNVNXeix4gxrC/rzjvg
	P9E/ZSF9ltx8HJgh4wTdRXM4mbATN/yeCGxi5QzuyXch9CRWY+UchzMS5HfGBUNr
	ACaw6oyQW0w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 224C81731E;
	Fri, 31 Oct 2014 15:55:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 902E71731D;
	Fri, 31 Oct 2014 15:55:50 -0400 (EDT)
In-Reply-To: <1414765046-15703-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 31 Oct 2014 07:17:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA11DC3A-6137-11E4-9FEF-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> For a old bug autoupdate don't do it before autoconf v2.66

I am having a hard time parsing this.

What is the practical issue that comes from the lack of quoting
here?  It won't be like somebody defines a macro to allow 2.59 to
expand to something else, confusing the machinery, so...?

>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  configure.ac |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 6af9647..9f01999 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -141,7 +141,7 @@ fi
>  
>  ## Configure body starts here.
>  
> -AC_PREREQ(2.59)
> +AC_PREREQ([2.59])
>  AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
>  
>  AC_CONFIG_SRCDIR([git.c])
