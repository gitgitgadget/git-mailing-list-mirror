From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 02 Mar 2016 00:51:51 -0800
Message-ID: <xmqqsi0945zs.fsf@gitster.mtv.corp.google.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
	<vpqvb56yltc.fsf@anie.imag.fr>
	<xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com>
	<56D67793.5080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:51:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2Vj-00084G-D4
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcCBIvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:51:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbcCBIvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:51:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BF6840D49;
	Wed,  2 Mar 2016 03:51:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3LDq/YfrOU9vTikm/nXcjvUOHWg=; b=ee8fGS
	2QgebRZxnAe1UJg2NrUTxXK5wkNk5GFBKueUe/v5LrEfHbBYgkMQdXr70B2/p2FA
	WKxxcLLAkY7EWELqbsiA0wwEQWp59F71ZnD9sWRw4dumSgUXMewZq8muzy5oKtdB
	h+yeYi+Xwr4/pTzhwI1dEVVrQcJXFhjLQ/06E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PwLoCIbDKiPT59By119lvGu0HjVnWTRD
	R3/XoeIk10V4aVOoVisLzfw/g644QwhwI4+MWN5RaDWYQpCw/fd4ggzSUlLbAyhG
	05qmD5yj2KzxTIGFh4/Vy398HWVSk630c0yUfF5+tQss5vtP356Xr/f8EQfptVDA
	rPQ4YpYZfrw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7206D40D47;
	Wed,  2 Mar 2016 03:51:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB6EA40D46;
	Wed,  2 Mar 2016 03:51:52 -0500 (EST)
In-Reply-To: <56D67793.5080308@gmail.com> (Sidhant Sharma's message of "Wed, 2
	Mar 2016 10:48:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 026BF206-E054-11E5-B2CB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288110>

Sidhant Sharma <tigerkid001@gmail.com> writes:

>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Thanks. This version looks good to me.
>> I'll queue this with your "Reviewed-by:" to 'pu', just as a
>> Microproject reward ;-).  Given that the program will never see an
>> interactive use from a command line, however, I am not sure if it is
>> worth actually merging it down thru 'next' to 'master'.

Having said that, the resulting code looks more modular in that
adding a new option or extending the behaviour of an existing option
may be easier with the patch going forward, so after all we might
be better off taking it to the production.  I'll think about it a
bit more and decide.

Thanks.
