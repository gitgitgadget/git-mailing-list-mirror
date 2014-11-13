From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: fix an inconsistency
Date: Thu, 13 Nov 2014 10:20:50 -0800
Message-ID: <xmqqy4rf0xod.fsf@gitster.dls.corp.google.com>
References: <5463DA20.3080703@inventati.org> <5463FB4C.2060203@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: slavomir vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoz0u-0003T6-9F
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933484AbaKMSU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:20:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932648AbaKMSU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:20:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3BB61C018;
	Thu, 13 Nov 2014 13:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7TyfO6gU2w410hMNj0UQ+/Ry2pE=; b=fBb+v/
	9gbjuUQsaL8aW8joi4ccDlgQchnWc6Rm2qn10OXwq1RUX0OqCLhQdusdhGKYkayw
	lQ3smiovRS28JKvmov/j+tsF7+KGq3JBLYpp/5nuadUlvYm3B3N18iw7HjzEbobI
	VOdQBw5n1GvtN3ILs/suinuWgpuYZTNnf3CJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqFdj8Eg+tJbcCyWn1OaEwjLCwvlRdxC
	VKjGAfJNW2pPGi3sl6MSKWSDCVOb7tRfm6e1iSSG99J5f0/vRfEayKU1/zOpxIGp
	nJjuS7+jvTccZjGS6djzesfbuJ8bwhU15sjI4RcnVq/qsnptlCKX/ihbGsfTb0HI
	jHfNZPTrNvc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB0791C017;
	Thu, 13 Nov 2014 13:20:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBB781C016;
	Thu, 13 Nov 2014 13:20:53 -0500 (EST)
In-Reply-To: <5463FB4C.2060203@inventati.org> (slavomir vlcek's message of
	"Thu, 13 Nov 2014 01:29:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CDFBAD44-6B61-11E4-8ACB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

slavomir vlcek <svlc@inventati.org> writes:

> The 'SubmittingPatches' document contains a small inconsistency
>  in a patch-email sending procedure.
>
> Not a big thing,
> but a newcomer could get confused.
>
> Please,
> also consider adding the definition/explanation for all the branches available
> at the beginning of this document (and maybe even what their names stand for).
> Thanks.
>
> Signed-off-by: slavomir vlcek <svlc@inventati.org>
> ---
>
> From 74859712cf805663e3863686bdc09511c74b207b Mon Sep 17 00:00:00 2001
> From: slavomir vlcek <svlc@inventati.org>
> Date: Thu, 13 Nov 2014 00:18:39 +0100
> Subject: [PATCH] SubmittingPatches: fix an inconsistency
>
> At line 213 there was an instruction:
>   "re-send it with "To:" set to the maintainer [*1*] and "cc:" the list [*2*]"
>
> and this instruction got repeated once more in the document (line 340):
>   "Send it to the list and cc the maintainer."
>
> This inconsistency was solved by editing the second occurance.
> ---

The same comment applies to the log message part.

Will queue; no need to resend.

Thanks.

>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e6d46ed..fa71b5f 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -337,7 +337,7 @@ suggests to the contributors:
>       spend their time to improve your patch.  Go back to step (2).
>  
>   (4) The list forms consensus that the last round of your patch is
> -     good.  Send it to the list and cc the maintainer.
> +     good.  Send it to the maintainer and cc the list.
>  
>   (5) A topic branch is created with the patch and is merged to 'next',
>       and cooked further and eventually graduates to 'master'.
