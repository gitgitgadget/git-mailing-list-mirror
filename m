From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: fix duplicate words of "output"
Date: Fri, 06 May 2016 10:26:51 -0700
Message-ID: <xmqqshxv3xno.fsf@gitster.mtv.corp.google.com>
References: <1462537363-17962-1-git-send-email-lip@dtdream.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ilya.bobyr@gmail.com
To: Li Peng <lip@dtdream.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:27:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjWm-0007FB-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758680AbcEFR0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 13:26:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758143AbcEFR0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 13:26:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA271755F;
	Fri,  6 May 2016 13:26:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJKq3gPVbCGuZ1OZDRXvmhLMWYY=; b=l0UhYl
	hMBEZ4g1wQ8Q9f5CkACGWXud4CmViGyf4Rp85wJFfsJ0dBWNvdzAAk+uvZK9A8ke
	7cEFbaw6m+XDF6VMEwZ7TWzZsHB6oeYcPW4VBlpX1O5a389QRe+h8DYHx67dYWCr
	SmN+kO15DlUouxXTtVmQf8vyQN/EEI7PJT+5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtpsJTTvTeyizLVP/jh0s1udYWu76sb5
	rKDc2GLw3LBhLumw2nw8n//VspHVi4+qDzn+x1UzG+DFV2tiuEklN/EjMbU704gV
	kSdpwTNJlDtIyfy+aKi/g0sx0rKfiQUP8YQENBK8AB0g2P2o74CkK+HdsnrE3lOG
	KTG+t5/50Lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7689C1755E;
	Fri,  6 May 2016 13:26:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01E801755D;
	Fri,  6 May 2016 13:26:52 -0400 (EDT)
In-Reply-To: <1462537363-17962-1-git-send-email-lip@dtdream.com> (Li Peng's
	message of "Fri, 6 May 2016 20:22:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B94A3210-13AF-11E6-95B4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293837>

Li Peng <lip@dtdream.com> writes:

> Fix duplicate words of "output" in comment.
>
> Signed-off-by: Li Peng <lip@dtdream.com>
> ---
>  t/t0000-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 79b9074..60811a3 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -98,7 +98,7 @@ check_sub_test_lib_test () {
>  }
>  
>  check_sub_test_lib_test_err () {
> -	name="$1" # stdin is the expected output output from the test
> +	name="$1" # stdin is the expected output from the test

The original is marginally correct.  The first "output" is a noun,
"expected output", the second one is a pp of verb "to output",
i.e. "to produce".

I would have written it as "the expected output produced by the
test", though.
