From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: update [section.subsection] to reflect
 what git does
Date: Wed, 12 Oct 2011 10:46:49 -0700
Message-ID: <7v62juayra.fsf@alter.siamese.dyndns.org>
References: <1318434726-5556-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 19:46:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE2tO-00031D-8g
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 19:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab1JLRqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 13:46:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab1JLRqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 13:46:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E829853CA;
	Wed, 12 Oct 2011 13:46:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MPBGNgMdKNQH
	N2AxnQzYKqAWddo=; b=BtR7vZ1A1HKSGxEGANWyYej9h53aS32Be1Lvyp6QAXVn
	/TnshQXFaKF7VsQenIzy4NFwn6An6Mhvg136aoZujKEad2yhOfmHchhIuPEvIiWG
	7qCqhptSmjv/ZR9BKNeCXjcWMvhyeNXhEkwWvrht4EDkNar80MabD4v9APBf9PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gbx1QC
	KBzA/z6osAHHN4s2GZQ+6mEAW73CmgpLqqCQPCBznudknED2KjeYXeejTPUlsEJ4
	T6UPE4Pm/Ux5z+5Qp/I0/R2h8gUZDFhW2lbmX411CbC9myYDXHy7VMrk6dxddNHj
	Pz7nWMBRmELRz88+sRsGg5GQ8bOnH2hLPtfRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF94153C9;
	Wed, 12 Oct 2011 13:46:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FDA453C6; Wed, 12 Oct 2011
 13:46:51 -0400 (EDT)
In-Reply-To: <1318434726-5556-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 12 Oct 2011 17:52:06
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A839356-F4FA-11E0-8006-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183378>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> This bit me recently when I was creating a parser. See Jeff's
> explanation here:
> http://thread.gmane.org/gmane.comp.version-control.git/179569/focus=3D=
180290

I think you meant to focus on 180123 but anyway I think the updated tex=
t reads
much better.

Thanks.

>  Documentation/config.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0658ffb..1212c47 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -45,9 +45,10 @@ lines.  Variables may belong directly to a section=
 or to a given subsection.
>  You can have `[section]` if you have `[section "subsection"]`, but y=
ou
>  don't need to.
> =20
> -There is also a case insensitive alternative `[section.subsection]` =
syntax.
> -In this syntax, subsection names follow the same restrictions as for=
 section
> -names.
> +There is also a deprecated `[section.subsection]` syntax. With this
> +syntax, the subsection name is converted to lower-case and is also
> +compared case sensitively. These subsection names follow the same
> +restrictions as section names.
> =20
>  All the other lines (and the remainder of the line after the section
>  header) are recognized as setting variables, in the form
