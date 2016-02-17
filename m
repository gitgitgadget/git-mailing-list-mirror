From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Wed, 17 Feb 2016 08:39:17 -0800
Message-ID: <xmqqmvqzjnpm.fsf@gitster.mtv.corp.google.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
	<1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
	<CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
	<DC5B6F35-CBB5-4DC4-A875-275BF072AD91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 17:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW58P-00066h-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 17:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423935AbcBQQjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 11:39:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422903AbcBQQjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 11:39:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85DCA3E487;
	Wed, 17 Feb 2016 11:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sNrL8iAyjhSPl1QnntXNAgWZgSU=; b=CnfSf5
	7Lt80djjgBJysNFnGgbXHOPZL1uyNMUO/CeuOJT6N6cE8lQA7Py5/CZSlppjqLZn
	pgH186ceHuM1mtaCHnU3HQsRYTwNx5aZdwnW9Dzm4m6X/QhW1snII2egT79VUTBT
	mFHcMeO+6M/P7/O86ttCAkep3gNt/6clKxgwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyZnACiHXd4MgpJvW5JoHBbcAb6GXvkt
	HODAxzcqkk+IIXp3XrVNr5WrlKu9NivNHomtzmEOTj8PtnWDqUIgfckVZWDw6I4P
	yVov1nwk3BSP9RldIFNGScGsDsgLUP+J4tlxmaodBqWL4u89kJGRClnxmWzE/jhQ
	rBq80VFhg2w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D38C3E486;
	Wed, 17 Feb 2016 11:39:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0AEB3E485;
	Wed, 17 Feb 2016 11:39:18 -0500 (EST)
In-Reply-To: <DC5B6F35-CBB5-4DC4-A875-275BF072AD91@gmail.com> (Lars
	Schneider's message of "Wed, 17 Feb 2016 09:32:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD913472-D594-11E5-A816-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286510>

Lars Schneider <larsxschneider@gmail.com> writes:

>> There is no need for this patch series to address this anomaly; it's
>> perhaps low-hanging fruit for someone wanting to join the project. The
>> only very minor wrinkle is that we'd still need to recognize --null as
>> a deprecated (and undocumented) alias for --nul.
>
> Does the list have a place to document these ideas for newbies to be found?

I do not know of one offhand, but if somebody (or like-minded group
of people) starts to collect one, I am sure it would be very much
appreciated.

A search for "low hanging fruit" and "hint hint" in the list archive
used to work well as a first-order approximation; using these
keywords takes conscious effort on those who write them, though ;-).
