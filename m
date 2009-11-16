From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for
 fixed-strings
Date: Mon, 16 Nov 2009 15:36:50 -0800
Message-ID: <7vocn2m48d.fsf@alter.siamese.dyndns.org>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091116195050.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Collins <bricollins@gmail.com>,
	Jeff King <peff@peff.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:37:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAB8Z-0004cQ-62
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbZKPXg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbZKPXg5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:36:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbZKPXg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:36:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC62800B6;
	Mon, 16 Nov 2009 18:37:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yBmDsMRTBIgToGfcgFIeUjOxHH8=; b=AiD7tG
	oYLTH4ZMnHLhTJUHmJEi/8nC1hxLI/XLNYmfc1JhcRUCQb0yQA/ZGAldgRXRZ99v
	8LpBTKRXgvqBWB8YKLS5vdyuOwueWLfS4zhuNKIEFAzprTx8hJSEdaglkI0xE+4S
	Qw+XE67lFAbNC38sw25+tXMkEmJYVLH9gBbKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hTkt6r7P4m7e1MdI1BkL0+97Nxz5kpzp
	k4tfiYHkcJDL4MisLDYsc08d/+Qo7A7C3ndy1IIenTZ0XeYN4UkfR5BuAjPYiycb
	+FkOrfTAqHBZ4xqDrUgYmRhMiaY83NVBFr1eXq4k6nUzpd/Szo4EY09BupJYYUtO
	+Cl5sfdh75U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E82A7800B1;
	Mon, 16 Nov 2009 18:36:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13A08800B0; Mon, 16 Nov
 2009 18:36:51 -0500 (EST)
In-Reply-To: <20091116195050.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 16 Nov 2009 19\:50\:50 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EDB906DC-D308-11DE-BED6-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133037>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Brian Collins <bricollins@gmail.com>
>
>> You will have to excuse me, this is my first patch and I don't know if
>> this is the right place to post this. Apologies in advance if I'm in
>> the wrong place.
>>
>> git-grep currently throws an error when you combine the -F and -i
>> flags. This isn't in line with how GNU grep handles it. This patch
>> allows the simultaneous use of those flags.
>
> Junio, may I ask what happened to this patch?

We got sidetracked into a larger picture issues of how to allow platform
ports to selectively call out to external grep depending on the feature
set supported by the external grep implementations.

Later I looked at the original patch, the patch text looked fine (except
that I would have called the field "ignorecase", not "caseless"), but it
wasn't signed off and did not have usable log message.

And then I forgot ;-)

Thanks for a reminder, and thanks Jeff for a resend.
