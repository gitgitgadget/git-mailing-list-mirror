From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Teach reset the same short-hand as checkout
Date: Mon, 09 Mar 2015 19:34:04 -0700
Message-ID: <xmqq385d60o3.fsf@gitster.dls.corp.google.com>
References: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	davvid@gmail.com, sunshine@sunshineco.com
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 03:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV9zo-0000c6-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 03:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbbCJCeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 22:34:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750933AbbCJCeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 22:34:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB713F06E;
	Mon,  9 Mar 2015 22:34:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I86ESMJi22x7chgMm1Ofb7vk/G0=; b=i+57np
	2lfY9kmoZ2y1ONHV94CQjfbxEyIkD1Kj4rz41w4jc4t0jmiG6YRVowyVNoy0Em8l
	v9yP8jvd1vkGntWRvDhOSRZj6C2MB+DaC5kJlKPqPE6keYgZTAJngGuO2OvPiK1a
	5qVsGxFEvANxQbLzdZD5/1FAeP0MVDS9RUwkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xyNN/KKAQWO1UjRGHKHq6ENevudsR2WF
	yWZBHZE4at8LU1kT5WdaBGPbwt4UX2xIn9ywRlP3XurKgvPBTU8ae/tJ0SBYkttX
	9dxytuiDR+07VQZK5LJb/6JBcsaY5OUF3gVFV/XZalRJ116k9A76Q6Ent0igXRWF
	vJEerlO3N1o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 458183F06D;
	Mon,  9 Mar 2015 22:34:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A31B13F06C;
	Mon,  9 Mar 2015 22:34:05 -0400 (EDT)
In-Reply-To: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com>
	(Sudhanshu Shekhar's message of "Mon, 9 Mar 2015 13:45:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBEEAA0A-C6CD-11E4-9DD7-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265207>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

> "-" now means the previous branch.
>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> Thanks-to: Eric Sunshine, Junio C Hamano, Matthieu Moy
> ---


These look unusual for a few reasons: your S-o-b should be at the
end, we usually say Helped-by: instead, and we do not use these with
multiple names on a single line.

Please do not try to be original without a good reason.  We may
start counting the number of times people appear on these footers to
see how much contribution those who do not directly author commits
(read: those who mentor others) are making.

>  builtin/reset.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

The comment I gave in the thread that ends at $gmane/265112 would
apply equally to this patch, I think.

cf. http://thread.gmane.org/gmane.comp.version-control.git/264986/focus=265112
