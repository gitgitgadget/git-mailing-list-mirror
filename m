From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Mon, 09 Feb 2015 10:23:33 -0800
Message-ID: <xmqqy4o7aqqi.fsf@gitster.dls.corp.google.com>
References: <20150207131112.394.30858.chriscool@tuxfamily.org>
	<xmqq386hcw33.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:23:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKszr-00063p-MO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814AbbBISXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:23:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933560AbbBISXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:23:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5EA8367C6;
	Mon,  9 Feb 2015 13:23:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMjzRykigUjPLmY5MhFMmbe0T7E=; b=n/ysjd
	KKNnYFkiWGfvE8bFrnHTNKezwEndF2/c7mJrGczP65pXS7y2BcaFW23wbTgJuxHy
	wuqHw0A6JdnGme8fU2Rw6IpCWnOIFPPZlMI2IozZiyWQt6zmyoXWcNsGiGMPeKe/
	ECylX5uN4Aklbe+bYqnmaacp9bqh3YD28CAnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0jX6fwc5Yn8JrJjHFrkxwM13VE/ZxuN
	RPtL2LlE4osRfXKsi8kgJeSQ/rmL/QA0FmwioL0BxKml8OsfFnfnf+mEbloS8oQD
	PnXDaDmAjgCMJSoobjWcoPqOnq9s6u9leHYdvyBKfjN27oc3JPVULeTrVg4HjwkV
	sfEfk2glU8M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4728367C4;
	Mon,  9 Feb 2015 13:23:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E999367C2;
	Mon,  9 Feb 2015 13:23:34 -0500 (EST)
In-Reply-To: <CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
	(Christian Couder's message of "Sat, 7 Feb 2015 23:19:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1E9B426-B088-11E4-B4B5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263573>

Christian Couder <christian.couder@gmail.com> writes:

> It is not designed like this because you only asked me to design it
> like this after the facts, when there was another email thread about
> conflicts blocks and one function you created could be used by the
> trailer code too.
>
> If you had asked this from the beginning I would certainly have done...

Because the process here is not somebody outlines the design and
gives it to laborer to implement, "after the fact" and "from the
beginning" are complaining to and asking for impossible.  You design
and implement and then it gets reviewed, not the other way around.
