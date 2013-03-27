From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed typo in git-pull manual
Date: Wed, 27 Mar 2013 09:11:04 -0700
Message-ID: <7vmwtoomav.fsf@alter.siamese.dyndns.org>
References: <d50c433f40ef6d353966b84250c40d9ecd9de51d.1364381294.git.mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKswx-0001hM-EC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab3C0QLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 12:11:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab3C0QLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Mar 2013 12:11:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D375CA209;
	Wed, 27 Mar 2013 12:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IQTKbR6xWwcx
	VwqWCjvCBKYHh0Q=; b=ILoKwGpKv0gjl3NyDbHph2xAXy5vkcHduZoCZ4+dGsxJ
	r/oUCVZn9EB2WOJAWnhEiAWnsYWcGGtRqwVYN0eIXgbVvz957oTxFhXKWMKo6I7/
	MIZIqYt/6xX5sH5jBkAdFFuFcHXI+2ZnFImPKdMCR4GiYdOXnkB/7aMJeZd7lCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bz8/Ae
	gUjXlbqcd4tzaFRG3Sh5MfvwS6CwBo6jLWCKqHRd0hPG2CA7SlZnCJaiUzlXN5da
	3QOBxgFkSSsgnTiAcVR0JYbxVZRqtiD3S3XmXAseCiJSVG3isEz+8FESncFmyRH1
	zVyMqAIjCENN6QGQcXu/Gg4ufbBk/QsZRyi4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C877EA207;
	Wed, 27 Mar 2013 12:11:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47EB3A205; Wed, 27 Mar 2013
 12:11:06 -0400 (EDT)
In-Reply-To: <d50c433f40ef6d353966b84250c40d9ecd9de51d.1364381294.git.mihai@mihaic.ro>
 ("Mihai =?utf-8?Q?Capot=C4=83=22's?= message of "Wed, 27 Mar 2013 12:04:51
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDF79142-96F8-11E2-8C01-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219265>

Mihai Capot=C4=83 <mihai@mihaic.ro> writes:

> Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
> ---

Thanks.

It might be better to make it "which resulted in complex conflicts",
though.

>  Documentation/git-pull.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index c975743..eec4c1d 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -218,7 +218,7 @@ $ git merge origin/next
>  ------------------------------------------------
> =20
> =20
> -If you tried a pull which resulted in a complex conflicts and
> +If you tried a pull which resulted in a complex conflict and
>  would want to start over, you can recover with 'git reset'.
