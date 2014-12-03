From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Wed, 03 Dec 2014 09:18:00 -0800
Message-ID: <xmqq7fy8k5yv.fsf@gitster.dls.corp.google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
	<546F4B5B.2060508@alum.mit.edu>
	<xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
	<5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de>
	<20141127225334.GA29203@dcvr.yhbt.net> <547895F1.1010307@alum.mit.edu>
	<xmqqh9xgrssc.fsf@gitster.dls.corp.google.com>
	<CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
	<20141203035347.GH6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Wong <normalperson@yhbt.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:20:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDbB-0008K6-KV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbaLCRUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:20:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbaLCRUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:20:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D747221A8D;
	Wed,  3 Dec 2014 12:20:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dGgoaLcC5SdvPyyjRjuTH6RS2Dw=; b=d3UyGF
	RKQzqCk/Xn1Qh3hwR1kC+e3kPMZM3BHSGQI2yLmCsfgr1Yy5Ul2CVHrTei6O0TwH
	aeV15rTH77SqQ/CRBKiM9h+23ciEXAtcfq5CiSaX1Jf7BZfxc3aRYrRrdC24PeWB
	9qVwFciBzK2Q4a3ph+jG8r5reMXBZscs6AgsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Il4+4slrn1O/VfRmIeZlWwLvVyzFwxbE
	v/cIwI6UHoHq3Tt64qrGiuEN/MGQbCEbNh/yiyRbOypEELZ75AcWV9Iog/lRn8v8
	61mz0MxReKue0i6z+ZGvyNjTKp87vtb9khSfhCUGVnXN3Md4CtAhgfAoysi3PVIq
	Fxy3bDLOhq0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD55221A8C;
	Wed,  3 Dec 2014 12:20:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1E5E21A0E;
	Wed,  3 Dec 2014 12:18:01 -0500 (EST)
In-Reply-To: <20141203035347.GH6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 19:53:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55E41BCA-7B10-11E4-8F4E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260665>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I don't think there's any reason that newcomers should need more
> iterations than regulars to finish a patch.  Regulars are actually
> held to a higher standard, so they are likely to need more iterations.
>
> A common mistake for newcomers, that I haven't learned yet how to warn
> properly against, is to keep re-sending minor iterations on a patch
> too quickly.  Some ways to avoid that:
>
>  * feel free to respond to review comments with something like "how
>    about this?" and a copy/pasted block of code that just addresses
>    that one comment.  That way, you can clear up ambiguity and avoid
>    the work of applying that change to the entire patch if it ends
>    up seeming like a bad idea.  This also avoids having to re-send a
>    larger patch or series multiple times to clear up a small ambiguity
>    from a review.

This can go both ways.  A trivial improvement can be suggested that
way by the reviewer.

>  * be proactive.  Look for other examples of the same issue that a
>    reviewer pointed out once so they don't have to find it again
>    elsewhere in the next iteration....
>  * feel free to get more review out-of-band, too.  If you're still
>    playing with ideas and want someone to take a quick glance before
>    the patches are in reviewable form, you can do that and say so
>    (e.g., with 'RFC/' before 'PATCH' in the subject line).

Overall, good suggestions.

Thanks.
