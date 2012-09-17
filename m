From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: indent-with-non-tab uses "equivalent
 tabs" not 8
Date: Mon, 17 Sep 2012 10:23:08 -0700
Message-ID: <7vpq5kva0z.fsf@alter.siamese.dyndns.org>
References: <201209170820.28489.wjl@icecavern.net>
 <1347891735-10211-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDf2t-0003za-NM
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab2IQRXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:23:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab2IQRXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:23:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC38E861A;
	Mon, 17 Sep 2012 13:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fOqDGZQtm2gcOLYVp9l7Sd7tmHI=; b=E5Ykga
	GtNUxtTuqySmcqXDZf+a5/ZdTLw7Urv9tIwB10gDmIoRYG7Cw9hzduOJ6OlAQRP0
	oHydh2/cfcjSVSX15MKiUitZ+tD9A19XhPsSwq996WhCpIR+m3gzhs5dqcEarzOG
	CWLCMbePl90LPXpKfbw1DEGq9XawLTX5oBS+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBALZB337cG1Lxf8VA6u4yJch+YCDomU
	cmCEpljRM29rB2KeNJRSaiVyb/Uesbef8HVA8FLNl3hjK8TfUxLukLNimmVtPVE/
	4/Vvuu5aqcMgSGwiCyCuZdbb6KJICfRXaqD6dOY07NbiKFhnjEX1ZVicdiQxpRaG
	krHSDaZMgV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A748617;
	Mon, 17 Sep 2012 13:23:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3452A8616; Mon, 17 Sep 2012
 13:23:10 -0400 (EDT)
In-Reply-To: <1347891735-10211-1-git-send-email-wjl@icecavern.net> (Wesley J.
 Landaker's message of "Mon, 17 Sep 2012 08:22:15 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A5319F4-00EC-11E2-A8E4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205717>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> From: "Wesley J. Landaker" <wjl@icecavern.net>
>
> Update the documentation of the core.whitespace option
> "indent-with-non-tab" to correctly reflect that it catches the use of
> spaces instead of the equivalent tabs, rather than a fixed number.
>
> Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
> ---
>  Documentation/config.txt |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6416cae..11f320b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -559,8 +559,9 @@ core.whitespace::
>  * `space-before-tab` treats a space character that appears immediately
>    before a tab character in the initial indent part of the line as an
>    error (enabled by default).
> -* `indent-with-non-tab` treats a line that is indented with 8 or more
> -  space characters as an error (not enabled by default).
> +* `indent-with-non-tab` treats a line that is indented with space
> +  characters instead of the equivalent tabs as an error (not enabled by
> +  default).
>  * `tab-in-indent` treats a tab character in the initial indent part of
>    the line as an error (not enabled by default).
>  * `blank-at-eof` treats blank lines added at the end of file as an error

Thanks, that reads much better.
