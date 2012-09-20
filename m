From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Wed, 19 Sep 2012 17:06:53 -0700
Message-ID: <7vboh1eew2.fsf@alter.siamese.dyndns.org>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:07:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUIK-0004F2-1s
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab2ITAG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:06:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab2ITAGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:06:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7648766;
	Wed, 19 Sep 2012 20:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cp4bZwjV1vzsuFxXEDcfNePkmOM=; b=FMrRZd
	oHofM2Y2BgEnCUpwhKzv62k16+rS5mtYSIaR8kC5FwerSSo49Xd6x05CvpFrfHVW
	SikooTTjQFSMGYlXxFMX201pYGT7BBAfikL6rYyK72PBRtUFWbd8+UmLp38g0ecf
	QVWkBCwIjt/bMQeM3QLSKeVMXvJXNysj/PGGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMnTH/Uoq2f+ufe2si1vaxRFn5GWYx1U
	zSKWIwZW+X6JbeVFVVQqAMRkovGF396Xn3SZIO/cIDUxgb9whTMbsjMhlzpA/ZAD
	UzEkdZGXTIqlRjbN0s99fGnmW7DVeYc40JS6GD7AeeSOf556+l9wKLftJe78p14Y
	6vhaAZwB/NQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD1858765;
	Wed, 19 Sep 2012 20:06:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D57A8762; Wed, 19 Sep 2012
 20:06:54 -0400 (EDT)
In-Reply-To: <1348094310-11214-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Wed, 19 Sep 2012 23:38:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E15E6C-02B7-11E2-806D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206018>

Adam Spiers <git@adamspiers.org> writes:

> ---

No explanation why this is a good idea, nor sign-off?

>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 t/test-lib-functions.sh
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> old mode 100644
> new mode 100755
> index 8889ba5..e022e73
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -562,7 +562,7 @@ test_expect_code () {
>  		return 0
>  	fi
>  
> -	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
> +	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code from: $*"
>  	return 1
>  }
