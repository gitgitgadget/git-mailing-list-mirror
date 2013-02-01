From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Use consistent links for User Manual and Everyday
 Git; Fix a quoting error
Date: Fri, 01 Feb 2013 10:43:14 -0800
Message-ID: <7vzjznan99.fsf@alter.siamese.dyndns.org>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
 <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1LaN-0001aB-72
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100Ab3BASnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:43:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756669Ab3BASnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:43:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32D0EC725;
	Fri,  1 Feb 2013 13:43:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLvR7Jmx+MhzXY08kbIO2eIhlNI=; b=p9zs84
	L3y4/y+TdrQxGdcNVUYniXAYBF28ftckY40J27cLtLd1WPBdLJuIFhBKWN0LFd/F
	0PayiQppNi+ejkJDFuBWhts6gxuy04hbsUma2Z1zh06lLAOPzGdv1/a20WwbQA7x
	i7FXmUe1sCxfKliYAGlAXVtNOeokM0JXDnLCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RfURIJOVBr6fiO/MT51OOysP1Cw+8AzT
	nrYaHmM9ZeRilKqUsF8MUhFDh8THPUXI8hS04lsyprnd3NIw5cvgh2f3Hjps4UKJ
	mRGR5BXr2BPlAV4Y1hu5Bh6iyO6xSJw1K9UF/vLUlNSlLzvnpRJuf2ogeSXctI8u
	g/EkEEtOvE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FE4C724;
	Fri,  1 Feb 2013 13:43:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90A09C723; Fri,  1 Feb 2013
 13:43:15 -0500 (EST)
In-Reply-To: <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 1 Feb 2013 19:12:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D256660-6C9F-11E2-926D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215248>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/git.txt              | 2 +-
>  Documentation/gitcore-tutorial.txt | 6 +++---
>  Documentation/gittutorial-2.txt    | 2 +-
>  Documentation/gittutorial.txt      | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index c431ba2..c5f6845 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -23,7 +23,7 @@ and full access to internals.
>  
>  See linkgit:gittutorial[7] to get started, then see
>  link:everyday.html[Everyday Git] for a useful minimum set of
> -commands.  The link:user-manual.html[Git User's Manual] has a more
> +commands.  The link:user-manual.html[The Git User's Manual] has a more
>  in-depth introduction.

Thanks.
