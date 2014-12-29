From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/1] http: Add Accept-Language header if possible
Date: Mon, 29 Dec 2014 08:18:15 -0800
Message-ID: <xmqqegri1lbs.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
	<1419266658-1180-1-git-send-email-eungjun.yi@navercorp.com>
	<1419266658-1180-2-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cQZG3gWEw8_HHHvP6EDLKkf-nMZLwkE4OF9hwNX72wgXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 17:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5d1S-0006Mx-V3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 17:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaL2QST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 11:18:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL2QSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 11:18:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58C34289BC;
	Mon, 29 Dec 2014 11:18:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C7DWKN6SzbldZ2i+n3UzjVWg9gk=; b=Dx2HGi
	s7YQ7JCPnno44xkzdUpTEv2XG+tBRpy1bF6auLUqvO5UYVSQR65ZU8UhAUvLA6Uh
	fKPamZtOkxQqendPqWbxYRIR2dAfM/Re3EzQfGJzLpBb9zGVL9nLYgVqggDjnszE
	oZ0qvxgbsDzcOoUCqLZoAm5p4CwNCNjOCFTQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+CPTlWAu1Ayj5mi2Xphp5K8my1ATwwP
	c7CoR4JM3HqGs6C9VwFTX3ra7vI/rGY7GUyf2I2ZsJN/j0YhDDyHf96IX+8LCZBq
	dIwgFZr4l36i6a+U+ZsRv0NwpEG2zG80E/3rHXvfIg8Sn5ffHXOOkiHyYi4NktcB
	sfH1Y5+YfzQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A055289BB;
	Mon, 29 Dec 2014 11:18:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57ADB289BA;
	Mon, 29 Dec 2014 11:18:16 -0500 (EST)
In-Reply-To: <CAPig+cQZG3gWEw8_HHHvP6EDLKkf-nMZLwkE4OF9hwNX72wgXw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 24 Dec 2014 15:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B828106-8F76-11E4-8083-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261863>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Just a few comments and observations below. Alone, they are not
> necessarily worth a re-roll, but if you happen to re-roll for some
> other reason, perhaps take them into consideration.

I actually think everything you said in this review makes sense and
will make the resulting code a lot better (especially the part on
the parsing loop).

Thanks, as usual, for a careful reading.
