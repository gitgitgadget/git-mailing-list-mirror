From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sat, 21 Jan 2012 14:14:41 -0800
Message-ID: <7vwr8kaejy.fsf@alter.siamese.dyndns.org>
References: <201201212036.46681.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:14:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RojCz-0006wO-4e
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab2AUWOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 17:14:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab2AUWOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 17:14:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D095674D9;
	Sat, 21 Jan 2012 17:14:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lt+8WCvLXhyi
	pwINKE1eMDyg+Do=; b=ldjuVZuftZ6ogDntXIT2NUxTu7qNF0fCWMa595sSXBFz
	7PArxVW8dcynCjoPyUlNwHz1P+bGRSqTbUuE8aTZ3flqTskUrOzOKyqaNgWxEJUB
	8d631pam5kf6XyhA3iBmI89a+VwsTp6c2kNyxh6foqC2mFPjxr82NFtTArOOVX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U+6OmA
	lKqRR0x6a/uXV5gm7KWp1zpmssOvfyokqKZnmzCTumFeRp4MJ10N3qaYvxzVsmvd
	xZm7a+0BNUkX1eOfkUm6DnWLwqBZPO3TyiF1Xo+7PnjZXyhgSv7UA+WviuVpIsZM
	VBu52DJIZhuo2LW2gctlEPrSIXRuvFy6YAgSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79A274D8;
	Sat, 21 Jan 2012 17:14:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 593D074D7; Sat, 21 Jan 2012
 17:14:43 -0500 (EST)
In-Reply-To: <201201212036.46681.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 21 Jan 2012 20:36:45
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51EA8B66-447D-11E1-AA9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188937>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Changes since V3:
>
> - Be much more defensive:
>   Do not set core.precomposedunicode=3Dtrue, even if the file system
>   probing indicates that it could be true.
>   (but we don't say that it should be true).
>   This is to keep better backward compatibility within git.
>   The user needs to manually enable the precomposition.
>   However, the .git/config indicates that we have a new
>   configuration variable, and will encourage people to use it.
>
> - compat/precomposed_utf8.c:=20
>     - re-order #includes
>     - Added some empty lines to make code easier to read.=20
>     - Small fixes (xmalloc, errno handling)
>
> - Make function names more consistent by renaming these functions:
>     argv_precompose() -> precompose_argv()
>     str_precompose() -> precompose_str()
> - Improved the commit message

Next time around, please place these after --- lines in the patch messa=
ge
itself, without making a single-patch series with a separate cover lett=
er.

Thanks.
