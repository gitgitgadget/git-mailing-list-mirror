From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 13:44:02 -0800
Message-ID: <xmqq7fykw9y5.fsf@gitster.dls.corp.google.com>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk>
	<xmqqegstychq.fsf@gitster.dls.corp.google.com>
	<54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de>
	<5473A2D0.5010101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:44:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1Qa-0001bL-3v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbaKXVoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:44:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782AbaKXVoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:44:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80F5821389;
	Mon, 24 Nov 2014 16:44:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3JOPzESrw0N6zOzrV6CRrHDXkg4=; b=WuGng4
	jAof0P9wtkWa65e/ljeUTJgHPku/B9l9YaRjbey3n/rgugQsksexYtf/rJ8i2OMV
	Ys/89dXJ9HEDfKlBxXk4rT+MluDT6XuMw9qPzYpOzcEmJgOFNIbvJTT08eAh+qZG
	yJu0v5OThmjQy2g05cRUfVSr4jPUgPduWvI68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dkgAUg44FFdc/qS1sGXhUia35/MfM9mp
	GBqj8pif61dQ/+BmT9I23tnHro9Md3NovNWVT9xED2mB6cPps7KFMOc6NkkEyaeA
	T7fYs+ciBVenWtxb9RW7xmfimfDgPt1YBxWP/WFgXULEurT/9/slp3Wa+SdKDi8G
	ZXB2RvxwNUc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 672F421388;
	Mon, 24 Nov 2014 16:44:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBF4B21387;
	Mon, 24 Nov 2014 16:44:03 -0500 (EST)
In-Reply-To: <5473A2D0.5010101@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 24 Nov 2014 21:27:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 024B08B4-7423-11E4-8F7C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260153>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I updated from cygwin 1.5 to cygwin 1.7 at the beginning of the year.
> Since it is no longer supported, I don't think we need to worry about
> version 1.5. When I said 'old installation' I meant my old version 1.7
> 32-bit installation.
>
>> One netbook was converted from XP to Linux, the other machine needs to be
>> re-installed and CYGWIN 1.5 is no longer available for download.
>> 
>> I can confirm that Ramsays patch works with CYGWIN 1.7 32 Bit.
>
> Thanks!

Thanks.  So the unconditional version of the patch is good to go, I
take?
