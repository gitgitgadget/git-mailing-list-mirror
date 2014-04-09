From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add missing accent grave in git-http-backend.txt
Date: Wed, 09 Apr 2014 11:42:02 -0700
Message-ID: <xmqqeh161h1h.fsf@gitster.dls.corp.google.com>
References: <878875030.1352677.1397067458743.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 20:42:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxRu-0003w6-4H
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 20:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934100AbaDISmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 14:42:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933323AbaDISmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 14:42:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CCC97A4C1;
	Wed,  9 Apr 2014 14:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=smN8WhGCRwNpH4FhAKyJRzmtKwI=; b=RBndg6
	lt4WcNCrOavoQVmaHtRIoZFkjunBDxlHzvdoy/bve6VBfpSfY/6BXfQ776yt8FU3
	y6L/Dm3lquxzQ+EdnmT6wYRyseqe21wSafIimZmaqdApefHjnLaQPqWMtySJa/vE
	zqY7anyrqkK4cHfa7n4zuIjsuBf+tB7N74wcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5SomTT+f4YHidLg4h5/uno4E3FIFzh4
	xvnV54FbAgyz68kLzZRYDkJhXfzQHWPWi9IzigX+VYOtJaKwzfV+E+4l8wYR3Kkl
	g055//KnuW2D3bsfVmCOQ94uUyKRDBrW37oebzjQplUR15WZH7irriYJNd4l6IKG
	lOJ4Yu64hX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 495D87A4BF;
	Wed,  9 Apr 2014 14:42:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63B957A4BA;
	Wed,  9 Apr 2014 14:42:05 -0400 (EDT)
In-Reply-To: <878875030.1352677.1397067458743.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Wed, 9 Apr 2014 20:17:38 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5C470AA-C016-11E3-8287-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245987>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
>
> ---
>  Documentation/git-http-backend.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
> index e8c13f6..d422ba4 100644
> --- a/Documentation/git-http-backend.txt
> +++ b/Documentation/git-http-backend.txt
> @@ -191,7 +191,7 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
>  ----------------------------------------------------------------
>  
>  Lighttpd::
> -	Ensure that `mod_cgi`, `mod_alias, `mod_auth`, `mod_setenv` are
> +	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are

Good eyes; thanks.

>  	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
>  	all requests to the CGI:
>  +
