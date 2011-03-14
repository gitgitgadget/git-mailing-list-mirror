From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: running test with --debug keeps "trash"
 directory
Date: Mon, 14 Mar 2011 14:32:59 -0700
Message-ID: <7vy64hbd6c.fsf@alter.siamese.dyndns.org>
References: <4D7E717A.8010605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzFO8-0003Yi-Mw
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 22:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab1CNVdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 17:33:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab1CNVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 17:33:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3051D44BE;
	Mon, 14 Mar 2011 17:34:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5IESKB4QgBV3pIDayDGf0Rn+sY=; b=PiCKcu
	7lyTZDUj/EAMGCyMmOICUiQFU2EG+9lE8uWiRo5zxsmK4d4T+Ci0p36Oh21u4f1Q
	fF9/Gsra7+sJV+MmqEhyzrByIIKI44FCK6nQDdAzpfRRs10r9s9NLhrKKuRQ3EVW
	C8yEpQMkeRSQNhXN7LU/9Cc9BBB0xUK3Mkios=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E8bGjwl367fxqtFbJtaou0MAIS4XwUaQ
	+pRu49u2+Ha+RDTnsRX+ik9gyfw6UW/5MDXf9KD8J5IZFbIwqfyiq/hBkxYTquYl
	PrwH6Tj5rQPBvctfoajGIATF0VJt1/16pxsLjI2LBGiO3r5KpJIVFfpAxmM+XBtA
	t2WyOG/WSik=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E28744BD;
	Mon, 14 Mar 2011 17:34:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C185644B4; Mon, 14 Mar 2011
 17:34:31 -0400 (EDT)
In-Reply-To: <4D7E717A.8010605@gmail.com> (Piotr Krukowiecki's message of
 "Mon, 14 Mar 2011 20:50:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBB3359C-4E82-11E0-B526-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169027>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
> ---
>  t/README |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> It wasn't documented and I didn't notice it at first and found
> it out only after I've started implementing --keep-trash option.
>
> diff --git a/t/README b/t/README
> index 78c9e65..5db567e 100644
> --- a/t/README
> +++ b/t/README
> @@ -79,6 +79,9 @@ appropriately before running "make".
>  --debug::
>  	This may help the person who is developing a new test.
>  	It causes the command defined with test_debug to run.
> +	The "trash" directory (used to store all temporary data
> +	during testing) is not deleted even if there are no
> +	failed tests.

missing is "...so that you can inspect its contents after the test
finished." at the end.

>  --immediate::
>  	This causes the test to immediately exit upon the first
> -- 
> 1.7.4.1.228.g9e388
