From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Add setup_merge_commit function to
 merge/builtin.c.
Date: Wed, 09 Feb 2011 15:24:54 -0800
Message-ID: <7v8vxookop.fsf@alter.siamese.dyndns.org>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-2-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJPM-0002dA-3R
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab1BIXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:25:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab1BIXZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:25:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 136284E3F;
	Wed,  9 Feb 2011 18:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJI/jv9bIlcCp0JOznO6D3YZFRg=; b=VU6wX/
	gU7I45Nmexxt4yFTsBpvCp+sWJNm8KIiIqWbOJL10f8VjGexzggvxvl7r0Pi7ovy
	gy68h2Y1K6htKxTutPuGzwfLOHuWp/2JAHOpUIrxwiH491cofzVNcgBMuy9mRo58
	KuwXIWKKja249drfqjuRO3IfA8f9lC8evd6nU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXMhRa/6Rg7x88OgyNyCqV0Q47qw5+fX
	742H8MQggFT2/uAu5AZd47TvtLLJ3PvUvHvTfa3znb2Hh1IRD+aUuhu3+Kt+TKdq
	rXBvRyf7LllGlgtMicEZQLcSW1JkfqWCj6FFJkirL5+GzWGdHoZv95sh7Eaq5WLL
	Jk26MKtNt3E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBB674E3E;
	Wed,  9 Feb 2011 18:25:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 086564E3B; Wed,  9 Feb 2011
 18:25:56 -0500 (EST)
In-Reply-To: <1297211028-14382-2-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Tue\,  8 Feb 2011 19\:23\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3F92B0A-34A3-11E0-9826-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166454>

Jared Hance <jaredhance@gmail.com> writes:

> Subject: Re: [PATCH v3 1/3] Add setup_merge_commit function to merge/builtin.c.

Please spell the name of the file you are touching correctly ;-).

	Subject: builtin/merge.c: Add setup_merge_commit function

> Adds a new function that will be used in a later patch as well as the
> current code to reduce redundancy.

Redandunt.  If you say "add", we know the function is "new" ;-)

State what that function does instead of a vague "reduce redundancy",
perhaps like...

	Refactor the loop to parse list of commits given from the command
        line into a separate helper function.

The patch itself looks good.

Thanks.
