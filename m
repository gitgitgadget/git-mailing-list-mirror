From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 09:55:03 -0800
Message-ID: <7veia0rrew.fsf@alter.siamese.dyndns.org>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
 <1291230820.11917.25.camel@drew-northup.unet.maine.edu>
 <877hftuvvz.fsf@picasso.cante.net> <7vfwuhtafr.fsf@alter.siamese.dyndns.org>
 <AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
 <87sjygspgy.fsf@picasso.cante.net> <buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
 <87bp54s770.fsf@picasso.cante.net> <87mxoos4a8.fsf@catnip.gol.com>
 <20101202132053.GF6537@picasso.cante.net> <m262vcqdb9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jari <jari.aalto@cante.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:55:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODNM-0001AM-Ot
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911Ab0LBRzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:55:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0LBRzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:55:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 819FC3C03;
	Thu,  2 Dec 2010 12:55:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3j2QLWtDjL24YDOx1XGxRJkfoA=; b=hUnidT
	XifZ8RgRfYtUCBb9lTJ5rld9MsAN6AQtVSGYOMjx4KJNrMVIc3uIecDw2Lkj5QIF
	m8IRzb5Ohfi6wrqcFcwK+N2i/tqnoIItvaP69humYKdApMSUmOSKEgUY6qwDcOvt
	1qrVLsAgQqCSxvkHSQjnsfbQrWWvxKfaL1lHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dwHgxueXC3VcQ9uZrvB37UtxvYqNkaaI
	NmqCG4Sgl3rAdw/3HW9iLYahSfkyPZuwhIrQr/NmCX3YKaNXgf6pYuZqygfa6lxK
	JrCIIRmxSArY2XKpRy+Tn81V6JojTFJfXiHDU77FHW9C8wUzI60LUGS90Ux523eN
	6UT3jS7Pysk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 324B03C02;
	Thu,  2 Dec 2010 12:55:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C80E73C01; Thu,  2 Dec 2010
 12:55:25 -0500 (EST)
In-Reply-To: <m262vcqdb9.fsf@igel.home> (Andreas Schwab's message of "Thu\,
 02 Dec 2010 18\:44\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AA59BF6-FE3D-11DF-A71E-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162721>

Andreas Schwab <schwab@linux-m68k.org> writes:

> jari <jari.aalto@cante.net> writes:
>
>> Not that it matters, but have you happende to notice that all git
>> outputs use
>>
>>     commit~N
>>
>> notation. Not the
>>
>>     commit^
>
> Did you try "git show-branch -a" recently?

Perhaps we need to also fix "git name-rev master^" which currently does
not try to reduce "master~1" to "master^".
